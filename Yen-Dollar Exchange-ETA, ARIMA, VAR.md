# Yen-Dollar Exchange Rate and Federal Funds Rate Forecasting using ETS, ARIMA and VAR Forecasting

This project involves forecasting the Yen-Dollar exchange rate (`DEXJPUS`) using various time series models, including Exponential Smoothing State Space Model (ETS), ARIMA, and Vector Autoregression (VAR). The forecasts are performed over different periods, with estimation periods ending in different months of 2023 and forecasting the subsequent months.

## Dataset

The dataset used in this project is named `JPY&FFR.csv`, containing the following columns:
- `DEXJPUS`: The exchange rate between the Japanese Yen and U.S. Dollar
- `FEDFUNDS`: The Federal Funds Rate

The data spans from January 1971 to July 2023.

## Requirements

- **R version** 3.5.0 or higher
- **R packages**:
  - `forecast`: For time series forecasting models
  - `vars`: For vector autoregressive (VAR) models

Install the required packages using the following commands:
```r
install.packages("forecast")
install.packages("vars")