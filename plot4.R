## read in data
power<-read.table("household_power_consumption.txt", col.names=c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), fill=FALSE, sep=";", stringsAsFactors=FALSE)

## open dplyr, clean data by limiting data to appropriate dates, creating time variable for x axis on plots
library(dplyr)
power$Date2<-strptime(power$Date, "%d/%m/%Y")
power$Date2<-as.Date(power$Date2, "%d/%m/%Y")
power2<-filter(power, Date2 >="2007-02-01", Date2 <= "2007-02-02")

power2$datetime<-paste(power2$Date, power2$Time)
power2$datetime<-strptime(power2$datetime, "%d/%m/%Y %H:%M:%S")

power2$Global_active_power <-as.numeric(power2$Global_active_power)

## create plot 4 in png device
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4, 4, 2, 1), oma=c(0, 0, 2, 0))
with(power2, {plot(power2$Global_active_power, ylab ="Global Active Power (kilowatts)", xlab=" ", type= "l") 
              plot(power2$datetime, power2$Voltage, ylab="Voltage", type="l", xlab="datetime")
              plot(power2$datetime, power2$Sub_metering_1, col="gray", ylab ="Energy Sub metering", xlab=" ", type= "l")
              lines(power2$datetime, power2$Sub_metering_2, col="red")
              lines(power2$datetime, power2$Sub_metering_3, col="blue")
              legend("topright", legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("gray", "red", "blue"), lty= c(1, 1, 1), cex=0.75)
              plot(power2$datetime, power2$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l")
})
dev.off()