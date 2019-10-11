library('tidyverse')

# Load data -------------------------------------------------------------------

input_internacion_csv <- file.path('data', 'original', 'hi_internacion.csv')
internacion <- read_csv(input_internacion_csv)

# Set connection to database --------------------------------------------------

connection <- DBI::dbConnect(
  RPostgres::Postgres(), 
  host = "database",
  user = "postgres",
  dbname = 'mortalidad',
  password = "postgres"
)

# Cleaning --------------------------------------------------------------------

## Remove zero imputated values and impossible patient weights
internacion <- internacion %>% 
  filter_at(vars(peso, altura, ldl, hdl, tag, glu), all_vars(.>0)) %>% 
  filter(peso < 250) %>% 
  drop_na()

# Save ------------------------------------------------------------------------

copy_to(connection, internacion, 'internacion', overwrite = T, temporary = F)
