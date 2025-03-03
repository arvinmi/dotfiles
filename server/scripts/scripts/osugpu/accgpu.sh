#!/bin/bash

# detect the current submit node
SUBMIT_NODE=$(hostname)
SBATCH_SCRIPT="${HOME}/dotfiles/server/scripts/scripts/osugpu/startgpu.sbatch"
ONID="mirtoraa"
# change this if port can't be used
JUPYTER_PORT=8096

# check for an active slurm job
JOB_INFO=$(squeue -u $ONID -o "%A %N" | tail -n 1)
JOB_ID=$(echo "$JOB_INFO" | awk '{print $1}')
COMPUTE_NODE=$(echo "$JOB_INFO" | awk '{print $2}')

if [[ "$JOB_ID" =~ ^[0-9]+$ ]]; then
    echo "Found active SLURM job: $JOB_ID on compute node: $COMPUTE_NODE"
    echo "Skipping job submission."
else
    echo "No active jobs found. Submitting SLURM job..."
    JOB_ID=$(sbatch $SBATCH_SCRIPT | awk '{print $4}')
    if [ -z "$JOB_ID" ]; then
        echo "Failed to submit SLURM job."
        exit 1
    fi
    echo "Submitted SLURM job with ID: $JOB_ID"

    # wait for job to be assigned to a compute node
    echo "Waiting for compute node allocation..."
    while true; do
        COMPUTE_NODE=$(squeue -j $JOB_ID -o "%N" | tail -n 1)
        if [[ "$COMPUTE_NODE" != "NODELIST" && -n "$COMPUTE_NODE" ]]; then
            break
        fi

        sleep 5
    done
    echo "Job assigned to compute node: $COMPUTE_NODE"
fi

# set up ssh connection and port forwarding for jupyter notebook
echo "Setting up SSH connection and forwarding port $JUPYTER_PORT for Jupyter Notebook..."
ssh -L $JUPYTER_PORT:localhost:$JUPYTER_PORT $ONID@$COMPUTE_NODE
