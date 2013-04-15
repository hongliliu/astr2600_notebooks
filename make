#!/usr/bin/env python

import sys
import os
import shutil
import argparse

input = sys.argv[1]
if 'html' in input:
    ipynb = input.replace("html","ipynb")
    html = input
elif 'ipynb' in input:
    html = input.replace("ipynb","html")
    ipynb = input
else:
    raise Exception

print ('python ~/repos/nbconvert/nbconvert2.py reveal %s > %s' % (ipynb,html))
notOK = os.system('python ~/repos/nbconvert/nbconvert2.py reveal %s > %s' % (ipynb,html))
if notOK: raise Exception
shutil.copy(html,'/var/tmp/')
os.remove(html)
notOK = os.system('git checkout gh-pages')
if notOK: raise Exception
shutil.copy('/var/tmp/%s' % html,'.')
notOK = os.system('git add %s' % html)
if notOK: raise Exception
notOK = os.system('git commit -m "%s added/updated"' % html)
if notOK: raise Exception
notOK = os.system('git push')
if notOK: raise Exception
notOK = os.system('git checkout master')
if notOK: raise Exception
