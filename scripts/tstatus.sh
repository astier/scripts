#!/usr/bin/env sh

bat=$(cat /sys/class/power_supply/BAT0/capacity)
dat=$(date "+%R")
echo "BAT $bat | $dat"
