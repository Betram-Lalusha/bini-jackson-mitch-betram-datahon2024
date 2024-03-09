encode_as_categorical <- function(elements) {
  # Convert the input list to a factor
  categorical_var <- factor(elements)
  
  # Return the factor
  return(categorical_var)
}