if(!file.exists("exdata_data_household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata_data_household_power_consumption.zip",temp)
  unzip(temp)
  unlink(temp)
}

PowerData <- "./data/household_power_consumption.txt"
data <- read.table(PowerData, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
SubSetPower <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]


globalActivePower <- as.numeric(SubSetPower$Global_active_power)
datetime <- strptime(paste(SubSetPower$Date, SubSetPower$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

globalReactivePower <- as.numeric(SubSetPower$Global_reactive_power)
voltage <- as.numeric(SubSetPower$Voltage)
subMetering1 <- as.numeric(SubSetPower$Sub_metering_1)
subMetering2 <- as.numeric(SubSetPower$Sub_metering_2)
subMetering3 <- as.numeric(SubSetPower$Sub_metering_3)


png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()