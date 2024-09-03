# Project to convert the data into monthly averages, extract end-of-month data,
# plot the data, and compute the Mean Absolute Error (MAE) and Root Mean Squared Error (RMSE)

# Step 1: Converting the data into monthly averages

# Load the dataset from the CSV file
data_set <- read.csv(file="SPOT.csv", header=TRUE)

# Convert the 'Date' column to a date format
data_set$Date <- as.Date(data_set$Date)

# Extract the month and year from the 'Date' column
data_set$Month <- strftime(data_set$Date, format="%m")
data_set$Year <- strftime(data_set$Date, format="%Y")

# Calculate the monthly average closing price
data_set_monthly_average <- aggregate(data_set$Close ~ Month + Year, data_set, FUN=mean)

# Step 2: Extracting end-of-month data

# Load the 'lubridate' package for date manipulation
library(lubridate)

# Get the total number of rows in the dataset
T <- NROW(data_set)

# Extract the month from each date
MM <- month(as.POSIXlt(data_set$Date, format="%Y-%m-%d"))

# Create a 'Dummy' column to help identify the end of each month
data_set$Dummy <- NA
data_set$Dummy[1:(T-1)] <- MM[1:(T-1)] - MM[2:T]

# Subset the data to keep only the rows corresponding to the end of each month
data_set_end_of_month <- subset(data_set, data_set$Dummy != 0)

# Add the last row of the original dataset to ensure the most recent data is included
data_set_end_of_month <- rbind(data_set_end_of_month, data_set[T,])

# Create a sequence of numbers for indexing
t <- seq(from=1, to=NROW(data_set_end_of_month), by=1)
data_set_end_of_month <- cbind(t, data_set_end_of_month)

# Save the monthly average and end-of-month datasets to CSV files
write.csv(data_set_monthly_average, file="SPOT_monthly_average.csv")
write.csv(data_set_end_of_month, file="SPOT_end_of_month.csv")

# Step 3: Plotting the end-of-month data

# Install and load the 'ggplot2' package for plotting
install.packages("ggplot2")
library(ggplot2)

# Select only the 'Date' and 'Close' columns for plotting
selected_cols <- data_set_end_of_month[c("Date", "Close")]

# Create a line plot of the end-of-month closing prices
ggplot(selected_cols, aes(x = Date, y = Close)) + 
  geom_line() + 
  labs(x = "Date", y = "Spotify Stock Price (USD)", title = "Spotify Stock Price")

# Step 4: Forecasting with a 12-month horizon

# Load the end-of-month dataset from the CSV file
data_set <- read.csv(file="SPOT_end_of_month.csv", header=TRUE)

# Apply a log transformation to the 'Close' prices
y <- log(data_set$Close)

# Define the forecast horizon (12 months)
hor <- 12

# Define the starting point for the estimation period
T <- 33

# Get the total number of rows in the dataset
TT <- NROW(data_set)

# Load the 'forecast' package for time series forecasting
library(forecast)

# Initialize a matrix to store the forecasts
fcast <- matrix(0, TT-T+1-hor, 3) 
colnames(fcast) <- c("Date", "Actual", "Forecast") 

# Fill the 'Date' and 'Actual' columns with appropriate values
fcast[,1] <- data_set$Date[(T+hor):TT]  
fcast[,2] <- y[(T+hor):TT]              

# Loop through the data, generating forecasts with a 12-month horizon
for (i in (1:(TT-T-hor+1))) {
  # Fit an ARIMA model to the data up to the current point
  result <- auto.arima(y[1:T+i-1], max.p=12, max.q=12)
  
  # Generate the forecast for the next 12 months
  fcast_all <- forecast(result, h=hor)
  
  # Store the forecasted value for the 12th month
  fcast[i,3] <- fcast_all$mean[hor]
}

# Display the forecast matrix
fcast

# Save the forecast results to a CSV file
write.csv(fcast, file="Assignment 7 Example Forecast Output.csv")

# Step 5: Compute RMSE and MAE

# Load the forecast output from the CSV file
forecast_output <- read.csv("Assignment 7 Example Forecast Output.csv")

# Calculate the Mean Absolute Error (MAE)
MAE <- mean(abs(forecast_output$Actual - forecast_output$Forecast))

# Calculate the Root Mean Squared Error (RMSE)
RMSE <- sqrt(mean((forecast_output$Actual - forecast_output$Forecast)^2))

# Print the MAE and RMSE values
print(paste("Mean Absolute Error (MAE):", MAE))
print(paste("Root Mean Squared Error (RMSE):", RMSE))