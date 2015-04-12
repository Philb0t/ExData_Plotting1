##    Read in and clean the electric power consumption dataset containing measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years from the UC Irvine Machine Learning Repository. 
##    MAKE SURE YOU SET YOUR WORKING DIRECTORY. ALL FILES AND ACTONS PERFORMED IN WORKING DIR.
##    Checks if dataset is downloaded and unzipped in Working Dir, if it is not, it downloads the file. dataset sucessfully downloaded from URL on 10/4/2015.

localData <- "household_power_consumption.txt"

if (!file.exists(localData)) {
  url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  temp <- tempfile()
  download.file(url, temp)
  unzip(temp)
}

library("sqldf")    ##  We will use the sqldf package for reading in the file, using sql to select for specific dates.

powerDataSubset <- read.csv2.sql(file = "household_power_consumption.txt", "select * from file where Date in ('1/2/2007','2/2/2007')")

##    Plot 1: Output file as a png called plot1.png located in the working directory.

png(file = "plot1.png", bg = 'transparent')    
hist(powerDataSubset$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()






##  NOTES
##  Can check for '?' but there are none in this data subset. I was thinking it would be good to write a bit of re-usable 
##  code to check for ? or ?\n or NA's or any missing value really and replace it with any value you want e.g. NA.
##  maybe will do it if I have time