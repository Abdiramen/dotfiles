#!/usr/bin/env python3
import argparse
import sys
import datetime
import glob
import os
import re

arg_parser = argparse.ArgumentParser()
arg_parser.add_argument("wiki_path")
args = arg_parser.parse_args()

template = """= {date} =
{file_link}

== Daily checklist ==
- [ ] review interview doc: [[vfile:/home/vimto/git/interviews/notes/interviews.md]]
- [ ] review algo/ds basics: [[vfile:/home/vimto/git/interviews/notes/ds_algos/todo.md]]
- [ ] Note what was completed since the last entry

== Todo ==

== Done ==

== Notes =="""

date = datetime.date.today()
dir_path = args.wiki_path + '/diary/'
files = filter(os.path.isfile, glob.glob(dir_path + '*'))
# fallback to diary index file
file_link = "[[diary.wiki|diary index]]"

if files:
    # sort files by time created acending
    files = sorted(files, key=os.path.getctime)
    # clean file paths before applying regex
    files = [f.replace(dir_path, '') for f in files]

    # only take files with date names
    reg_parser = re.compile("[0-9]+(-)[0-9]{1,2}(-)[0-9]{1,2}(.)wiki")
    files = [s for s in files if reg_parser.match(s)]
    # Gets last diary entry
    file = files.pop()
    file_link = f"[[{file}|previous entry]]"
   
# Generate wiki file content
print(template.format(date=date, file_link=file_link))
