#!/bin/bash
#PBS -lwalltime=12:00:00
#PBS -lselect=1:ncpus=1:mem=4gb


module load R

echo "R is about to run"
cd /rds/general/user/yl2524/home/
Rscript Yibin.Li_HPC_2024_neutral_cluster.R
mv neutral_cluster_output_* $HOME/output_file_yl2524/
echo "R has finished running"
