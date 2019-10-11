library('tidyverse')

# Load data -------------------------------------------------------------------

input_farmacia_csv <- file.path('data', 'original', 'hi_farmacia.csv')
farmacia <- read_csv(input_farmacia_csv)

# Set connection to database --------------------------------------------------

connection <- DBI::dbConnect(
  RPostgres::Postgres(), 
  host = "database",
  user = "postgres",
  dbname = 'mortalidad',
  password = "postgres"
)

# Cleaning --------------------------------------------------------------------

# La data ya esta limpia este
# es un script de ejemplo.

# Save ------------------------------------------------------------------------

copy_to(connection, farmacia, 'farmacia', overwrite = T, temporary = F)