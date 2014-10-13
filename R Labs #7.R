##################################################################
##################################################################
### R Tutorials
### Lab #7
##################################################################
##################################################################

### Time series
### package XTS (extended time series)
require(WDI)

gdp <- WDI(country=c("US", "CA", "GB", "CN", "JP"), indicator=c("NY.GDP.PCAP.CD", "NY.GDP.MKTP.CD"),
          start=1960, end=2011)
head(gdp)

require(ggplot2)
require(plyer)

names(gdp) <- c("iso2c", "Country", "Year", "PerCapGDP", "GDP")
ggplot(data=gdp, mapping=aes(x=Year, y=PerCapGDP)) + geom_line(aes(color=Country, linetype=Country))

us <- gdp$PerCapGDP[gdp$Country == "United States"]
head(us)
us <- ts(us, start=min(gdp$Year), end=max(gdp$Year))
us
acf(us) # autocorrelation graph - this example shows a nonstationary graph (graph decreases - nonstationary)
pacf(us) # partial autocorreation graph 

# ARIMA Model - the time series needs to be stationary (in this exemple the data is nonstationary)
# so we need to nonstationarity before we run ARIMA
# todays price is related to yesterday's price
plot(us)
plot(diff(us)) # a difference of one in order to deal with nonstationarity
require(forecast)
# gives the best combination
usBest <- auto.arima(x=us)
usBest
# ARIMA(2,2,1)  
  # 2 for the AR component
  # 2 how many times you difference the data
  # 1 stands for MA component
plot(diff(us, differences=2))
plot(usBest$residuals) # we want residuals to be white noise, however the recession is skrewing our model
acf(usBest$residuals) # non are going above the blue line, means white noise, the first one has to spike up
pacf(usBest$residuals) # nothing spikes above the blue line, white noise
predict(usBest, n.ahead=5, se.fit=TRUE) # predict 5 years ahead with SE
theForecast  <- forecast(usbest, h=5)
plot(theForecast)

### GARCH MODEL
require(quantmod)
att <- getSymbols("T", auto.assign=FALSE)
att
head(att)

require(xts)
plot(att)
chartSeries(att)
addBBands()
addMACD(32, 50, 12) # ading moving average

attClose <- att$T.Close
class(attClose) # [1] "xts" "zoo"     # xts package build upon zoo package
head(attClose)

require(rugarch)

# Create a spec to specify the parameters of the model
attSpec <- ugarchspec(variance.model=list(model="sGARCH", garchOrder=c(1,1)), 
                      mean.model=list(armaOrder=c(1,1)), 
                      distribution.model="std")

attGarch <- ugarchfit(spec=attSpec, data=attClose)
attGarch

head(gdp)
usDF <- gdp[gdp$Country == "United States", ]
head(usDF)
ggplot(usDF, aes(x=Year, y=log(PerCapGDP), size=GDP)) + geom_point(shape=7) + 
       geom_text(x=1990, y=9, label="Alabama", size=5)
