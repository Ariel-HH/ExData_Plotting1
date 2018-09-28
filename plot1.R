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

# Opening png devise (the default size is the required 480x480 pixels)
png("plot1.png")

# Creating the plot
hist(consumption$Global_active_power, xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power", col = "red")

# Closing the devise
dev.off()
