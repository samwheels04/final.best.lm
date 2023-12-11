

# final.best.lm

<!-- badges: start -->
<!-- badges: end -->

Have you ever had a dependent variable you wanted to predict with a certain number of predictor variables? You wanted to find the best model to predict this certain variable? Maybe it was house price, gas mileage, or air pollution?

The package ***final.best.lm*** contains the function *best.lm* to create the best possible linear model with a specified number of predictor variables. It splits the data into a training and test set, and the sizes of the sets can be changed in the "train_size" parameter. Then it iterates through every possible linear model and finds the best one based on the adjusted R squared and mean squared error.

### Installation

You can install the development version of **final.best.lm** like so:

``` r
if(!require(remotes)){
 install.packages("remotes")
 }
remotes::install_github("samwheels04/final.best.lm")
```

### Example

This is a basic example which shows you how to solve a common problem:

``` r
library(final.best.lm)
best.linmod(mtcars, "mpg", 5, 0.7)
```




