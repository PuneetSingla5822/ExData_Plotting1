## Assignment: Exploratory data analysis - Course Project 1
## Author: Puneet Singla
## Problem Statement: Plot1

## This R script has one function: plot1

plot1 <- function() {
  
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
  
  ## Generate Plot1
  par(mfrow = c(1,1))
  hist(pwr_data_subset$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
  
  ## Generate PNG file
  dev.copy(png, file="plot1.png")
  dev.off()
  
}