if(!file.exists("exdata_data_household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata_data_household_power_consumption.zip",temp)
  unzip(temp)
  unlink(temp)
}

PowerData <- "household_power_consumption.txt"
data <- read.table(PowerData, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
SubSetPower<- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

#plot2
globalActivePower <- as.numeric(SubSetPower$Global_active_power)
datetime <- strptime(paste(SubSetPower$Date, SubSetPower$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
