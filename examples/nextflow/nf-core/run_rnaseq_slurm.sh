#!/bin/bash
#SBATCH --job-name=nf-rnaseq
#SBATCH --partition=day
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=4G
#SBATCH --output=rnaseq_%j.out

# This script submits a Slurm batch job that acts as the Nextflow head node.
# The head process is lightweight: it orchestrates the pipeline and submits
# each task as a separate Slurm job.
#
# See nextflow.config for the execution strategy: heavy steps run on Slurm,
# lightweight steps (e.g. MultiQC) run locally on the head node.
#
# Usage: sbatch run_rnaseq_slurm.sh

module load Nextflow/24.10.2

nextflow run nf-core/rnaseq -r 3.14.0 \
    -profile test,apptainer \
    -c nextflow.config \
    --outdir output \
    -with-report rnaseq.html
