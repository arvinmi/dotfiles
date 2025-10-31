#!/bin/bash
#SBATCH --job-name=intrgpu
#SBATCH --partition=dgxh,dgx2,ampere,preempt,eecs,gpu
#SBATCH --cpus-per-task=2
#SBATCH --mem=32g
#SBATCH --gres=gpu:1
#SBATCH --constraint='h100|h200|a40'
#SBATCH --time=12:00:00
#SBATCH --output=/dev/null
#SBATCH --error=/dev/null

# keep the session open for interactive use
echo "Compute node allocated."
sleep infinity
