library(datasets)

#get data into table
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "download.zip", method = "curl")
unzip("download.zip")
dt <- read.csv("household_power_consumption.txt", header =  TRUE , sep = ";")

dt$Date2 <- as.Date(strptime(dt$Date, "%d/%m/%Y"))

#subset
dt <- dt[dt$Date2 == "2007-02-01" | dt$Date2 == "2007-02-02",]

#merge time and date
dt$Datetime <- as.POSIXct(paste ( dt$Date2, dt$Time), format="%Y-%m-%d %H:%M:%S")

#open file
png(filename = "plot2.png", width = 480, height = 480)

plot(dt$Datetime, as.numeric(as.character(dt$Global_active_power)), type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")

#close file
dev.off()


