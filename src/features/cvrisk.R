library('tidyverse')

# Load data -------------------------------------------------------------------

input_historial_csv <- file.path('data', 'stable', 'historial.csv')
historial <- read_csv(input_historial_csv)

# Featuring -------------------------------------------------------------------

cvrisk <- historial %>% 
  mutate(hta = ifelse(tas >= 140 | tad >= 90, yes=1, no=0),
         cv = rowSums(select(., iam, acv, eap, fa, icc))) %>% 
  select(paciente_id, hta, cv, dbt)

# Save ------------------------------------------------------------------------
  
output_cvrisk_cvs <- file.path('data', 'features', 'cvrisk.csv')
write_csv(cvrisk, output_cvrisk_cvs)
