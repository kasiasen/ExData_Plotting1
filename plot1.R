#prepare clean dataset first

#read full dataset
full_dataset = read.table( "household_power_consumption.txt", sep = ";" , header = TRUE )

#select the subset 2007-02-01 : 2007-02-02
two_days_subset <- full_dataset[ as.Date(full_dataset$Date, format = "%d/%m/%Y") >= "2007-02-01" & as.Date(full_dataset$Date, format = "%d/%m/%Y") <= "2007-02-02" , ]

#convert variables to numeric
two_days_subset$Global_active_power <- as.numeric(as.character(two_days_subset$Global_active_power))

#add date & time column to the dataset
two_days_subset$Date_time <- strptime( paste(two_days_subset$Date, two_days_subset$Time) , "%d/%m/%Y %H:%M:%S")

#display weekdays in english
Sys.setlocale("LC_TIME", "C")

#create plot1 and save it to png
png("plot1.png", width=480, height=480, units="px")

hist(two_days_subset$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power", 
     col = "red"
)

dev.off() 

