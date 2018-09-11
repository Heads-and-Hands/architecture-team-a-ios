#!/bin/sh

#git archive --remote=http://bittracker.org/someproject.git HEAD:<path/to/directory/or/file> <filename> | tar -x

NEW_APP_NAME="NewAppName"
OLD_APP_NAME="HHModule"
XCODE_TEMPLATES_PATH="/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates/HHTemplates"

echo "${OLD_APP_NAME}"
echo "${NEW_APP_NAME}"

rm -rf architecture-team-a-ios

if ! [ -x "$(command -v git)" ]; then
    echo "Error: the next dependency requred, but not installed: git."
    exit 1
fi

git clone git@github.com:Heads-and-Hands/architecture-team-a-ios.git

cd architecture-team-a-ios

rm -rf .git

if ! [ -x "$(command -v ack)" ]; then
    echo "Error: the next dependency requred, but not installed: ack. Use 'brew install rename ack' to install."
    exit 1
fi

OUTPUT="$(find . -name ${OLD_APP_NAME}*)"
echo "${OUTPUT}"

while [ ! -z "${OUTPUT}" ]; do
    find . -name "${OLD_APP_NAME}*" -print0 | xargs -0 rename --subst-all ${OLD_APP_NAME} ${NEW_APP_NAME}
    OUTPUT="$(find . -name ${OLD_APP_NAME}*)"
done

OUTPUT="$(ack --literal ${OLD_APP_NAME})"
echo "${OUTPUT}"

while [ ! -z "${OUTPUT}" ]; do
    ack --literal --files-with-matches "${OLD_APP_NAME}" --print0 | xargs -0 sed -i '' "s/${OLD_APP_NAME}/${NEW_APP_NAME}/g"
    OUTPUT="$(ack --literal ${OLD_APP_NAME})"
done

git init

#fastlane produce

#fastlane match development
#fastlane match appstore