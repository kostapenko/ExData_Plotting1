library(chron)

# Reading and preparing data
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(url, "data.zip")

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", row.names = NULL)

date <- strptime(data$Date, format = '%d/%m/%Y')
time <- chron(times. = data$Time)
datetime.string <- paste(as.character(date), as.character(time), sep = ' ')
datetime <- strptime(datetime.string, format = "%Y-%m-%d %H:%M:%S")

Sys.setlocale("LC_TIME","English")
data$Date <- date
data$Time <- time
data$datetime <- datetime
data$weekday <- weekdays(date)

dt <- data[data$Date == '2007-02-01' | data$Date == '2007-02-02', ]

# Plot 4    
png(filename = "plot4.png")
par(mfrow = c(2, 2))

plot(dt$datetime, 
     as.numeric(as.character(dt$Global_active_power)), 
     type = 'l', 
     col = 'black',
     xlab = "",
     ylab = "Global Active Power")

plot(dt$datetime, 
     as.numeric(as.character(dt$Voltage)), 
     type = 'l', 
     col = 'black',
     xlab = "datetime",
     ylab = "Voltage")

plot(dt$datetime, 
     as.numeric(as.character(dt$Sub_metering_1)), 
     type = 'l', 
     col = 'black',
     xlab = "",
     ylab = "Energy sub metering",
     ylim = c(0, 40))
lines(dt$datetime, as.numeric(as.character(dt$Sub_metering_2)), type = 'l', col = 'blue')
lines(dt$datetime, as.numeric(as.character(dt$Sub_metering_3)), type = 'l', col = 'orange')

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1),
       col = c('black', 'blue', 'orange'),
       cex = 0.8, 
       bty = "n")

plot(dt$datetime,
     as.numeric(as.character(dt$Global_reactive_power)), 
     type = 'o',
     col = "black", 
     xlab = "",
     ylab = "Global_reactive_power",
     pch = 20)

dev.off()

