library('tidyverse')

# Load data -------------------------------------------------------------------

input_internacion_csv <- file.path('data', 'stable', 'internacion.csv')
internacion <- read_csv(input_internacion_csv)

# Featuring -------------------------------------------------------------------

internacion <- internacion %>% 
  mutate(bmi = peso / (altura / 100) ** 2,
         old = ifelse(edad >= 75, yes=1, no=0),
         fat = ifelse(bmi >= 25, yes=1, no=0))

sex <- internacion %>% 
  select(paciente_id, female)

age <- internacion %>% 
  select(paciente_id, old)

weight <- internacion %>% 
  select(paciente_id, bmi, fat)

smoker <- internacion %>% 
  select(paciente_id, tbq)

# Save ------------------------------------------------------------------------

output_sex_csv <- file.path('data', 'features', 'sex.csv')
write_csv(sex, output_sex_csv)

output_age_csv <- file.path('data', 'features', 'age.csv')
write_csv(age, output_age_csv)

output_weight_csv <- file.path('data', 'features', 'weight.csv')
write_csv(weight, output_weight_csv)

output_smoker_csv <- file.path('data', 'features', 'smoker.csv')
write_csv(smoker, output_smoker_csv)
