#!/usr/local/bin/python
import re, sys, getopt

team_key = 'DEVELOPMENT_TEAM'
profile_key = 'PROVISIONING_PROFILE_SPECIFIER'
code_key = 'CODE_SIGN_STYLE = Manual;'

def build_pattern(name):
    return r'[\t]*.*' + name + '[^;]* = {\n[\s\S]*?name = ' + name + ';\n[\s\S]*?};'

def parameter_pattern(name):
    return name + ' = \".*\"'

def replace(pattern, subst, data):
    return re.sub(pattern, subst, data)

def main(argv):
    try:
        opts, args = getopt.getopt(argv, "t:d:r:i:",["team=, debug-specifier=, release-specifire=, sigh-identity="])
    except getopt.GetoptError:
        print 'profiles.py -t <development team> -d <debug profile specifire> -r <release profile specifire> -i <code sign identity>'
        sys.exit(2)

    team = team_key + ' = '
    debug_specifire = ''
    release_specifire = ''
    code_identity = 'CODE_SIGN_IDENTITY = ' 
    for opt, arg in opts:
        if opt in ("-t", "--team"):
            team = team + arg
        elif opt in ("-d", "--debug-specifier"):
            debug_specifire = arg
        elif opt in ("-r", "--release-specifire"):
            release_specifire = arg
        elif opt in ("-i", "--sigh-identity"):
            code_identity = code_identity + '"' + arg + '";'

    profiles = {
        'Debug': profile_key + ' = ' + '"' + debug_specifire + '"',
        'Release': profile_key + ' = ' + '"' + release_specifire + '"',
        'Internal': profile_key + ' = ' + '"' + debug_specifire + '"'
    }  

    filename = 'project.pbxproj'
    fp = open(filename, 'r+')
    data = fp.read()
    
    for name, profile in profiles.items():
        matches = re.findall(build_pattern(name), data)
        for match in matches:
            result = replace(parameter_pattern(team_key), team, match)
            result = replace(parameter_pattern(profile_key), profile, result)
        
            if name == 'Release':
                result = result.replace(code_key, code_key + '\n\t\t\t\t' + code_identity)
        
            data = data.replace(match, result)
        
    fp.seek(0)
    fp.write(data)
    fp.truncate()
    fp.close()
        
if __name__ == "__main__":
    main(sys.argv[1:])
