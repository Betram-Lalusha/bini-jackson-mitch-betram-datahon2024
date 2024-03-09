# Load necessary libraries'
library(caret)  # For preprocessing (including one-hot encoding)
library(readr)  # For reading CSV files

# Function to perform one-hot encoding of categorical variables
encode_categorical <- function(data) {
  # Identify categorical columns
  cat_columns <- sapply(data, is.factor)
  
  # If any categorical columns exist, encode them
  if (any(cat_columns)) {
    # Perform one-hot encoding using caret's dummyVars function
    dummy_data <- predict(dummyVars(~ ., data = data[!cat_columns]), newdata = data)
    
    # Combine encoded variables with original data
    encoded_data <- cbind(data[!cat_columns], dummy_data)
    
    return(encoded_data)
  } else {
    return(data)
  }
}

