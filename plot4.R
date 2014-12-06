#prepare clean dataset first

#read full dataset
full_dataset = read.table( "household_power_consumption.txt", sep = ";" , header = TRUE )

#select the subset 2007-02-01 : 2007-02-02
two_days_subset <- full_dataset[ as.Date(full_dataset$Date, format = "%d/%m/%Y") >= "2007-02-01" & as.Date(full_dataset$Date, format = "%d/%m/%Y") <= "2007-02-02" , ]

#convert to numeric
two_days_subset$Global_active_power <- as.numeric(as.character(two_days_subset$Global_active_power))
two_days_subset$Global_reactive_power <- as.numeric(as.character(two_days_subset$Global_reactive_power))
two_days_subset$Voltage <- as.numeric(as.character(two_days_subset$Voltage))
two_days_subset$Sub_metering_1 <- as.numeric(as.character(two_days_subset$Sub_metering_1))
two_days_subset$Sub_metering_2 <- as.numeric(as.character(two_days_subset$Sub_metering_2))
two_days_subset$Sub_metering_3 <- as.numeric(as.character(two_days_subset$Sub_metering_3))


#add date & time column to the dataset
two_days_subset$Date_time <- strptime( paste(two_days_subset$Date, two_days_subset$Time) , "%d/%m/%Y %H:%M:%S")

#display weekdays in english
Sys.setlocale("LC_TIME", "C")

#create plot4 and save it to png
png("plot4.png", width=480, height=480, units="px")

#prepare matrix for multiple plots
par(mfrow=c(2,2))

#1
plot(two_days_subset$Date_time,
     two_days_subset$Global_active_power,
     type = 'l',
     xlab = "",
     ylab = "Global Active Power (kilowatts)"
)

#2
plot(two_days_subset$Date_time,
     two_days_subset$Voltage,
     type = 'l',
     xlab = "datetime",
     ylab = "Voltage"
)

#3
#prepare basic plot with first variable
plot(two_days_subset$Date_time,
     two_days_subset$Sub_metering_1,
     type = 'l',
     xlab = "",
     ylab = "Energy sub metering",
     col = 'black'
)
#add additional variables
lines(two_days_subset$Date_time,
      two_days_subset$Sub_metering_2,
      type = 'l',
      col = "red"
)
lines(two_days_subset$Date_time,
      two_days_subset$Sub_metering_3,
      type = 'l',
      col = "blue"
)
#add legend
legend('topright',
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") , 
       lty=1,
       col=c('black', 'red', 'blue'),
       bty = "n"
)

#4
plot(two_days_subset$Date_time,
     two_days_subset$Global_reactive_power,
     type = 'l',
     xlab = "datetime",
     ylab = "Global_reactive_power"
)

dev.off()

