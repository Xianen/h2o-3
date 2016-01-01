setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source("../../scripts/h2o-r-test-setup.R")
##
# Check factor levels of numeric and enum columns
##
test <- function(conn) {
  h2oTest.logInfo("Upload iris dataset into H2O...")
  iris.hex = as.h2o(iris)
  
  h2oTest.logInfo("Find the factor levels h2o and R frame...")
  levels1 <- sort(h2o.levels(iris.hex$Species))
  levels2 <- sort(levels(iris$Species))
  print("Factor levels for Species column for H2OH2OFrame...")
  print(levels1)
  print("Factor levels for Species column for dataframe...")
  print(levels2)
  if(all(levels1 == levels2)){
    h2oTest.logInfo("Factor levels matches for Species Column...")
  } else {
    stop("Factor levels do not match for Species Column...")
  }
  
  h2oTest.logInfo("Try printing the levels of a numeric column...")
  levels1 <- levels(iris$Sepal.Length)
  levels2 <- h2o.levels(iris.hex$Sepal.Length)
  print("Factor levels for Sepal.Length column for H2OH2OFrame...")
  print(levels1)
  print("Factor levels for Sepal.Length column for dataframe...")
  print(levels2)  
  if(!is.null(levels2)) stop("Numeric Column should not have any factor levels...")

  
}

h2oTest.doTest("Print factor levels with h2o.levels:", test)

