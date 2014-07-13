library(datasets)

#get the data into a data table
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "download.zip", method = "curl")
unzip("download.zip")
dt <- read.csv("household_power_consumption.txt", header =  TRUE , sep = ";")

#fix the date
dt$Date2 <- as.Date(strptime(dt$Date, "%d/%m/%Y"))

#subset
dt <- dt[dt$Date2 == "2007-02-01" | dt$Date2 == "2007-02-02",]

#fix the data source to be numeric
dt$Sub_metering_1 <- as.numeric(as.character(dt$Sub_metering_1))
dt$Sub_metering_2 <- as.numeric(as.character(dt$Sub_metering_2))
dt$Sub_metering_3 <- as.numeric(as.character(dt$Sub_metering_3))
dt$Voltage <- as.numeric(as.character(dt$Voltage))
dt$Global_reactive_power <- as.numeric(as.character(dt$Global_reactive_power))
dt$Datetime <- as.POSIXct(paste ( dt$Date2, dt$Time), format="%Y-%m-%d %H:%M:%S")

#open file
png(filename = "plot4.png", width = 480, height = 480)

#set the number of visualisation rows, cols
par(mfrow = c(2,2))


#first vis
plot(dt$Datetime, as.numeric(as.character(dt$Global_active_power)), type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")


#second vis
plot(dt$Datetime , dt$Voltage, type = "l", ylab = "Voltage"
     ,xlab = "datetime")

#third vis
plot(dt$Datetime , dt$Sub_metering_1, type = "l", ylab = "Energy sub metering"
     ,xlab = "")
lines(dt$Datetime, dt$Sub_metering_2, col = "Red")
lines(dt$Datetime, dt$Sub_metering_3, col = "Blue")
legend("topright", lty= c(1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c ("Black", "Red", "Blue"), bty = "n")

#fourth vis

plot(dt$Datetime , dt$Global_reactive_power, type = "l", ylab = "Global_reactive_power"
     ,xlab = "datetime")

#close the file
dev.off()


