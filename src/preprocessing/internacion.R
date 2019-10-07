library('tidyverse')

# Load data -------------------------------------------------------------------

input_internacion_csv <- file.path('data', 'original', 'hi_internacion.csv')
internacion <- read_csv(input_internacion_csv)

# Cleaning --------------------------------------------------------------------

## Remove zero imputated values and impossible patient weights
internacion <- internacion %>% 
  filter_at(vars(peso, altura, ldl, hdl, tag, glu), all_vars(.>0)) %>% 
  filter(peso < 250) %>% 
  drop_na()

# Save ------------------------------------------------------------------------

output_internacion_csv <- file.path('data', 'stable', 'internacion.csv')
write_csv(internacion, output_internacion_csv)
