srun -p interactive --pty bash
module load anaconda3/2025.06
export CONDA_PKGS_DIRS=/mnt/data/amedina/ssalazar/.conda
conda create --prefix /mnt/data/amedina/ssalazar/envs/rna_env -c conda-forge -c bioconda python=3.12 multiqc
conda install bioconda::fastqc

conda activate /mnt/data/amedina/ssalazar/envs/rna_env
