#' @title best.linmod
#'
#' @description
#' best.lm is a function to create the best possible linear model with a
#' specified number of predictor variables. It splits the data into a training
#' and test set, and the sizes of the sets can be changed in the "train_size"
#' parameter. Then it iterates through every possible linear model and finds the
#' best one based on the adjusted R squared and mean squared error.
#'
#'
#' @param data dataset
#' @param response_var the dependent variable
#' @param num_predictors number of predictor variables, default is number of variables -1
#' @param train_size percentage of the data that you want to allocate to the training set, default 0.8
#'
#' @return A summary including the dependent variable, the predictor variables,
#' and the percentage of variation in the dependent variable that the predictor
#' variables account for.
#' @export
#'
#' @examples
#'
#' best.linmod(mtcars, "mpg")
#' best.linmod(mtcars, "mpg", 4, 0.7)
#'
best.linmod <- function(data, response_var, num_predictors = length(data)-1, train_size = 0.8) {
  # Error of num_predictors is too large
  if (num_predictors >= length(data)) {
    stop("num_predictors is too large")
  }
  # Get the names of all predictor variables
  predictor_vars <- setdiff(names(data), response_var)

  # Initialize variables to track the best
  best_adj.r.2 <- 0
  best_mse <- Inf

  # create training (80%) and testing (20%) data set
  set.seed(1234)
  index <- sample(1:nrow(data), train_size*nrow(data))
  train <- mtcars[index, ]
  test <- mtcars[-index, ]

  # Iterate over all possible combinations of predictor variables
  combinations <- combn(predictor_vars, num_predictors, simplify = TRUE)

  for (i in 1:ncol(combinations)) {
    predictors <- combinations[, i]

    formula <- formula(paste(response_var, "~", paste(predictors, collapse = "+")))

    # Create a linear model
    model <- lm(formula, data = train)

    # Check and update the best model and best formula
    adj.r.2 <- summary(model)$adj.r.squared

    # Make predictions on the test data w/lm
    predictions <- predict(model, newdata = test)

    # Calculate mean squared error
    mse <- mean((test[[response_var]] - predictions)^2)

    # check if models R^2 and mse are better than current best model
    if (adj.r.2 > best_adj.r.2 && mse < best_mse) {
      best_adj.r.2 <- adj.r.2
      best_mse <- mse
      best_model <- model
      best_formula <- formula
    }
  }
  cat("Dependent variable:", response_var)
  cat("\nBest",  num_predictors, "predictor variables:", as.character(best_formula[3]))
  cat("\nThese predictor variables account for",
      round(best_adj.r.2, 3)*100,"% of the variation in your dependent variable.")
}
