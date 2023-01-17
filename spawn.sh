#!/usr/bin/env sh

nohup setsid -f "$@" > /dev/null 2>&1
