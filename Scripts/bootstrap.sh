#!/bin/bash

#git archive --remote=http://bittracker.org/someproject.git HEAD:<path/to/directory/or/file> <filename> | tar -x

# PARAMETERS

APP_NAME="$1"
PROJECT_GIT_REPO="$2"

if [ -z "${APP_NAME}" ]; then
    APP_NAME="NewAppName"
fi

# ENVIRONMENTS

LOG_FILE="bootstrap.log.txt"

TEMPLATE_PROJECT_GIT_REPO_PATH="https://github.com/Heads-and-Hands/template-project-ios.git"
TEMPLATE_PROGECT_TEMPLATE_SUBPATH="branches/master"
TEMPLATE_PROJECT_DIRECTORY="$(echo ${TEMPLATE_PROGECT_TEMPLATE_SUBPATH} | awk -F '/' '{print $NF}')"

XCODE_TEMPLATES_PATH="/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates"
XCODE_TEMPLATES_GIT_REPO_PATH="https://github.com/Heads-and-Hands/architecture-team-a-ios.git"
XCODE_TEMPLATES_REMOTE_SUBPATH="branches/develop/HHTemplates"
XCODE_TEMPLATES_REMOTE_NAME="$(echo ${XCODE_TEMPLATES_REMOTE_SUBPATH} | awk -F '/' '{print $NF}')"

NEW_APP_NAME="$(echo ${APP_NAME} | awk '{print tolower($0)}')"

BREW_DEPENDENCIES=("svn" "mint" "ack" "node" "rename" "swiftgen" "swiftlint" "git" "git-flow" "carthage" "gpg")

# FASTLANE ENVIRONMENTS

PRODUCE_USERNAME="handh.ci@gmail.com"
PRODUCE_APP_IDENTIFIRE="ru.handh.${NEW_APP_NAME}"
PRODUCE_APP_NAME="${NEW_APP_NAME}"
MATCH_FILE_URL="git@github.com:Heads-and-Hands/certs-ios.git"

# ENVIRONMENT FOR PROVISION PROFICLE COPY

DEBUG_PROFILE_SPECIFIER="match Development ru.handh.${NEW_APP_NAME}"
RELEASE_PROFILE_SPECIFIER="match AppStore ru.handh.${NEW_APP_NAME}"
INTERNAL_PROFILE_SPECIFIER="match Development ru.handh.${NEW_APP_NAME}"

DEVELOPMENT_TEAM="X86NQK83T7"

CODE_SIGN_IDENTITY="iPhone Distribution"

title() {
    local TEXT="$1"
    echo ""
    echo "$(tput setaf 2)"$TEXT"$(tput sgr 0)"
    echo "$TEXT" >> "$LOG_FILE"
}

error() {
    local TEXT="$1"
    echo ""
    echo "$(tput setaf 1)"$TEXT"$(tput sgr 0)"
    echo "$TEXT" >> "$LOG_FILE"
}

message() {
    local TEXT="$1"
    echo "$(tput setaf 2)"$TEXT"$(tput sgr 0)"
    echo "$TEXT" >> "$LOG_FILE"
}

echo "" > "$LOG_FILE"

title "BOOTSTRAP.SH"
title "CHECK DEPENDENCIES"

check_dependency() {
    RETVAL="True"
    local DEPENDENCY="$1"
    local DEPENDENCY_NAME="$2"

    if [ -z "${DEPENDENCY_NAME}" ]; then 
        local DEPENDENCY_NAME="${DEPENDENCY}"
    fi
    
    if ! [ -x "$(command -v ${DEPENDENCY})" ]; then
        RETVAL="False"
        echo "$(tput setaf 6)Error: the next dependency requred, but not installed:$(tput sgr 0) $(tput setaf 4)"${DEPENDENCY_NAME}"$(tput sgr 0)."
        echo "Error: the next dependency requred, but not installed: "${DEPENDENCY_NAME}"." >> "$LOG_FILE"
    fi

    if [ "${RETVAL}" == 'True' ]; then 
        echo "Find dependency $(tput setaf 4)"${DEPENDENCY_NAME}"$(tput sgr 0)"
        echo "Find dependency "${DEPENDENCY_NAME}"" >> "$LOG_FILE"
    fi
}

