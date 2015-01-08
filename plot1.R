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

### Plot 1


# Histogram of Global Active Power


# ------------------------------------------------------------------

# cleaning memory, setting file system parameters
# rm(list = ls())
setwd("~/CloudMailRu/Learning/R/Explore\ \ -\ project\ 1")  # set your working directory here
if(!file.exists("../raw"))  dir.create("../raw")

# downloading and unzipping the data, checking for errors
if(!file.exists("../raw/Consumption.zip")) {
      print(noquote("downloading datafile from URL"))
      fileUrl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileUrl, "../raw/Consumption.zip", method = "curl")
      } else print(noquote("Datafile found"))

if(!file.exists("../raw/household_power_consumption.txt")){
      print(noquote("No dataset found. Unzipping data from archive"))
      unzip("../raw/Consumption.zip", exdir = "../raw")}

# reading data into R
print(noquote("Reading data into R"))
data <- read.table("../raw/household_power_consumption.txt", 
      header = TRUE, sep = ";", 
      stringsAsFactors = FALSE, 
      na.strings = c("?", ""))

print(noquote("Filtering data by range of dates"))
data <- data[data$Date %in% c("1/2/2007","2/2/2007"), ]

# building a new plot to a PNG device
print(noquote("Building a new plot to a PNG device"))
png(file = "plot1.png", width = 480, 
    height = 480, units = "px", 
    pointsize = 12, 
    bg = "transparent")
hist(data$Global_active_power, 
    main = "Global Active Power", 
    col = "Red", 
    xlab = "Global Active Power (kilowatts)")

# closing off
print(noquote("Closing the file"))
dev.off()
print(noquote("Done!"))

