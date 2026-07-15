library(dplyr)
library(readr)

# Ejecutar desde la raíz del proyecto (las rutas son relativas a esa carpeta)

# GSE166253: comparacion convalescent vs retesting-positive (RTP)
gse166253 <- read_csv("data/GSE166253_metadata.csv") %>%
  filter(disease_state %in% c("convalescent", "retesting-positive (RTP)"))  %>%
  mutate(
    sample_id = Run,
    study     = "GSE166253",
    status    = case_when(
      disease_state == "convalescent"             ~ "convalescent",
      disease_state == "retesting-positive (RTP)" ~ "acute"
    ),
    severity  = previous_severity
  )  %>%
  select(sample_id, study, status, severity)

# GSE202805: comparacion convalescent vs acute
gse202805 <- read_csv("data/GSE202805_metadata.csv") %>%
  filter(Group %in% c("convalescent", "acute")) %>%
  mutate(
    sample_id = Run,
    study     = "GSE202805",
    status    = Group,
    severity  = disease_severity
  ) %>%
  select(sample_id, study, status, severity)

# Combinar los dos estudios
# Los archivos GSE*_metadata.csv contienen las muestras que seleccionamos y
# descargamos para el curso (8 por estudio). El resultado son 16 muestras; en
# la clase 4 la metadata se recorta automáticamente a las que sí se alinearon.
metadatos_curso <- bind_rows(gse166253, gse202805)

# Guardar
write_csv(metadatos_curso, "data/metadatos_curso.csv")

message("Metadatos guardados: ", nrow(metadatos_curso), " muestras")
print(table(metadatos_curso$study, metadatos_curso$status))
