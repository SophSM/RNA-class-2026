#!/bin/bash
#SBATCH -J download
#SBATCH -p defq
#SBATCH --mem=8G
#SBATCH -t 48:00:00
#SBATCH -o /mnt/data/amedina/ssalazar/rna/logs/download_%j.out
#SBATCH -e /mnt/data/amedina/ssalazar/rna/logs/download_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sogusama02@gmail.com

cd /mnt/data/amedina/ssalazar/rna/scripts
bash download_fastq.sh