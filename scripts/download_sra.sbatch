#!/bin/bash
#SBATCH -J download
#SBATCH -p defq
#SBATCH --mem=8G
#SBATCH -c 8
#SBATCH -t 48:00:00
#SBATCH -o /mnt/data/amedina/ssalazar/rna/logs/download_%j.out
#SBATCH -e /mnt/data/amedina/ssalazar/rna/logs/download_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sogusama02@gmail.com

cd /mnt/data/amedina/ssalazar/rna/data
module load sra/3.0.0
THREADS=8

# Path to the CSV file with SRR IDs in the first column
CSV_FILE="/mnt/data/amedina/ssalazar/rna/metadatos_curso.csv"

# Read SRR IDs from the first column of the CSV
SRR_LIST=$(tail -n +2 "$CSV_FILE" | cut -d',' -f1)

for SRR in $SRR_LIST; do
    echo "=== Procesando $SRR ==="

    # Skip if fastq files already exist
    if [[ -f "${SRR}_1.fastq.gz" && -f "${SRR}_2.fastq.gz" ]]; then
        echo "$SRR already downloaded, skipping."
        continue
    fi

    # Download .sra file
    prefetch "$SRR" --output-directory . --max-size 100G

    # Convert to gzipped paired-end fastq
    fasterq-dump "$SRR" \
        --split-files \
        --threads "$THREADS" \
        --outdir . \
        --temp .

    # Compress output
    gzip -f "${SRR}_1.fastq" "${SRR}_2.fastq"

    # Clean up .sra directory to save space
    rm -rf "$SRR"
done