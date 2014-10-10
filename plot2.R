##Download power consumption data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "household_power_consumption.zip")
##Unzip power consumption file
unzip("household_power_consumption.zip")
##read power consumption data into R
power <-read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   na.strings = "?", colClasses = c("character", "character", "numeric", 
                    "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
##subset power consumption data for 2007-02-01 & 2007-02-02
feb_power <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")
##Create unified Date/Time Field & convert to R class
feb_power$datetime <- paste(feb_power$Date, feb_power$Time)
feb_power$datetime <- strptime(feb_power$datetime, "%d/%m/%Y %H:%M:%S")
##Open PNG file device
png(filename = "plot2.png", width = 480, height = 480, units = "px")
##Build Line Graph of Global Active Power
plot(feb_power$datetime, feb_power$Global_active_power, type = "l", 
              ylab = "Global Active Power (kilowatts)", xlab = "")
##Close PNG file device
dev.off()