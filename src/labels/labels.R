library('tidyverse')

# Load data -------------------------------------------------------------------

input_internacion_csv <- file.path('data', 'stable', 'internacion.csv')
internacion <- read_csv(input_internacion_csv)

# Labeling --------------------------------------------------------------------

labels <- internacion %>% 
  rename(label=muerte) %>% 
  select(paciente_id, label)

# Save ------------------------------------------------------------------------

output_labels_csv <- file.path('data', 'labels', 'labels.csv')
write_csv(labels, output_labels_csv)
