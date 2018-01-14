## This assignment uses data from the UC Irvine Machine Learning Repository,
## a popular repository for machine learning datasets. 
## In particular, we will be using the ¡§Individual household electric power
## consumption Data Set¡¨  
 
## Description: Measurements of electric power consumption in one household with 
## a one-minute sampling rate over a period of almost 4 years. Different
## electrical quantities and some sub-metering values are available.


library(data.table)

downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- "./data/household_power_consumption.zip"
electricConsumptionFile<- "./data/household_power_consumption.txt"
 
if (!file.exists(electricConsumptionFile)) {
  download.file(downloadURL, downloadFile)
  unzip(downloadFile, overwrite = T, exdir = "./data")
}

electricData <- read.table(electricConsumptionFile, header=T, sep=";", na.strings="?")
head(subElectricData)
subElectricData <- electricData[electricData$Date %in% c("1/2/2007","2/2/2007"),]

SetTime <-strptime(paste(subElectricData$Date, subElectricData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
subElectricData <- cbind(SetTime, subElectricData )


## Generating Plot 4
par(mfrow=c(2,2))

linesColours <- c("black","red","blue")
labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")

plot(subElectricData$SetTime, subElectricData$Global_active_power, type="l", col="green", xlab="", ylab="Global Active Power")
plot(subElectricData$SetTime, subElectricData$Voltage, type="l", col="orange", xlab="datetime", ylab="Voltage")

plot(subElectricData$SetTime, subElectricData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(subElectricData$SetTime, subElectricData$Sub_metering_2, type="l", col="red")
lines(subElectricData$SetTime, subElectricData$Sub_metering_3, type="l", col="blue")
legend("topright", bty="n", legend=labels, lty=1, col=linesColours )

plot(subElectricData$SetTime, subElectricData$Global_reactive_power, type="l", col="blue", xlab="datetime", ylab="Global_reactive_power")