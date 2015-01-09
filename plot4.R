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

### Plot 4

# Time Fluctuations of 4 main parameters: 
# Globai Active Power, Voltage, Energy Sub Metering, Global Reactive Power

# ------------------------------------------------------------------

library(data.table)

# cleaning memory, setting file system parameters
rm(list = ls())
#Sys.setlocale("LC_ALL", 'en_GB.UTF-8') # my system is Russian. By default all labels on graphs wil be in Russian.
#Sys.setenv(LANG = "en_US.UTF-8")
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
print(noquote("Adding date_time column to data"))
data$date_time <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S") 

# building four plots on one screen device
print(noquote("Building four plots on one screen device"))
graphics.off()
if (dev.cur() !=2) dev.new()  # platform dependent. Used for RStudio. 
par(bg = "transparent")
par(mfcol = c(2,2))
par(cex = 0.6)

# plot 1
plot(x = data$date_time, y = data$Global_active_power, 
     type = "l", main = "",
     ylab = "Global Active Power",
     xlab = "") 

# plot 2
plot(x = data$date_time, y = data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "") 
lines(x = data$date_time, y = data$Sub_metering_2, col = "red") 
lines(x = data$date_time, y = data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       text.width = strwidth("100,000,000,000,000"), bty = "n")

# plot 3
plot(x = data$date_time, y = data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# plot 4
plot(x = data$date_time, y = data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# copying the plots to PNG
print(noquote("Copying the plot to a PNG device"))
dev.copy(png, file = "plot4.png", width = 480, 
      height = 480, units = "px", 
      pointsize = 12, 
      bg = "transparent")

# closing off
print(noquote("Closing the file"))
dev.off()
print(noquote("Done!"))

