## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(final.best.lm)

## ----example------------------------------------------------------------------
library(final.best.lm)
best.linmod(mtcars, "mpg")
best.linmod(mtcars, "mpg", 5, 0.7)

