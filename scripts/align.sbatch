#!/bin/bash
#SBATCH -J star_align
#SBATCH -p defq
#SBATCH --cpus-per-task=12
#SBATCH --mem=35G
#SBATCH -t 24:00:00
#SBATCH -o /mnt/data/amedina/ssalazar/rna/logs/star_align_%A_%a.out
#SBATCH -e /mnt/data/amedina/ssalazar/rna/logs/star_align_%A_%a.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sogusama02@gmail.com
#SBATCH --array=0-12%4

cd /mnt/data/amedina/ssalazar/rna/

module load star/2.7.11a

INDEX=STAR_index
TRIM_DIR=TRIM_results
OUT_DIR=STAR_output
mkdir -p $OUT_DIR

# Build array of samples based on trimmed R1 files
samples=($TRIM_DIR/*_1_trimmed.fq.gz)
f="${samples[$SLURM_ARRAY_TASK_ID]}"
base=$(basename "$f" _1_trimmed.fq.gz)

echo "Alineando: $base"
STAR \
  --runThreadN $SLURM_CPUS_PER_TASK \
  --genomeDir $INDEX \
  --readFilesIn "$f" "$TRIM_DIR/${base}_2_trimmed.fq.gz" \
  --outSAMtype BAM SortedByCoordinate \
  --quantMode GeneCounts \
  --readFilesCommand zcat \
  --outFileNamePrefix "$OUT_DIR/${base}_"