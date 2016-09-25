# For each plot you should
#      Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#      Name each of the plot files as plot1.png, plot2.png, etc.
#      Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, 
#            i.e. code in plot1.R constructs the plot1.png plot. 
#            Your code file should include code for reading the data so that the plot can be fully reproduced. 
#            You should also include the code that creates the PNG file.
#      Add the PNG file and R code file to your git repository

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

data2 <- data
data <- data2

## Cleaning data
#### Dates and times
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- data[data$Date >= dmy("01/02/2007") & data$Date <= dmy("02/02/2007"),]
data$Time <- hms(data$Time)
data$DateTime <- ymd_hms(paste(data$Date, data$Time, sep=" "))

#### Other variables: convert from character to numeric. Figure out which columns to convert after examining with head() or str().
data <- mutate_at(data, c(3,4,6,7,8,9), as.numeric)

############
## Plot 1 ##
############

png(file = "plot1.png")
hist(data$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = " Global Active Power (kilowatts)"
     )
dev.off()

############
## Plot 2 ##
############

png(file = "plot2.png")
plot(x = data$DateTime,
     y = data$Global_active_power,
     type = "o",
     pch = "",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()

############
## Plot 3 ##
############

png(file = "plot3.png")
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
       lty = 1)
dev.off()

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