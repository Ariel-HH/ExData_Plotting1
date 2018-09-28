#### It is assumed that 'household_power_consumption.txt' is in the working dir
library(data.table)
library(dplyr)
library(lubridate)
# Reading all data in 'household_power_consumption.txt'
consumption <- fread("household_power_consumption.txt")
# Filtering relevant dates and changing columns types
consumption <- consumption %>% mutate(Date = dmy(Date)) %>% 
      filter(Date %in% dmy(c('01/02/2007', '02/02/2007'))) %>%
      mutate(Time = hms(Time)) %>%
      mutate_at(3:length(consumption), as.numeric)

# Creating a numeric vector 'times' with 'consumption$Time' data
# measured in seconds ('times' will have the pattern: 0, 60, 120, ...)
times <- seq(0, by = 60, length.out = length(consumption$Time))

# Opening png devise (the default size is the required 480x480 pixels)
png("plot4.png")

# Setting mfrow
par(mfrow = c(2,2))

# Creating the first plot
plot(times, consumption$Global_active_power, 
     ylab = "Global Active Power (kilowatts)", xlab = "",
     type = "n", xaxt = "n")
lines(times, consumption$Global_active_power)
axis(1, at = seq(0, times[length(times)], length.out = 3), labels = c("Thu", "Fri", "Sat"))

# Creating the second plot
plot(times, consumption$Voltage, 
     ylab = "Voltage", xlab = "datetime",
     type = "n", xaxt = "n")
lines(times, consumption$Voltage)
axis(1, at = seq(0, times[length(times)], length.out = 3), labels = c("Thu", "Fri", "Sat"))

# Creating the third plot
plot(times, consumption$Sub_metering_1, 
     ylab = "Energy sub metering", xlab = "",
     type = "n", xaxt = "n")
lines(times, consumption$Sub_metering_1)
lines(times, consumption$Sub_metering_2, col = "red")
lines(times, consumption$Sub_metering_3, col = "blue")
axis(1, at = seq(0, times[length(times)], length.out = 3),
     labels = c("Thu", "Fri", "Sat"))
legend("topright", col = c("black", "red", "blue"), lty = 1 ,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Creating the fourth plot
plot(times, consumption$Global_reactive_power, 
     ylab = "Global_reactive_power", xlab = "datetime",
     type = "n", xaxt = "n")
lines(times, consumption$Global_reactive_power)
axis(1, at = seq(0, times[length(times)], length.out = 3), labels = c("Thu", "Fri", "Sat"))

# Closing the devise
dev.off()
