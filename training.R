train_decision_tree <- function(cleaned_df, outcome_df) {
  # Install and load the rpart package
  if (!require(rpart, quietly = TRUE)) {
    install.packages("rpart")
    library(rpart)
  }
  
  # Merge cleaned_df and outcome_df
  # Ensure to replace 'key_column' with the actual column used for merging
  merged_data <- merge(cleaned_df, outcome_df, by = "nomem_encr")
  
  # Building the decision tree model
  # Adjust control parameters as needed to prioritize early splits
  model <- rpart(formula = as.factor(new_child) ~ as.factor(cf20m128) + as.factor(marriage),
                 data = merged_data,
                 method = "class",
                 control = rpart.control(minsplit = 1, minbucket = 1, maxdepth = 3))
  
  # Save the model
  saveRDS(model, "model.rds")
}
