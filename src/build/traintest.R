library('tidyverse')

# Define functions ------------------------------------------------------------

open_feature <- function(filename) {
  input_csv <- file.path('data', 'features', filename)
  read_csv(input_csv)
}

merge_features <- function(df1, df2) {
  df1 %>% full_join(df2, by='paciente_id')
}

# Load data -------------------------------------------------------------------

## Build features dataset
feature_files <- list.files(file.path('data', 'features'))
features <- purrr::map(feature_files, open_feature)
build <- purrr::reduce(features, merge_features)

## Labels
input_labels_csv <- file.path('data', 'labels', 'labels.csv')
labels <- read_csv(input_labels_csv)


# Build traintest -------------------------------------------------------------

traintest <- build %>% 
  left_join(labels, by='paciente_id') %>% 
  drop_na()

# Save ------------------------------------------------------------------------

output_traintest_csv <- file.path('data', 'build', 'traintest.csv')
write_csv(traintest, output_traintest_csv)
