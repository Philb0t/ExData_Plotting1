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

##    creaded a POSIXlt variable called Timestamp by combining 
##    date (converted to a Date object) and time

powerDataSubset$Date <- as.Date(powerDataSubset$Date, '%d/%m/%Y')
powerDataSubset$Timestamp <- paste(powerDataSubset$Date, powerDataSubset$Time)
powerDataSubset$Timestamp <- as.POSIXlt(powerDataSubset$Timestamp)


##    Plot 4: Output file as a png            
##    as plot4.png in the working directory  

png(file = "plot4.png", bg = 'transparent') 
par(mfcol = c(2,2))

plot(powerDataSubset$Timestamp,powerDataSubset$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

plot(powerDataSubset$Timestamp, powerDataSubset$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(powerDataSubset$Timestamp, powerDataSubset$Sub_metering_2, col = "red")
lines(powerDataSubset$Timestamp, powerDataSubset$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), bty = "n", merge = TRUE)

plot(powerDataSubset$Timestamp,powerDataSubset$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

plot(powerDataSubset$Timestamp,powerDataSubset$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()
