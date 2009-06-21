#!/usr/bin/env python

"""
Run all the finished programs in this directory and its children.
"""

from __future__ import print_function
from __future__ import unicode_literals
from __future__ import absolute_import

import os
import re
import subprocess
import timeit

here=os.path.abspath(os.path.dirname(__file__))

for dirpath, dirnames, filenames in os.walk (here):
    if 'unfinished' in dirnames:
        dirnames.remove('unfinished')
    filenames.sort()
    for f in filenames:
        full = os.path.join (dirpath, f)
        if os.path.isfile(full):
            if re.match(r".*[0-9]+\.ss$", full) or re.match(r".*[0-9]+/code\.ss$", full):
                print("{0}: ".format(f), end='')
                seconds = timeit.timeit (lambda : subprocess.call(['mzscheme', full]), number=1)
                print("{0} real seconds".format(seconds))
                print
