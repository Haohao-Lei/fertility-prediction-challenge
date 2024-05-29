# This is an example script to generate the outcome variable given the input dataset.
# 
# This script should be modified to prepare your own submission that predicts 
# the outcome for the benchmark challenge by changing the clean_df and predict_outcomes function.
# 
# The predict_outcomes function takes a data frame. The return value must
# be a data frame with two columns: nomem_encr and outcome. The nomem_encr column
# should contain the nomem_encr column from the input data frame. The outcome
# column should contain the predicted outcome for each nomem_encr. The outcome
# should be 0 (no child) or 1 (having a child).
# 
# clean_df should be used to clean (preprocess) the data.
# 
# run.R can be used to test your submission.

# List your packages here. Don't forget to update packages.R!
library(dplyr) # as an example, not used here

clean_df <- function(df) {
  #recode marriage
  df$marriage <- 9999
  df$marriage[df$burgstat_2020 < 5] <- 1
  df$marriage[df$burgstat_2020 == 5] <- 2
  df$marriage[df$marriage==9999] <- NA
  #recode planned birth
  df$plan <- 9999
  df$plan[df$cf20m128==2] <- 0
  df$plan[df$cf20m128!=2] <- 1
  df$plan[df$plan==9999] <- NA
  #recode age
  df$age <- 0
  df$age[df$cf20m004<=38&df$cf20m004>=26] <- 1
  return(df)
}

predict_outcomes <- function(df = NULL, model_path = "./model.rds"){
  if(!("nomem_encr" %in% colnames(df))) {
    warning("The identifier variable 'nomem_encr' should be in the dataset")
  }
  
  # Load the model
  model <- readRDS(model_path)
  
  # Preprocess the data
  df <- clean_df(df) # Ensure this function does not introduce issues
  
  # Exclude the identifier variable if it is not a predictor
  vars_without_id <- setdiff(colnames(df), "nomem_encr")
  
  # Generate predictions from model
  # Check appropriate type: 'class' for classification labels, 'prob' for probabilities
  predictions <- predict(model, df[vars_without_id], type = "class") 
  
  # Create output dataframe with two columns: nomem_encr and predictions
  df_predict <- data.frame("nomem_encr" = df$nomem_encr, "prediction" = predictions)
  names(df_predict) <- c("nomem_encr", "prediction") # Ensure column names are correct
  
  return(df_predict)
}

predict_outcomes(df)
