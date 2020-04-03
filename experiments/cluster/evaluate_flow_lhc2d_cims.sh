#!/bin/bash

#SBATCH --job-name=e-sf-l2d
#SBATCH --output=log_evaluate_flow_lhc2d_%a.log
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64GB
#SBATCH --time=2-00:00:00
# #SBATCH --gres=gpu:1

conda activate ml
export PATH="/home/brehmer/miniconda3/envs/ml/bin/:$PATH"
export OMP_NUM_THREADS=1
dir=/home/brehmer/manifold-flow
cd $dir/experiments

run=$((SLURM_ARRAY_TASK_ID / 12))
task=$((SLURM_ARRAY_TASK_ID % 12))
chain=$((task / 3))
true=$((task % 3))
echo "SLURM_ARRAY_TASK_ID = ${SLURM_ARRAY_TASK_ID}, true = ${true}, chain = ${chain}, run = ${run}"

python -u evaluate.py -c cluster/configs/evaluate_lhc_may.config --dataset lhc2d --modellatentdim 2 --modelname may --algorithm flow -i $run --trueparam $true --chain $chain --dir $dir
