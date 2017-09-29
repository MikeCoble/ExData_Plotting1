#### Exploratory Data Analysis : Week 1 : Project 1 : Plot 3

## Specify the column formats 
cols <- cols( Date = col_character(),
              Time = col_character(),
              Global_active_power = col_double(),
              Global_reactive_power = col_double(),
              Voltage = col_double(),
              Global_intensity = col_double(),
              Sub_metering_1 = col_double(),
              Sub_metering_2 = col_double(),
              Sub_metering_3 = col_double()
)

## Only need two days so just read in the first 70000 rows
## missing values are indicated by '?'
household_power_consumption <- read_delim("household_power_consumption.txt", ";", 
                                          escape_double = FALSE, trim_ws = TRUE, na="?", col_types=cols, n_max = 70000)

two_days <- subset(household_power_consumption, Date=="2/2/2007" | Date=="1/2/2007")

## Add a column that combines the date and time
library(lubridate)
two_days$date_time = dmy_hms(paste(two_days$Date, two_days$Time ))

## Create the plot in a png file
png(filename="plot3.png", width=480, height=480, units="px")
    plot(two_days$date_time, two_days$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    points(two_days$date_time, two_days$Sub_metering_2, type="l", col="red")
    points(two_days$date_time, two_days$Sub_metering_3, type="l", col="blue")
    legend("topright" , legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)
dev.off()