check_brew_dependency() {
    local DEPENDENCY="$1"
    local STATUS='ok'
    echo -n "Check dependency $(tput setaf 2)"${DEPENDENCY}"$(tput sgr 0): "

    if ! [ -x "$(command -v ${DEPENDENCY})" ]; then
        local STATUS="empty"
    fi

    for item in $(brew outdated); do
        if [ "${item}" == "${DEPENDENCY}" ]; then
            local STATUS='outdated'
        fi
    done

    if [ "${STATUS}" == 'outdated' ]; then 
        echo "$(tput setaf 6)Needs update$(tput sgr 0)"
        echo "Check dependency "${DEPENDENCY}": outdated" >> "$LOG_FILE"
        message "Updating "${DEPENDENCY}"..."
        brew upgrade "${DEPENDENCY}" >> "$LOG_FILE"
    elif [ "${STATUS}" == 'empty' ]; then
        echo "$(tput setaf 6)Not installed$(tput sgr 0)"
        echo "Check dependency "${DEPENDENCY}": empty" >> "$LOG_FILE"
        message "Installing "${DEPENDENCY}"..."
        brew install "${DEPENDENCY}" >> "$LOG_FILE"
    else 
        echo "$(tput setaf 4)Ok$(tput sgr 0)"
        echo "Check dependency "${DEPENDENCY}": Ok" >> "$LOG_FILE"
    fi
}

check_dependency brew
if [ "${RETVAL}" != "True" ]; then
     exit 1
else
    message "Update brew..."
    brew update
fi

for item in "${BREW_DEPENDENCIES[@]}"; do
    check_brew_dependency "${item}"
done

title "FETCH REMOTE REPOSITORY TEMPLATE"

message "Remove porject directory if exists: ${NEW_APP_NAME}"
rm -rfv "${NEW_APP_NAME}" >> "$LOG_FILE"

message "Clone remote project template ${TEMPLATE_PROJECT_GIT_REPO_PATH}/${TEMPLATE_PROGECT_TEMPLATE_SUBPATH} ..."
OUTPUT="$(svn ls ${TEMPLATE_PROJECT_GIT_REPO_PATH}/${TEMPLATE_PROGECT_TEMPLATE_SUBPATH})"

if [ ! -z "${OUTPUT}" ]; then
    svn export "${TEMPLATE_PROJECT_GIT_REPO_PATH}/${TEMPLATE_PROGECT_TEMPLATE_SUBPATH}" >> "$LOG_FILE"
fi

message "Rename ${TEMPLATE_PROJECT_DIRECTORY} to ${NEW_APP_NAME}"
mv -v "${TEMPLATE_PROJECT_DIRECTORY}" "${NEW_APP_NAME}" >> "$LOG_FILE" 
cd "${NEW_APP_NAME}"

OLD_LOG="${LOG_FILE}"
LOG_FILE="../${LOG_FILE}"

message "Remove 'git' if exists"
rm -rfv git >> "$LOG_FILE"

while read fname; do
    RESULT="$(echo "$fname" | awk -F'/' '{print $NF}' | awk -F'.' '{ s = ""; for (i = 1; i < NF; i++) s = s $i "."; print s }')"
    PROJECT_TEMPLATE_NAME="$(echo "${RESULT}" | awk '{print substr($0, 1, length($0)-1)}')"
done < <(find . -name "*.xcodeproj")

if [ -z "${PROJECT_TEMPLATE_NAME}" ]; then
    error "Error: Project file does not found"
    exit 1
fi

title "RENAME PROJECT TEMPLATES FILES"

message "Rename project template files..."

OUTPUT="$(find . -name "${PROJECT_TEMPLATE_NAME}*")"

while [ ! -z "${OUTPUT}" ]; do
    echo "$OUTPUT" >> "${LOG_FILE}"
    find . -name "${PROJECT_TEMPLATE_NAME}*" -print0 | xargs -0 rename --subst-all "${PROJECT_TEMPLATE_NAME}" "${NEW_APP_NAME}" >> "${LOG_FILE}"
    OUTPUT="$(find . -name "${PROJECT_TEMPLATE_NAME}*")"
