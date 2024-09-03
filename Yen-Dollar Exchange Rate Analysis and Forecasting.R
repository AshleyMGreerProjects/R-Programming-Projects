# Load necessary libraries
library(forecast)
library(vars)
library(lubridate)
library(imputeTS)

# Load the dataset
data_set <- read.csv("DEXJPUS(Updated).csv", header = TRUE)
data_set <- na.omit(data_set)  # Remove null values

# Convert the DATE column to Date type and the DEXJPUS column to numeric
data_set$DATE <- as.Date(data_set$DATE)
data_set$DEXJPUS <- as.numeric(as.character(data_set$DEXJPUS))

# Create a time series object for DEXJPUS
ts_data <- ts(log(data_set$DEXJPUS), start = c(year(data_set$DATE[1]), month(data_set$DATE[1])), frequency = 12)

# Subset the time series for ARIMA estimation up to the 637th observation
er_est <- ts_data[1:637]

# ARIMA Model (using full sample up to 637th observation)
ARpq_result_er <- auto.arima(er_est, max.p = 12, max.q = 12)
ARpq_forecast <- forecast(ARpq_result_er, h = 24)
print(ARpq_forecast)

# Full Data Forecasting (Q2 parts a and c)
# ETS and ARIMA models on the full time series
ets_model <- ets(ts_data)
arima_model <- auto.arima(ts_data)

# Forecast for 24 months
ets_forecast_24 <- forecast(ets_model, h = 24)
arima_forecast_24 <- forecast(arima_model, h = 24)

# Forecast for 12 months (for restricted data after October 2023)
data_set_restricted <- subset(data_set, as.Date(data_set$DATE) <= as.Date("2023-10-31"))
ts_data_restricted <- ts(data_set_restricted$DEXJPUS, start = c(year(data_set_restricted$DATE[1]), month(data_set_restricted$DATE[1])), frequency = 12)
ets_model_restricted <- ets(ts_data_restricted)
arima_model_restricted <- auto.arima(ts_data_restricted)
ets_forecast_12 <- forecast(ets_model_restricted, h = 12)
arima_forecast_12 <- forecast(arima_model_restricted, h = 12)

# Forecast for 3 months
ets_forecast_3 <- forecast(ets_model, h = 3)
arima_forecast_3 <- forecast(arima_model, h = 3)

# Print forecasts
print("ETS Forecast for 12 months:")
print(ets_forecast_12)
print("Auto ARIMA Forecast for 12 months:")
print(arima_forecast_12)
print("ETS Forecast for 3 months:")
print(ets_forecast_3)
print("Auto ARIMA Forecast for 3 months:")
print(arima_forecast_3)

# Extracting and calculating log exchange rate for January 2024
jan_2024_row <- subset(data_set, format(DATE, "%Y-%m") == "2024-01")
exchange_rate_jan_2024 <- as.numeric(jan_2024_row$DEXJPUS)
log_exchange_rate_jan_2024 <- log(exchange_rate_jan_2024)
print(log_exchange_rate_jan_2024)

# Calculate forecast errors for January 2024
actual_log_rate_jan_2024 <- log_exchange_rate_jan_2024
forecasted_log_rate_jan_2024_ets <- log(ets_forecast_24$mean[1])
forecasted_log_rate_jan_2024_arima <- log(arima_forecast_24$mean[1])
error_ets <- abs(forecasted_log_rate_jan_2024_ets - actual_log_rate_jan_2024)
error_arima <- abs(forecasted_log_rate_jan_2024_arima - actual_log_rate_jan_2024)
print(paste("Error for ETS model in January 2024:", error_ets))
print(paste("Error for ARIMA model in January 2024:", error_arima))

# Calculate accuracy measures
accuracy_ets <- accuracy(forecast(ets_model))
accuracy_arima <- accuracy(forecast(arima_model))
if (accuracy_ets[1, "ME"] < accuracy_arima[1, "ME"]) {
  print("ETS model has smaller Mean Error (ME)")
} else {
  print("Auto ARIMA model has smaller Mean Error (ME)")
}

# Graphing
# Highlight forecast on a subset of the time series
er_ <- ts(log(data_set$DEXJPUS), start = 1971, frequency = 12)
er_[638:651] <- NA
er2_subset <- subset(er_, start = 500)
autoplot(er2_subset, xlab = "Time", ylab = "Japanese Yen to US$1.00", main = "Yen-Dollar Exchange Rates: Forecasts for the Next 24 Months") + 
  autolayer(ets_forecast_24)

# Other Outputs
print(ETS_result_er)
print(ETS_forecast)