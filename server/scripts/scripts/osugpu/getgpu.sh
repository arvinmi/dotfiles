#!/bin/bash

# load slurm env
source /etc/profile

# get the compute node
NODE=$(squeue -u mirtoraa -o "%N" | tail -n 1)

# if node exists, print it
if [[ -n "$NODE" ]]; then
    echo "$NODE"
else
    echo "No active SLURM job found" >&2
    exit 1
fi
