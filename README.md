# Análisis de bulk RNA-seq: de datos públicos a genes diferencialmente expresados

Material de un curso de 5 sesiones para aprender a procesar y analizar datos de **bulk RNA-seq** públicos, desde la descarga de datos crudos hasta la lista final de genes diferencialmente expresados.

Como caso de estudio se analiza la respuesta transcriptómica al **SARS-CoV-2** en PBMCs humanas, comparando pacientes con infección activa (`acute`) vs. convalecientes (`convalescent`). Se usan dos estudios públicos de GEO (**GSE166253** y **GSE202805**), 8 muestras por estudio (16 en total). El estudio de origen (`study`) se usa como variable de batch.

## Contenido del curso

| Clase | Tema | Herramientas |
|-------|------|--------------|
| 1 | Obtención de datos públicos de GEO | GEO, EBI, wget |
| 2 | Control de calidad de lecturas | FastQC, MultiQC, Trimmomatic |
| 3 | Alineamiento y conteo | STAR |
| 4 | Importación a R, visualización y batch correction | DESeq2, ggplot2, sva, limma |
| 5 | Expresión diferencial | DESeq2, apeglm |

## Estructura del repositorio

```
RNA-class-2026/
├── documentacion_curso.qmd   # Documentación completa del curso (todas las clases en un documento)
│
├── clases_qmd/               # Libretas Quarto (.qmd) de cada clase
│   ├── clase1_datos_publicos.qmd
│   ├── clase2_qc.qmd
│   ├── clase3_alineamiento.qmd
│   ├── clase4_R_visualizacion.qmd
│   └── clase5_DESeq2.qmd
│
├── scripts/                  # Scripts usados en el cluster (ver nota abajo)
│   ├── download.sbatch / download_fastq.sh   # Descarga de FASTQ
│   ├── rna_environment.sh                     # Ambiente de software
│   ├── qc.sbatch / qc2.sbatch                 # FastQC/MultiQC pre y post-trimming
│   ├── trim.sbatch                            # Trimmomatic
│   ├── index_genome.sbatch / align.sbatch     # STAR: índice y alineamiento
│   └── crear_metadatos_curso.R               # Genera data/metadatos_curso.csv
│
├── data/                     # Metadatos de las muestras
│   ├── GSE166253_metadata.csv    # Muestras seleccionadas de GSE166253 (formato SraRunTable)
│   ├── GSE202805_metadata.csv    # Muestras seleccionadas de GSE202805 (formato SraRunTable)
│   ├── SraRunTable.csv           # Tabla completa original de GSE202805 (referencia)
│   └── metadatos_curso.csv       # Metadatos combinados del curso (16 muestras)
│
├── quality1/                 # Reportes FastQC/MultiQC antes del trimming
├── quality2/                 # Reportes FastQC/MultiQC después del trimming
├── quality2_polya/           # Reportes de QC (variante poly-A)
│
└── STAR_output/              # Matrices de cuentas por gen de STAR (*_ReadsPerGene.out.tab)
```

## Cómo usar el material

Las clases 1 a 3 (descarga, control de calidad y alineamiento) se ejecutan sobre un servidor/cluster; las clases 4 y 5 corren en **R** y leen las cuentas de `STAR_output/`. Ejecuta el código de las clases 4 y 5 **desde la raíz del proyecto**, ya que las rutas (`STAR_output/`, `data/metadatos_curso.csv`, `counts/`, `results/`) son relativas a esa carpeta.

## Nota sobre los scripts

Los archivos de `scripts/` son **los scripts que se usaron literalmente en el cluster** (en su mayoría scripts de SLURM, `.sbatch`). Se incluyen **como ejemplo y referencia**: para reutilizarlos debes personalizar las **rutas**, los **módulos/ambientes de software** y los **parámetros de SLURM** (`#SBATCH`) según tu propio entorno.
