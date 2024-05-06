
# MDSR 10 -- Machine Learning ---------------------------------------------

library(DALEXtra)
library(partykit)
library(rpart)
library(tidymodels)
library(tidyverse)

# Steve Miller's CCES 2016 extract, preprocessed
midwest <- readr::read_tsv("data/midwest.tsv") %>%
  mutate(votetrump = factor(as.integer(votetrump %in% 1)))

# inspect all features
glimpse(midwest)

# Example decision tree ---------------------------------------------------

dt_data <- filter(midwest, !is.na(votetrump)) %>%
  mutate(religious = religimp + churchatd + prayerfreq) %>%
  select(votetrump, age, female, religious)

# recursive partitioning
dt_tree <- rpart::rpart(votetrump ~ age + female + religious, data = dt_data)
dt_tree

# inspect nodes and leafs
plot(partykit::as.party(dt_tree))

# Resampling --------------------------------------------------------------

mw_split <- drop_na(midwest) %>%
  rsample::initial_split(prop = 4/5, strata = votetrump)

# train set
mw_train <- rsample::training(mw_split)
nrow(mw_train) # 80%

# test set
mw_test  <- rsample::testing(mw_split)
nrow(mw_test) # 20%

# Random forests ----------------------------------------------------------

# set up the model and parameters
rf_model <- parsnip::rand_forest(trees = 500) %>%
  parsnip::set_engine("ranger", importance = "impurity") %>%
  parsnip::set_mode("classification")

# fit the model to the training set
rf_fit <- rf_model %>%
  parsnip::fit(votetrump ~ ., data = mw_train)

rf_fit

# assemble training set predictions, probabilities and true outcome (response)
rf_training_pred <- predict(rf_fit, mw_train) %>%
  bind_cols(predict(rf_fit, mw_train, type = "prob")) %>%
  bind_cols(select(mw_train, votetrump))

head(rf_training_pred)

# confusion matrix
with(rf_training_pred, table(.pred_class, votetrump))

# model performance (1) area under curve
rf_training_pred %>%
  yardstick::roc_auc(truth = votetrump, .pred_0) # 99.4%

# model performance (2) accuracy
rf_training_pred %>%
  yardstick::accuracy(truth = votetrump, .pred_class) # 95.6%

# repeat on testing set
rf_testing_pred <- predict(rf_fit, mw_test) %>%
  bind_cols(predict(rf_fit, mw_test, type = "prob")) %>%
  bind_cols(select(mw_test, votetrump))

rf_testing_pred %>%
  yardstick::roc_auc(truth = votetrump, .pred_0) # 91.5%

rf_testing_pred %>%
  yardstick::accuracy(truth = votetrump, .pred_class) # 83.6%

# ... we overfitted the training set!

# Resampling --------------------------------------------------------------

# create 10 cross-validation folds
set.seed(345)
folds <- rsample::vfold_cv(mw_train, v = 10)
head(folds, 5)

# create a workflow
rf_wf <- workflows::workflow() %>%
  workflows::add_model(rf_model) %>%
  workflows::add_formula(votetrump ~ .)

# fit the model to all folds
set.seed(678)
rf_fit_rs <- rf_wf %>%
  tune::fit_resamples(folds)

head(rf_fit_rs, 5)

# how well did it work?
tune::collect_metrics(rf_fit_rs)

# ... the metrics now match what we got on the test set

# Variable importance -----------------------------------------------------

# most important variables
parsnip::extract_fit_engine(rf_fit) %>%
  ranger::importance() %>%
  sort(decreasing = TRUE)

# build an explainer
rf_explainer <- DALEXtra::explain_tidymodels(
  rf_fit,
  data = mw_train,
  y = mw_train$votetrump,
  label = "rf",
  verbose = FALSE
)

# select some random observations of different voter profiles
random_rep <- mw_train[ sample(which(mw_train$pid7na == "Not Strong R"), 1), ]
random_dem <- mw_train[ sample(which(mw_train$pid7na == "Not Strong D"), 1), ]
random_ind <- mw_train[ sample(which(mw_train$pid7na == "Indep."), 1), ]

# compute variable importance for each profile
DALEX::predict_parts(explainer = rf_explainer, new_observation = random_dem)
DALEX::predict_parts(explainer = rf_explainer, new_observation = random_rep)
DALEX::predict_parts(explainer = rf_explainer, new_observation = random_ind)

# kthxbye
