library('tidyverse')

# Load data -------------------------------------------------------------------

input_historial_csv <- file.path('data', 'original', 'hi_historial.csv')
historial <- read_csv(input_historial_csv)

# Set connection to database --------------------------------------------------

connection <- DBI::dbConnect(
  RPostgres::Postgres(), 
  host = "database",
  user = "postgres",
  dbname = 'mortalidad',
  password = "postgres"
)

# Cleaning --------------------------------------------------------------------

## Remove zero imputated values
historial <- historial %>% 
  filter_at(vars(tas, tad), all_vars(.>0)) %>% 
  drop_na()

# Save ------------------------------------------------------------------------

copy_to(connection, historial, 'historial', overwrite = T, temporary = F)
