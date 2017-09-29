#### Exploratory Data Analysis : Week 1 : Project 1 : Plot 1

## Specify the column formats to read in the first two columns as date and time.
cols <- cols( Date = col_date(format = "%d/%m/%Y"),
              Time = col_time(format = ""),
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
    
two_days <- subset(household_power_consumption, Date=="2007-02-01" | Date=="2007-02-02")

## Create the plot in a png file
png(filename="plot1.png", width=480, height=480, units="px")
    hist(two_days$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
    