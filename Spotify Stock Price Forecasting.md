# Spotify Stock Price Analysis and Forecasting

This project involves converting daily stock price data into monthly averages, extracting end-of-month data, plotting the stock price, producing forecasts, and evaluating the accuracy of those forecasts using Mean Absolute Error (MAE) and Root Mean Squared Error (RMSE).

## Dataset

The dataset used in this project is named `SPOT.csv`, which contains daily stock prices for Spotify. The key columns in the dataset include:
- `Date`: The date of the observation
- `Close`: The closing price of the stock on that date

## Requirements

- **R version** 3.5.0 or higher
- **R packages**:
  - `lubridate`: For handling dates and extracting months
  - `ggplot2`: For plotting stock prices
  - `forecast`: For time series forecasting models

Install the required packages using the following commands:
```r
install.packages("lubridate")
install.packages("ggplot2")
install.packages("forecast")