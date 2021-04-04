## Assignment: Exploratory data analysis - Course Project 1
## Author: Puneet Singla
## Problem Statement: Plot4

## This R script has one function: plot4

plot4 <- function() {
  
  ## Declare file path
  url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  flnm_zip = "household_power_consumption.zip"
  
  ## Download the zip file and unzip it
  if(!file.exists(flnm_zip)) {
    download.file(url, flnm_zip)
    unzip(flnm_zip)
  }
  
  ## Read the data file
  pwr_data <- read.table("household_power_consumption.txt",stringsAsFactors = FALSE, sep = ";", header = TRUE, na.strings = "?")
  
  ## Massage the data file
  pwr_data$datetime <- strptime(paste(pwr_data$Date,pwr_data$Time),"%d/%m/%Y %H:%M:%S")
  pwr_data$Date <- as.Date(pwr_data$Date,"%d/%m/%Y")
  
  ## Take a subset of the data file. Time period:2007-02-01 and 2007-02-02
  pwr_data_subset <- subset(pwr_data, pwr_data$Date>="2007-02-01" & pwr_data$Date<="2007-02-02")
  
  ## Generate Plot4
  par(mfcol = c(2,2))
  
  ## Plot 1 of 4
  plot(pwr_data_subset$datetime, pwr_data_subset$Global_active_power, type="l", ylab="Global Active Power", xlab="")
  
  ## Plot 2 of 4
  plot(pwr_data_subset$datetime, pwr_data_subset$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", col="black")
  lines(pwr_data_subset$datetime, pwr_data_subset$Sub_metering_2, col="red")
  lines(pwr_data_subset$datetime, pwr_data_subset$Sub_metering_3, col="blue")
  legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=2, text.width = strwidth("Sub_metering_1")*1.5, cex=0.9, bty="n")
  
  ## Plot 3 of 4
  plot(pwr_data_subset$datetime, pwr_data_subset$Voltage, type="l", ylab="Voltage", xlab="datetime")
  
  ## Plot 4 of 4
  plot(pwr_data_subset$datetime, pwr_data_subset$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
  
  ## Generate PNG file
  dev.copy(png, file="plot4.png")
  dev.off()
  
}