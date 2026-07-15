#!/bin/bash
#SBATCH -J qc
#SBATCH -p defq
#SBATCH --mem=8G
#SBATCH -t 8:00:00
#SBATCH -o /mnt/data/amedina/ssalazar/rna/logs/qc2_%j.out
#SBATCH -e /mnt/data/amedina/ssalazar/rna/logs/qc2_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sogusama02@gmail.com

module load anaconda3/2025.06
conda activate /mnt/data/amedina/ssalazar/envs/rna_env

cd /mnt/data/amedina/ssalazar/rna
mkdir -p quality2
mkdir -p quality2
for file in TRIM_results/*_trimmed.fq.gz; do
  base=$(basename "$file" _trimmed.fq.gz)
  out="quality2/${base}_trimmed_fastqc.html"
  if [ -f "$out" ]; then
    echo "Skipping $file — output already exists: $out"
  else
    fastqc "$file" -o quality2/
  fi
done