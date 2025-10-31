#!/bin/bash
#SBATCH --job-name=intrgpunode
#SBATCH --partition=dgxh,gpu,dgx2
#SBATCH --cpus-per-task=8
#SBATCH --mem=32g
#SBATCH --gres=gpu:2
#SBATCH --constraint='h100|h200|a40|ib'
#SBATCH --time=1-12:00:00
#SBATCH --output=/dev/null
#SBATCH --error=/dev/null

# keep the session open for interactive use
echo "Compute node allocated."
sleep infinity
