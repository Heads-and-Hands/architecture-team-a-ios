import os
import re

base_path = os.curdir + '/Demo/Modules'

directories = filter(lambda path : os.path.isdir(base_path + '/' + path) and 'Story' in path, os.listdir(base_path))
stories = map(lambda x: x.replace("Story", ""), directories)
stories.sort(key=lambda x: len(x), reverse=True)

print(directories)

file_name = base_path + '/' + 'Stories.generated.swift'

file_pointer = open(file_name, 'r+')

def process(name, story):
    result = name.replace(story, '')
    rest = result[1:len(result)]
    first = result[0]
    result = first.lower() + rest
    return result.replace('Configurator', '')

def contain(string, substring):
    return substring in string

rows = []
for line in file_pointer:
    result = re.findall(r'var ([^ ]*) =', line)
    if len(result) > 0:
        rows.append((result[0], line))

data = '// Generated using Sourcery 0.15.0\n'
data = data + '// DO NOT EDIT\n\n'
data = data + 'import HHModule\n\n'
processed = []
for story in stories:
    data = data + 'internal struct ' + story + 'Story: ARCHModuleID {\n'
    for row in rows:
        if (row not in processed) and row[0].startswith(story):
            data = data + row[1].replace(row[0], process(row[0], story), 1)
            processed.append(row)
    
    data = data + '}\n'

print(data)

file_pointer.seek(0)
file_pointer.write(data)
file_pointer.truncate()
file_pointer.close()