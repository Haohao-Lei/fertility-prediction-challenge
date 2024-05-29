# Description of submission
The model we built uses the rpart package to construct a decision tree. The formula for the model specifies new_child (the target variable) being predicted by the following binary predictor variables: planned childbirth in the future, age, and marriage status. All variables are converted to factors for classification purposes.

The rpart.control parameters are configured to prioritize early splits with the following settings:

minsplit = 1: The minimum number of observations that must exist in a node for a split to be attempted.
minbucket = 1: The minimum number of observations allowed in any terminal (leaf) node.
maxdepth = 3: The maximum depth of any node in the final tree.
We chose this model because we believe that a simple decision tree can effectively capture the key predictors of fertility behaviors. Simple models are not only easier to interpret but also less likely to overfit the data compared to more complex models. By focusing on fundamental predictors and controlling the complexity of the model, we aim to demonstrate that a simple model can potentially outperform a more complex one.