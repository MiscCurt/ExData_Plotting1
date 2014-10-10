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
png(filename = "plot4.png", width = 480, height = 480, units = "px")
##Initialize multiple graphs
par(mfrow = c(2,2))
##Build Line Graph of Global Active Power in Upper Left
plot(feb_power$datetime, feb_power$Global_active_power, type = "l", 
     ylab = "Global Active Power", xlab = "")
##Build Line Graph of Voltage in Upper Right
plot(feb_power$datetime, feb_power$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
##Build Line Graph of Energy Sub metering in Upper Left
plot(feb_power$datetime, feb_power$Sub_metering_1, type = "l", ylab = "Energy sub metering", 
     xlab = "")
    lines(feb_power$datetime, feb_power$Sub_metering_2, col = "red")
    lines(feb_power$datetime, feb_power$Sub_metering_3, col = "blue")
    ##Add Legend
    legend("topright", lwd = 2, bty = "n", col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
##Build Line Graph of Global Reactive Power in Lower Right
plot(feb_power$datetime, feb_power$Global_reactive_power, type = "l", ylab = "Global_reactive_power", 
     xlab = "datetime")
##Close PNG file device
dev.off()