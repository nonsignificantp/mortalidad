library('tidyverse')

# Load data -------------------------------------------------------------------

input_historial_csv <- file.path('data', 'original', 'hi_historial.csv')
historial <- read_csv(input_historial_csv)

# Cleaning --------------------------------------------------------------------

## Remove zero imputated values
historial <- historial %>% 
  filter_at(vars(tas, tad), all_vars(.>0)) %>% 
  drop_na()

# Save ------------------------------------------------------------------------

output_historial_csv <- file.path('data', 'stable', 'historial.csv')
write_csv(historial, output_historial_csv)
