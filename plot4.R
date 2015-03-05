powerData<-read.table(fileList[2], header = TRUE, sep = ";", na.strings = "NA", stringsAsFactors = FALSE, nrows = 75000)    ##  The second item in the list contains our textfile string, here we read it into R, I found via looking through the data that the dates we want are within the first 75,000 lines, so I only read in the first 75,000 lines and not the 2.5 million.

powerData$Date <- as.Date(powerData$Date, '%d/%m/%Y')
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")

powerData <- subset(powerData, Date >= date1 & Date <= date2)     ##    subset data via the dates that we are interested in

powerData$Global_active_power <- as.numeric(powerData$Global_active_power)    ##    almost all the variables have been coerced to characters, I had trouble with some operations because of this for plot one so I converted it to numeric.

##    creaded a POSIXlt variable by combining 
##    date and time to use in some of the 
##    plots (for x-axis)   

powerData$Timestamp <- paste(powerData$Date, powerData$Time)
powerData$Timestamp <- as.POSIXlt(powerData$Timestamp)

##    Plot 4: Output file as a png            
##    as plot4.png in the working directory  

png(file = "plot4.png", bg = 'transparent') 
par(mfcol = c(2,2))

plot(powerData$Timestamp,powerData$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

plot(powerData$Timestamp, powerData$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(powerData$Timestamp, powerData$Sub_metering_2, col = "red")
lines(powerData$Timestamp, powerData$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), bty = "n", merge = TRUE)

plot(powerData$Timestamp,powerData$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

plot(powerData$Timestamp,powerData$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()