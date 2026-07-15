#!/bin/bash
#SBATCH -J qc
#SBATCH -p defq
#SBATCH --mem=8G
#SBATCH -t 24:00:00
#SBATCH -o /mnt/data/amedina/ssalazar/rna/logs/qc_%j.out
#SBATCH -e /mnt/data/amedina/ssalazar/rna/logs/qc_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sogusama02@gmail.com

module load anaconda3/2025.06
conda activate /mnt/data/amedina/ssalazar/envs/rna_env

cd /mnt/data/amedina/ssalazar/rna
mkdir -p quality1

for file in data/*.fastq.gz; do
  base=$(basename "$file" .fastq.gz)
  out="quality1/${base}_fastqc.html"
  if [ -f "$out" ]; then
    echo "Skipping $file — output already exists: $out"
  else
    fastqc "$file" -o quality1/
  fi
done