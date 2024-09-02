
# Time Series Forecasting using ARIMA Models

This document provides a detailed overview of the R script titled `Time Series Forecasting using ARIMA models.R`, which focuses on forecasting time series data using ARIMA models. The script is designed to analyze economic indicators and generate forecasts with a strong emphasis on accuracy and model selection.

## Script Overview

The script performs the following key tasks:

### 1. Data Loading
The script begins by loading a CSV file containing two primary economic indicators:
- **U.S. Unemployment Rate (UNRATE)**
- **U.S. Dollar to Japanese Yen Exchange Rate (DEXJPUS)**

The data is read into R using the `read.csv` function and is subsequently converted into time series objects (`ts`) for further analysis.

```r
data_set <- read.csv("UR&JPY.csv", header=TRUE)
ur <- ts(data_set$UNRATE, start=1971, frequency=12)
er <- ts(log(data_set$DEXJPUS), start=1971, frequency=12)
```

### 2. ARIMA Model Selection
The script utilizes the `auto.arima` function from the `forecast` package to automatically select the best ARIMA model based on various information criteria:
- **AIC (Akaike Information Criterion)**
- **AICc (Corrected AIC)**
- **BIC (Bayesian Information Criterion)**

Three different ARIMA models are fitted to the unemployment rate data (`ur`) based on these criteria.

```r
ARpq_result_ur_aic <- auto.arima(ur, max.p=12, max.q=12, max.d=0, ic="aic")
ARpq_result_ur_aicc <- auto.arima(ur, max.p=6, max.q=6, max.d=0, ic="aicc")
ARpq_result_ur_bic <- auto.arima(ur, max.p=6, max.q=6, max.d=0, ic="bic")
```

### 3. Model Summarization
For each selected model, the script outputs a detailed summary, which includes:
- Model coefficients
- Statistical significance of the coefficients
- Residual analysis
- Model fit metrics (AIC, BIC, etc.)

This step helps in understanding the underlying ARIMA model and its components.

```r
summary(ARpq_result_ur_aic)
summary(ARpq_result_ur_aicc)
summary(ARpq_result_ur_bic)
```

### 4. Forecasting
Using the best-selected model (based on AIC), the script generates a 12-month forecast for the unemployment rate. The forecast is stored in an object and later used for visualization.

```r
ARpq_forecast <- forecast(ARpq_result_ur_aic, h=12)
```

### 5. Data Preparation for Visualization
The script prepares the data for visualization by creating a subset of the original unemployment rate data with some missing values (NA) to simulate a real forecasting scenario. This data is then plotted against the forecasted values.

```r
ur_ <- data_set$UNRATE
ur_[638:651] <- NA
ur2_ <- ts(ur_, start=1971, frequency=12)
ur2_subset <- subset(ur2_, start=500)
```

### 6. Visualization
The script uses `ggplot2` to create a plot that overlays the original data and the forecasted values. This visualization provides a clear comparison between the actual data and the ARIMA model predictions.

```r
autoplot(ur2_subset, xlab="Time", ylab="Percent", main="U.S. Unemployment Rate: Forecasts for the Next 12 Months") +
autolayer(ARpq_forecast)
```

### 7. Exchange Rate Forecasting
In addition to the unemployment rate, the script also forecasts the U.S. Dollar to Japanese Yen exchange rate using similar ARIMA modeling techniques. The exchange rate data is truncated to the first 625 observations before model fitting and forecasting.

```r
er_est <- er[1:625]
ARpq_result_er_aic <- auto.arima(er_est, max.p=12, max.q=12, max.d=0, ic="aic")
ARpq_forecast_aic <- forecast(ARpq_result_er_aic, h=12)
```

### 8. Random Walk Forecasting
For comparison, the script also applies a Random Walk Forecasting (RWF) model with and without drift to the exchange rate data, providing an alternative forecasting method.

```r
rwf_no_drift <- rwf(er_est, h=12, drift=FALSE)
rwf_drift <- rwf(er_est, h=12, drift=TRUE)
```

### 9. Results Tabulation
Finally, the script tabulates the actual values, ARIMA forecasted values, and RWF forecasted values for the exchange rate over the forecast period, allowing for easy comparison between different models.

```r
Table2 <- matrix(0, 12, 6)
Table2[,1] <- er[626:637]
Table2[,2] <- ARpq_forecast_aic$mean
Table2[,5] <- rwf_no_drift$mean
Table2[,6] <- rwf_drift$mean
```