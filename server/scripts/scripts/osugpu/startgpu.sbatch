#!/bin/bash
#SBATCH --job-name=intrgpu
#SBATCH --partition=dgxh,dgx2,ampere,preempt,eecs,gpu,gpu-dmv
#SBATCH --cpus-per-task=2
#SBATCH --mem=32g
#SBATCH --gres=gpu:1
#SBATCH --constraint='h100|h200|l40s|a40|v100'
#SBATCH --time=12:00:00
#SBATCH --output=/dev/null
#SBATCH --error=/dev/null

# keep the session open for interactive use
echo "Compute node allocated."
sleep infinity
