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
png("plot2.png")

# Creating the plot
plot(times, consumption$Global_active_power, 
     ylab = "Global Active Power (kilowatts)", xlab = "",
     type = "n", xaxt = "n")
lines(times, consumption$Global_active_power)
axis(1, at = seq(0, times[length(times)], length.out = 3), labels = c("Thu", "Fri", "Sat"))

# Closing the devise
dev.off()
