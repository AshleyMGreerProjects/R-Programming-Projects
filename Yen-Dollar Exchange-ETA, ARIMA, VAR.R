

# Load necessary libraries
library(forecast)  # For time series forecasting models
library(vars)  # For vector autoregressive (VAR) models

# Load the dataset from a CSV file
data_set <- read.csv("JPY&FFR.csv", header=TRUE)

# Create time series objects for the Yen-Dollar exchange rate (DEXJPUS) and Federal Funds Rate (FEDFUNDS)
er <- ts(log(data_set$DEXJPUS), start=1971, frequency=12)  # Log-transformed exchange rate
ffr <- ts(data_set$FEDFUNDS, start=1971, frequency=12)  # Federal Funds Rate

# Define the estimation period: From Jan 1971 to Jan 2023 (625 observations)
er <- er[1:625]  # Restricting the exchange rate time series to the estimation period
ffr <- ffr[1:625]  # Restricting the Federal Funds Rate time series to the estimation period

# Estimation of Exponential Smoothing State Space Model (ETS)
ETS_result <- ets(er, model="ZZZ", damped=NULL, ic="aic")

# Estimation of ARIMA Model
ARIMA_result <- auto.arima(er, max.p=12, max.q=12, ic="aic")

# Estimation of Vector Autoregression (VAR) Model
Y <- ts(cbind(er, ffr))  # Combine the two time series into a multivariate time series

# Model selection for VAR model with a maximum lag of 12
model_selection <- VARselect(Y, lag.max=12, type="const")
opt_p <- model_selection$selection[1]  # Select the optimal lag order based on the chosen criterion

# Fit the VAR model with the selected lag order
VAR_result <- VAR(Y, p=opt_p, type="const")

# Define the forecast horizon: 6 months for forecasting until July 2023
k <- 6

# Generate forecasts using the fitted models
ETS_forecast <- forecast(ETS_result, h=k)
ARIMA_forecast <- forecast(ARIMA_result, h=k)
VAR_forecast <- forecast(VAR_result, h=k)

# Print the forecasts
ETS_forecast
ARIMA_forecast
VAR_forecast

# Question 2: Repeating the process with different estimation periods and forecast horizons

# For Estimation: 1/1971-1/2023, Forecast: 7/2023
library(forecast)
library(vars)
data_set <- read.csv("JPY&FFR.csv", header=TRUE)
er <- ts(log(data_set$DEXJPUS), start=1971, frequency=12)
ffr <- ts(data_set$FEDFUNDS, start=1971, frequency=12)

# Define the estimation period to end in January 2023
er <- window(er, end=c(2023, 1))
ffr <- window(ffr, end=c(2023, 1))

# Perform the same estimation and forecasting steps as above
ETS_result <- ets(er, model="ZZZ", damped=NULL, ic="aic")
ARIMA_result <- auto.arima(er, max.p=12, max.q=12, ic="aic")
Y <- ts(cbind(er, ffr))
model_selection <- VARselect(Y, lag.max=12, type="const")
opt_p <- model_selection$selection[1]
VAR_result <- VAR(Y, p=opt_p, type="const")
k <- 6
ETS_forecast <- forecast(ETS_result, h=k)
ARIMA_forecast <- forecast(ARIMA_result, h=k)
VAR_forecast <- forecast(VAR_result, h=k)
ETS_forecast
ARIMA_forecast
VAR_forecast

# For Estimation: 1/1971-2/2023, Forecast: 8/2023
library(forecast)
library(vars)
data_set <- read.csv("JPY&FFR.csv", header=TRUE)
er <- ts(log(data_set$DEXJPUS), start=1971, frequency=12)
ffr <- ts(data_set$FEDFUNDS, start=1971, frequency=12)

# Define the estimation period to end in February 2023
er <- window(er, end=c(2023, 2))
ffr <- window(ffr, end=c(2023, 2))

