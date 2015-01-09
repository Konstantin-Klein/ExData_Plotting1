# ------------------------------------------------------------------
# Task for the course project: 

# * Construct the plot and save it to a PNG file with a width of 480
# pixels and a height of 480 pixels.

# * Name each of the plot files as `plot1.png`, `plot2.png`, etc.

# * Create a separate R code file (`plot1.R`, `plot2.R`, etc.) that
# constructs the corresponding plot, i.e. code in `plot1.R` constructs
# the `plot1.png` plot. Your code file **should include code for reading
# the data** so that the plot can be fully reproduced. You should also
# include the code that creates the PNG file.

# * Add the PNG file and R code file to your git repository

### Plot 3

# Time Fluctuations of Energy Sub Metering

# ------------------------------------------------------------------
library(data.table)

# cleaning memory, setting file system parameters
rm(list = ls())
Sys.setlocale("LC_TIME", "en_US.UTF-8")

setwd("~/CloudMailRu/Learning/R/Explore\ \ -\ project\ 1")  # set your working directory here
if(!file.exists("../raw"))  dir.create("../raw")

# downloading and unzipping the data, checking for errors
if(!file.exists("../raw/Consumption.zip")) {
      print(noquote("downloading datafile from URL"))
      fileUrl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileUrl, "../raw/Consumption.zip", method = "curl")
} else print(noquote("Datafile found"))

filename = "../raw/household_power_consumption.txt"

if(!file.exists(filename)){
      print(noquote("No dataset found. Unzipping data from archive"))
      unzip("../raw/Consumption.zip", exdir = "../raw")}

# reading filtered data into R
print(noquote("Reading data into R"))
dtime <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"),units="mins")
rowsToRead <- as.numeric(dtime)
data <- fread(filename, skip="1/2/2007", nrows = rowsToRead, na.strings = c("?", ""))
setnames(data, colnames(fread(filename, nrows=0)))

# build timeline for the data
data$date_time <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S") 

# building a new plot
print(noquote("Building a new plot"))
graphics.off()
if (dev.cur() !=2) dev.new()  # platform dependent. Used for RStudio. 
par(bg = "transparent")
plot(x = data$date_time, y = data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "") 
lines(x = data$date_time, y = data$Sub_metering_2, col = "red") 
lines(x = data$date_time, y = data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       text.width = strwidth("1,000,000,000,000"))

print(noquote("Building the same plot to a PNG device"))  # dev.copy is not flexible enough
png(file = "plot3.png", width = 480, height = 480, units = "px", 
      pointsize = 12, bg = "transparent")
plot(x = data$date_time, y = data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "") 
lines(x = data$date_time, y = data$Sub_metering_2, col = "red") 
lines(x = data$date_time, y = data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       text.width = strwidth("1,000,000,000,000"))

# closing off
print(noquote("Closing the file"))
dev.off()
print(noquote("Done!"))

