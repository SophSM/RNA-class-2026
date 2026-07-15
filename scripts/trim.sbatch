#!/bin/bash
#SBATCH -J trim
#SBATCH -p defq
#SBATCH --cpus-per-task=8
#SBATCH --mem=5G
#SBATCH -t 24:00:00
#SBATCH -o /mnt/data/amedina/ssalazar/rna/logs/trim_%j.out
#SBATCH -e /mnt/data/amedina/ssalazar/rna/logs/trim_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sogusama02@gmail.com
#SBATCH --array=0-12%4
mkdir -p /mnt/data/amedina/ssalazar/rna/TRIM_results
cd /mnt/data/amedina/ssalazar/rna/data/
module load trimmomatic/0.33
samples=(*_1.fastq.gz) # array
i="${samples[$SLURM_ARRAY_TASK_ID]}" # take 1 of the objects
base="${i%_1.fastq.gz}"
echo "Processing sample: $base"

out1="../TRIM_results/${base}_1_trimmed.fq.gz"
out2="../TRIM_results/${base}_2_trimmed.fq.gz"

if [ -f "$out1" ] && [ -f "$out2" ]; then
  echo "Skipping $base — trimmed outputs already exist."
else
  trimmomatic PE \
    -threads $SLURM_CPUS_PER_TASK \
    -phred33 \
    "${base}_1.fastq.gz" \
    "${base}_2.fastq.gz" \
    "$out1" \
    "../TRIM_results/${base}_1_unpaired.fq.gz" \
    "$out2" \
    "../TRIM_results/${base}_2_unpaired.fq.gz" \
    ILLUMINACLIP:NexteraPE-PE.fa:5:10:5 \
    LEADING:3 \
    TRAILING:3 \
    SLIDINGWINDOW:4:20 \
    MINLEN:80
fi