done

message "Rename project template files content..."
OUTPUT="$(ack --literal ${PROJECT_TEMPLATE_NAME})"

while [ ! -z "${OUTPUT}" ]; do
    ack --literal --files-with-matches "${PROJECT_TEMPLATE_NAME}" --print0 | xargs -0 sed -i '' "s/${PROJECT_TEMPLATE_NAME}/${NEW_APP_NAME}/g" >> "${LOG_FILE}"
    OUTPUT="$(ack --literal ${PROJECT_TEMPLATE_NAME})"
done

CAPITALIZED_NEW_APP_NAME="$(echo ${NEW_APP_NAME} | awk '{print toupper(substr($1,1,1)) substr($1,2)}')"
CAPITALIZED_PROJECT_TEMPLATE_NAME="$(echo ${PROJECT_TEMPLATE_NAME} | awk '{print toupper(substr($1,1,1)) substr($1,2)}')"

OUTPUT="$(ack --literal ${CAPITALIZED_PROJECT_TEMPLATE_NAME})"

while [ ! -z "${OUTPUT}" ]; do
    ack --literal --files-with-matches "${CAPITALIZED_PROJECT_TEMPLATE_NAME}" --print0 | xargs -0 sed -i '' "s/${CAPITALIZED_PROJECT_TEMPLATE_NAME}/${CAPITALIZED_NEW_APP_NAME}/g" >> "${LOG_FILE}"
    OUTPUT="$(ack --literal ${CAPITALIZED_PROJECT_TEMPLATE_NAME})"
done

title "UPDATE BUNDLE"

check_dependency bundler
if [ "${RETVAL}" != "True" ]; then
    error "Use 'gem install bundler' to install"
    exit 1
fi

message "Bundler update..."

bundler update >> "${LOG_FILE}"

title "SWIFTLINT CONFIGURATION"

if which mint >/dev/null; then
    message "Mint install 'swiftlint'..."
    mint run realm/swiftlint >> "$LOG_FILE"
    VERSION="$(swiftlint version)"
    message "Writing 'Mintfile'"
    echo "realm/swiftlint@${VERSION}" > Mintfile
fi

title "FASTLANE CONFIGURATION"

bundle exec fastlane produce # --skip_itc
bundle exec fastlane match development # --readonly
bundle exec fastlane match appstore # --readonly

title "GIT CONFIGURATION"
message "Initializing 'git' repository..."

git init
git add .
git commit -S -m "Initial commit"

message "Initializing 'git-flow'..."
if which git-flow >/dev/null; then
   git-flow init -fd >> "$LOG_FILE"
fi

if ! [ -z "${PROJECT_GIT_REPO}" ]; then
    git remote add origin "${PROJECT_GIT_REPO}"
    git push --set-upstream origin master
    git push --set-upstream origin develop
fi

title "COPY PROVISION PROFILE"

cd "${NEW_APP_NAME}.xcodeproj"

python ../../profiles.py -t "${DEVELOPMENT_TEAM}" -d "${DEBUG_PROFILE_SPECIFIER}" -r "${RELEASE_PROFILE_SPECIFIER}" -i "${CODE_SIGN_IDENTITY}"

cd ..
cd ..

LOG_FILE="${OLD_LOG}"

title "FETCH XCODE TEMPLATES"

rm -rf "${XCODE_TEMPLATES_REMOTE_NAME}"

message "Clone remote project template ${XCODE_TEMPLATES_GIT_REPO_PATH}/${XCODE_TEMPLATES_REMOTE_SUBPATH}"
OUTPUT="$(svn ls ${XCODE_TEMPLATES_GIT_REPO_PATH}/${XCODE_TEMPLATES_REMOTE_SUBPATH})"
if [ ! -z "${OUTPUT}" ]; then
    svn export "${XCODE_TEMPLATES_GIT_REPO_PATH}/${XCODE_TEMPLATES_REMOTE_SUBPATH}" >> "${LOG_FILE}"
fi

mv -fv "${XCODE_TEMPLATES_REMOTE_NAME}" ""${NEW_APP_NAME}"/" >> "${LOG_FILE}"
