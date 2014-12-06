#prepare clean dataset first

#read full dataset
full_dataset = read.table( "household_power_consumption.txt", sep = ";" , header = TRUE )

#select the subset 2007-02-01 : 2007-02-02
two_days_subset <- full_dataset[ as.Date(full_dataset$Date, format = "%d/%m/%Y") >= "2007-02-01" & as.Date(full_dataset$Date, format = "%d/%m/%Y") <= "2007-02-02" , ]

#convert to numeric
two_days_subset$Sub_metering_1 <- as.numeric(as.character(two_days_subset$Sub_metering_1))
two_days_subset$Sub_metering_2 <- as.numeric(as.character(two_days_subset$Sub_metering_2))
two_days_subset$Sub_metering_3 <- as.numeric(as.character(two_days_subset$Sub_metering_3))


#add date & time column to the dataset
two_days_subset$Date_time <- strptime( paste(two_days_subset$Date, two_days_subset$Time) , "%d/%m/%Y %H:%M:%S")

#display weekdays in english
Sys.setlocale("LC_TIME", "C")

#create plot3 and save it to png
png("plot3.png", width=480, height=480, units="px")

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
       cex = 0.9
)

dev.off()
