detect_non_numeric <- function(column) {
  # Identify elements that are purely numeric (contain digits only)
  non_digit_elements <- grep("\\D", column, value = TRUE)
  
  # Get distinct non-numeric elements
  distinct_elements <- unique(non_digit_elements)
  
  # Return the distinct elements or an empty list if none are found
  if(length(distinct_elements) > 0) {
    return(distinct_elements)
  } else {
    return(list())
  }
}