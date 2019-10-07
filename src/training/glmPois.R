library('caTools')
library('tidyverse')
library('MLmetrics')

# Load data -------------------------------------------------------------------

input_traintest_csv <- file.path('data', 'build', 'traintest.csv')
traintest <- read_csv(input_traintest_csv)

# Preprocessing ---------------------------------------------------------------

traintest <- traintest %>% 
  select(-paciente_id)

# Split & Model ---------------------------------------------------------------

splitdf <- sample.split(traintest$label, SplitRatio=0.2)

train <- traintest %>% 
  subset(., splitdf == TRUE)

test <- traintest %>% 
  subset(., splitdf == FALSE)

model <- glm(label ~ ., family=poisson(), data=train)
# summary(model)

# AUC & Accuracy --------------------------------------------------------------

predict_proba <- predict(model, test, type='response')
auc_score <- AUC(predict_proba, test$label)

# predict_class <- ifelse(predict_proba >= 0.5, 1, 0)
# Accuracy(predict_class, test$label)

# Save ------------------------------------------------------------------------

output_model_rds <- file.path('data', 'models', 'glmPois.rds')
saveRDS(model, output_model_rds)

output_metric_txt <- file.path('data', 'models', 'auc.txt')
sink(output_metric_txt)
cat(auc_score)
cat('\n')
sink()