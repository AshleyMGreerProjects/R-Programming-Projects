# Yen-Dollar Exchange Rate Analysis and Forecasting

This project focuses on analyzing and forecasting the Yen-Dollar exchange rate (`DEXJPUS`) using time series models such as ARIMA and ETS. The analysis includes forecasting future exchange rates, evaluating model accuracy, and visualizing the results.

## Dataset

The dataset used in this project is named `DEXJPUS(Updated).csv`, containing the following columns:
- `DATE`: The date of each observation
- `DEXJPUS`: The exchange rate between the Japanese Yen and U.S. Dollar

The data is processed to remove null values and is used for time series analysis with a monthly frequency.

## Requirements

- **R version** 3.5.0 or higher
- **R packages**:
  - `forecast`: For time series forecasting and model fitting
  - `vars`: For vector autoregression models (loaded but not used)
  - `lubridate`: For date manipulation and handling
  - `imputeTS`: For handling missing data via interpolation

Install the required packages using the following commands:
```r
install.packages("forecast")
install.packages("vars")
install.packages("lubridate")
install.packages("imputeTS")