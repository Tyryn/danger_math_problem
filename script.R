library(tidyverse)
library(dygraphs)

# If number is odd, multiply by three and add 1
# If number is even, divide by 2


# Is odd function
is_odd <- function(x) {
  if (x %% 2 == 1) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}


# Danger problem function
danger_problem <- function(x) {
  y <- x  # Initialize y with the value of x
  i <- 1
  danger_list <- list()  # Initialize an empty list to store lists of pairs (i, y)
  while (y > 1) {
    danger_pair <- list(iteration = i, y = y)  # Create a list representing the pair (i, y)
    danger_list <- c(danger_list, list(danger_pair))  # Append the list to the main list
    if (is_odd(y)) {
      y <- y * 3 + 1
    } else {
      y <- y / 2
    }
    i <- i + 1  # Increment iteration counter
  }
  danger_pair <- list(iteration = i, y = y)  # Create the final list representing the pair (i, y)
  danger_list <- c(danger_list, list(danger_pair))  # Append the final pair to the main list
  
  danger_frame <- data.frame(iteration = sapply(danger_list, function(x) x$iteration),
                             value = sapply(danger_list, function(x) x$y))
  
  return(danger_frame)  # Return the list of lists representing pairs (i, y)
}




# Graph it
dataframe1 <- danger_problem(3234)
dataframe2 <- danger_problem(3233)

dataframe <- merge(dataframe1, dataframe2, by = "iteration", suffixes = c("_df1", "_df2"), all.x=TRUE, all.y=TRUE)

dygraph(dataframe) %>% dyRangeSelector()
