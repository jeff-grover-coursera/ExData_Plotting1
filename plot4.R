####################
## Importing Data ##
####################

## Preamble
library(lubridate)
library(readr)
library(dplyr)
setwd("/Users/jeffgrover/Dropbox/Coursera/4 Exploratory Data Analysis/Week 1")

## Import data
data <- read_csv2("household_power_consumption.txt", col_names=TRUE, na="?")

## Cleaning data
#### Dates and times
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- data[data$Date >= dmy("01/02/2007") & data$Date <= dmy("02/02/2007"),]
data$Time <- hms(data$Time)
data$DateTime <- ymd_hms(paste(data$Date, data$Time, sep=" "))

#### Other variables: convert from character to numeric. Figure out which columns to convert after examining with head() or str().
data <- mutate_at(data, c(3,4,6,7,8,9), as.numeric)

############
## Plot 4 ##
############

## Top right plot has voltage axis in thousands of units, not ones.
## So, create a scaled-down variable for voltage.
data$VoltageK <- data$Voltage/1000

png(file = "plot4.png")
par(mfrow = c(2,2))
plot(x = data$DateTime,
     y = data$Global_active_power,
     type = "o",
     pch = "",
     xlab = "",
     ylab = "Global Active Power")
plot(x = data$DateTime,
     y = data$VoltageK,
     type = "o",
     pch = "",
     xlab = "datetime",
     ylab = "Voltage"
)
plot(x = data$DateTime,
     y = data$Sub_metering_1,
     type = "o",
     pch = "",
     xlab = "",
     ylab = "Energy sub metering")
lines(x = data$DateTime,
      y = data$Sub_metering_2,
      col = "red")
lines(x = data$DateTime,
      y = data$Sub_metering_3,
      col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       bty = "n")
plot(x = data$DateTime,
     y = data$Global_reactive_power,
     type = "o",
     pch = "",
     xlab = "datetime")
dev.off()