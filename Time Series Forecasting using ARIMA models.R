library(forecast)

data_set <- read.csv("UR&JPY.csv",header=TRUE)

ur <- ts(data_set$UNRATE,start=1971,frequency=12)

er <- ts(log(data_set$DEXJPUS),start=1971,frequency=12)

ARpq_result_ur_aic <- auto.arima(ur,max.p=12,max.q=12,max.d=0,ic="aic")

summary(ARpq_result_ur_aic)

ARpq_result_ur_aicc <- auto.arima(ur,max.p=6,max.q=6,max.d=0,ic="aicc")

summary(ARpq_result_ur_aicc)

ARpq_result_ur_bic <- auto.arima(ur,max.p=6,max.q=6,max.d=0,ic="bic")

summary(ARpq_result_ur_bic)

ARpq_forecast <- forecast(ARpq_result_ur_aic,h=12)

ur_ <- data_set$UNRATE

ur_[638:651] <- NA

ur2_ <- ts(ur_,start=1971,frequency=12)

ur2_subset <- subset(ur2_,start=500)

autoplot(ur2_subset,xlab="Time",ylab="Percent",main="U.S. Unemployment Rate: Forecasts for the Next 12 Months")+autolayer(ARpq_forecast)

er_est <- er[1:625]

ARpq_result_er_aic <- auto.arima(er_est,max.p=12,max.q=12,max.d=0,ic="aic")
ARpq_forecast_aic <- forecast(ARpq_result_er_aic,h=12)
ARpq_forecast_aic
summary(ARpq_forecast_aic)

rwf_no_drift <- rwf(er_est,h=12,drift=FALSE)
rwf_no_drift

er_est <- er[1:625] 
rwf_drift <- rwf(er_est,h=12,drift=TRUE)
rwf_drift

Table2 <- matrix(0,12,6)

Table2[,1] <- er[626:637]
Table2[,2] <- ARpq_forecast_aic$mean
Table2[,5] <- rwf_no_drift$mean
Table2[,6] <- rwf_drift$mean