# Perform the same estimation and forecasting steps as above
ETS_result <- ets(er, model="ZZZ", damped=NULL, ic="aic")
ARIMA_result <- auto.arima(er, max.p=12, max.q=12, ic="aic")
Y <- ts(cbind(er, ffr))
model_selection <- VARselect(Y, lag.max=12, type="const")
opt_p <- model_selection$selection[1]
VAR_result <- VAR(Y, p=opt_p, type="const")
k <- 6
ETS_forecast <- forecast(ETS_result, h=k)
ARIMA_forecast <- forecast(ARIMA_result, h=k)
VAR_forecast <- forecast(VAR_result, h=k)
ETS_forecast
ARIMA_forecast
VAR_forecast

# For Estimation: 1/1971-3/2023, Forecast: 9/2023
library(forecast)
library(vars)
data_set <- read.csv("JPY&FFR.csv", header=TRUE)
er <- ts(log(data_set$DEXJPUS), start=1971, frequency=12)
ffr <- ts(data_set$FEDFUNDS, start=1971, frequency=12)

# Define the estimation period to end in March 2023
er <- window(er, end=c(2023, 3))
ffr <- window(ffr, end=c(2023, 3))

# Perform the same estimation and forecasting steps as above
ETS_result <- ets(er, model="ZZZ", damped=NULL, ic="aic")
ARIMA_result <- auto.arima(er, max.p=12, max.q=12, ic="aic")
Y <- ts(cbind(er, ffr))
model_selection <- VARselect(Y, lag.max=12, type="const")
opt_p <- model_selection$selection[1]
VAR_result <- VAR(Y, p=opt_p, type="const")
k <- 6
ETS_forecast <- forecast(ETS_result, h=k)
ARIMA_forecast <- forecast(ARIMA_result, h=k)
VAR_forecast <- forecast(VAR_result, h=k)
ETS_forecast
ARIMA_forecast
VAR_forecast

# For Estimation: 1/1971-4/2023, Forecast: 10/2023
library(forecast)
library(vars)
data_set <- read.csv("JPY&FFR.csv", header=TRUE)
er <- ts(log(data_set$DEXJPUS), start=1971, frequency=12)
ffr <- ts(data_set$FEDFUNDS, start=1971, frequency=12)

# Define the estimation period to end in April 2023
er <- window(er, end=c(2023, 4))
ffr <- window(ffr, end=c(2023, 4))

# Perform the same estimation and forecasting steps as above
ETS_result <- ets(er, model="ZZZ", damped=NULL, ic="aic")
ARIMA_result <- auto.arima(er, max.p=12, max.q=12, ic="aic")
Y <- ts(cbind(er, ffr))
model_selection <- VARselect(Y, lag.max=12, type="const")
opt_p <- model_selection$selection[1]
VAR_result <- VAR(Y, p=opt_p, type="const")
k <- 6
ETS_forecast <- forecast(ETS_result, h=k)
ARIMA_forecast <- forecast(ARIMA_result, h=k)
VAR_forecast <- forecast(VAR_result, h=k)
ETS_forecast
ARIMA_forecast
VAR_forecast

# For Estimation: 1/1971-5/2023, Forecast: 11/2023
library(forecast)
library(vars)
data_set <- read.csv("JPY&FFR.csv", header=TRUE)
er <- ts(log(data_set$DEXJPUS), start=1971, frequency=12)
ffr <- ts(data_set$FEDFUNDS, start=1971, frequency=12)

# Define the estimation period to end in May 2023
er <- window(er, end=c(2023, 5))
ffr <- window(ffr, end=c(2023, 5))

# Perform the same estimation and forecasting steps as above
ETS_result <- ets(er, model="ZZZ", damped=NULL, ic="aic")
ARIMA_result <- auto.arima(er, max.p=12, max.q=12, ic="aic")
Y <- ts(cbind(er, ffr))
model_selection <- VARselect(Y, lag.max=12, type="const")
opt_p <- model_selection$selection[1]
VAR_result <- VAR(Y, p=opt_p, type="const")
k <- 6
ETS_forecast <- forecast(ETS_result, h=k)
ARIMA_forecast <- forecast(ARIMA_result, h=k)
VAR_forecast <- forecast(VAR_result, h=k)
ETS_forecast
ARIMA_forecast
VAR_forecast

# For Estimation: 1/1971-6/2023, Forecast: 12/2023
library(forecast)
library(vars)
data_set <- read.csv("JPY&FFR.csv", header=TRUE)
er <- ts(log(data_set$DEXJP