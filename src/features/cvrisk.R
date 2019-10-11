library('tidyverse')

# Set connection to database --------------------------------------------------

connection <- DBI::dbConnect(
  RPostgres::Postgres(), 
  host = "database",
  user = "postgres",
  dbname = 'mortalidad',
  password = "postgres"
)

# Load data -------------------------------------------------------------------

historial <- tbl(connection, 'historial')

# Featuring -------------------------------------------------------------------

query <- historial %>% 
  mutate(hta = ifelse(tas >= 140 | tad >= 90, yes=1, no=0),
         cv = iam + acv + eap + fa + icc) %>% 
  select(paciente_id, hta, cv, dbt)

# Save ------------------------------------------------------------------------
  
copy_to(connection, query, 'cvrisk', overwrite = T, temporary = F)