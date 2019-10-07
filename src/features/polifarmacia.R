library('tidyverse')

# Load data -------------------------------------------------------------------

input_farmacia_csv <- file.path('data', 'stable', 'farmacia.csv')
farmacia <- read_csv(input_farmacia_csv)

# Featuring -------------------------------------------------------------------

polifarmacia <- farmacia %>% 
  mutate(polifarmacia = rowSums(select(., -paciente_id))) %>% 
  mutate(polifarmacia = ifelse(polifarmacia >= 3, yes=1, no=0)) %>% 
  select(paciente_id, polifarmacia)

# Save ------------------------------------------------------------------------

output_polifarmacia_csv <- file.path('data', 'features', 'polifarmacia.csv')
write_csv(polifarmacia, output_polifarmacia_csv)
