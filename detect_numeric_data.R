detect_numeric_data <- function(column) {
  # Identify elements that are purely numeric (contain digits only)
  non_digit_elements <- grep("^-?\\d*\\.{0,1}\\d+$", column, value = TRUE)
  
  #Return true if column contains only numbers
  if (length(non_digit_elements) == 0) {
    return (FALSE)
  } else {
    return (TRUE)
  }
}