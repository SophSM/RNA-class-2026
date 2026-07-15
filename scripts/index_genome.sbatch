#!/bin/bash
#SBATCH -J star_index
#SBATCH -p defq
#SBATCH --cpus-per-task=16
#SBATCH --mem=40G
#SBATCH -t 24:00:00
#SBATCH -o /mnt/data/amedina/ssalazar/rna/logs/star_index_%j.out
#SBATCH -e /mnt/data/amedina/ssalazar/rna/logs/star_index_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sogusama02@gmail.com

cd /mnt/data/amedina/ssalazar

module load star/2.7.11a

gunzip -k rna/data/GRCh38.primary_assembly.genome.fa.gz

mkdir -p rna/STAR_index

STAR \
  --runThreadN $SLURM_CPUS_PER_TASK \
  --runMode genomeGenerate \
  --genomeDir rna/STAR_index \
  --genomeFastaFiles rna/data/GRCh38.primary_assembly.genome.fa \
  --sjdbGTFfile rna/data/gencode.v44.primary_assembly.annotation.gtf \
  --sjdbOverhang 149