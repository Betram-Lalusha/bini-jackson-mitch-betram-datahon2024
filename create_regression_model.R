
###load data
data = read.csv("FY2019_068_Contracts_Full_20240214_1.csv")
head(data)

### remove columns with single levels
for(col in names(data)) {
  if(is.factor(data[[col]]) && length(levels(data[[col]])) == 1) {
    data[[col]] <- NULL
  }
}

#drop unused levels
data <- droplevels(data)

data <- data[, colSums(is.na(data)) < nrow(data)]

data <- data[, sapply(data, function(x) var(x, na.rm = TRUE) != 0)]


#loop through columns
lapply(data, function(column) {
  # Perform operations on the column here
  # Example operation: return the summary of the column
  
  ###encode categorical variables
  if (!detect_numeric_data((column))) {
    data$column = encode_as_categorical(column)
  }
})

####variable selection based on p-values
#without test="F", default is by AIC.
library(MASS)

###fit a multiple regression model
res.full=lm(data$potential_total_value_of_award~data$parent_award_agency_name+data$total_dollars_obligated+data$federal_action_obligation+data$total_outlayed_amount_for_overall_award+data$base_and_exercised_options_value+data$base_and_all_options_value+data$awarding_office_name+data$funding_office_name+data$program_activities_funding_this_award+data$type_of_contract_pricing+data$product_or_service_code_description+data$domestic_or_foreign_entity+data$woman_owned_business+data$women_owned_small_business+data$organizational_type,data=data)
res.null=lm(data$potential_total_value_of_award~1,data=data)

forward=step(res.null,
             scope = list(upper=res.full),
             direction="forward",
             test="F")

res.final = lm(data$potential_total_value_of_award ~ data$program_activities_funding_this_award + 
                 data$total_dollars_obligated + data$product_or_service_code_description, data=data)
summary(res.final)

#### find residuals and studentized residuals
err=resid(res.final)
student.err=rstandard(res.final)
#### extract fitted values from model 1
fit.v=res.final$fitted.values

#### present 4 figures in one plot: 2 row and 2 columns
par(mfrow=c(2,2))

###residual plots
plot(fit.v,err,xlab="Fitted Values",ylab="Residuals")
plot(data$program_activities_funding_this_award,err,xlab="program_activities_funding_this_award",ylab="Residuals")
plot(data$total_dollars_obligated,err,xlab="total_dollars_obligated",ylab="Residuals")
plot(data$product_or_service_code_description,err,xlab="product_or_service_code_description",ylab="Residuals")

#QQ plot
qqnorm(err)
qqline(err)


### Linear regression
###fit a multiple regression model
res.full=lm(data$potential_total_value_of_award~data$total_dollars_obligated+data$federal_action_obligation+data$total_outlayed_amount_for_overall_award+data$base_and_exercised_options_value+data$base_and_all_options_value, data=data)
res.null=lm(data$potential_total_value_of_award~1,data=data)

forward=step(res.null,
             scope = list(upper=res.full),
             direction="forward",
             test="F")

res.final = lm(data$potential_total_value_of_award ~ 
                 data$total_dollars_obligated, data=data)
summary(res.final)

#### find residuals and studentized residuals
err=resid(res.final)
student.err=rstandard(res.final)
#### extract fitted values from model 1
fit.v=res.final$fitted.values

#### present 4 figures in one plot: 2 row and 2 columns
par(mfrow=c(2,2))

###residual plots
plot(fit.v,err,xlab="Fitted Values",ylab="Residuals")
plot(data$program_activities_funding_this_award,err,xlab="program_activities_funding_this_award",ylab="Residuals")
plot(data$total_dollars_obligated,err,xlab="total_dollars_obligated",ylab="Residuals")
plot(data$product_or_service_code_description,err,xlab="product_or_service_code_description",ylab="Residuals")

#QQ plot
qqnorm(err)
qqline(err)





