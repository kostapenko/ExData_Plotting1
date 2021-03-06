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

# Plot 2
png(filename = "plot2.png")
plot(dt$datetime, 
     as.numeric(as.character(dt$Global_active_power)),
     type = 'l', 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()
