#!/usr/bin/env python3

from subprocess import Popen, DEVNULL
from sys import argv

Popen(argv[1], stdout=DEVNULL, stderr=DEVNULL)
