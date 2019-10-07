library('tidyverse')

# Load data -------------------------------------------------------------------

input_farmacia_csv <- file.path('data', 'original', 'hi_farmacia.csv')
farmacia <- read_csv(input_farmacia_csv)

# Cleaning --------------------------------------------------------------------

# La data ya esta limpia este
# es un script de ejemplo.

# Save ------------------------------------------------------------------------

output_farmacia_csv <- file.path('data', 'stable', 'farmacia.csv')
write_csv(farmacia, output_farmacia_csv)
