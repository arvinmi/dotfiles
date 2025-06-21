#!/bin/bash

current_hour=$(date +%H)

if [[ $current_hour -ge 0 && $current_hour -le 4 ]]; then
    /usr/bin/pmset sleepnow
fi
