## Introduction

This assignment uses data from
the <a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine
Learning Repository</a>, a popular repository for machine learning
datasets. In particular, we will be using the "Individual household
electric power consumption Data Set" available on the course web site:


* <b>Dataset</b>: <a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip">Electric power consumption</a> [20Mb]

* <b>Description</b>: Measurements of electric power consumption in
one household with a one-minute sampling rate over a period of almost
4 years. Different electrical quantities and some sub-metering values
are available.


The following descriptions of the 9 variables in the dataset are taken
from
the <a href="https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption">UCI
web site</a>:

<ol>
<li><b>Date</b>: Date in format dd/mm/yyyy </li>
<li><b>Time</b>: time in format hh:mm:ss </li>
<li><b>Global_active_power</b>: household global minute-averaged active power (in kilowatt) </li>
<li><b>Global_reactive_power</b>: household global minute-averaged reactive power (in kilowatt) </li>
<li><b>Voltage</b>: minute-averaged voltage (in volt) </li>
<li><b>Global_intensity</b>: household global minute-averaged current intensity (in ampere) </li>
<li><b>Sub_metering_1</b>: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered). </li>
<li><b>Sub_metering_2</b>: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light. </li>
<li><b>Sub_metering_3</b>: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.</li>
</ol>

## Loading the data





When loading the dataset into R, please consider the following:

* The dataset has 2,075,259 rows and 9 columns. First
calculate a rough estimate of how much memory the dataset will require
in memory before reading into R. 

2075259 rows x 9 columns x 8 bytes/double = 150MB

* Note that in this dataset missing values are coded as `?`.

For the first plot I parse the first two columns as date & time.
For the other plots it was easier to parse them as character and 
then combine them into a single data_time column.

cols <- cols(
+     Date = col_date(format = "%d/%m/%Y"),
+     Time = col_time(format = ""),
+     Global_active_power = col_double(),
+     Global_reactive_power = col_double(),
+     Voltage = col_double(),
+     Global_intensity = col_double(),
+     Sub_metering_1 = col_double(),
+     Sub_metering_2 = col_double(),
+     Sub_metering_3 = col_double()
+     )

household_power_consumption <- read_delim("household_power_consumption.txt", 
+     ";", escape_double = FALSE, trim_ws = TRUE, na="?", col_types=cols)

* We will only be using data from the dates 2007-02-01 and
2007-02-02. One alternative is to read the data from just those dates
rather than reading in the entire dataset and subsetting to those
dates.

two_days <- subset(household_power_consumption, Date=="2007-02-01" | Date=="2007-02-02")

* I convert the Date and Time variables to
Date/Time classes in R using lubridate's dmy_hms function:

library(lubridate)
two_days$date_time = dmy_hms(paste(two_days$Date, two_days$Time ))


## Making Plots

Our overall goal here is simply to examine how household energy usage
varies over a 2-day period in February, 2007. My task is to
reconstruct the following plots below, all of which were constructed
using the base plotting system.


For each plot I:

* Construct the plot and save it to a PNG file with a width of 480
pixels and a height of 480 pixels.

* Name each of the plot files as `plot1.png`, `plot2.png`, etc.

* Create a separate R code file (`plot1.R`, `plot2.R`, etc.) that
constructs the corresponding plot, i.e. code in `plot1.R` constructs
the `plot1.png` plot. My code file includes code for reading
the data so that the plot can be fully reproduced. It also
includes the code that creates the PNG file.

* Add the PNG file and R code file to my git repository

Push my git repository to GitHub so that the GitHub version 
of my repository is up to date. There should be four PNG 
files and four R code files.


The four plots  to construct are shown below. 


### Plot 1


Target Plot:
![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 
My Code:
'''R
> png(filename="plot1.png", width=480, height=480, units="px")
> hist(two_days$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
> dev.off()
'''
![plot of plot 1](plot1.png) 

My Plot:

### Plot 2

png(filename="plot2.png", width=480, height=480, units="px")
    plot(two_days$date_time, two_days$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


### Plot 3

png(filename="plot3.png", width=480, height=480, units="px")
    plot(two_days$date_time, two_days$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    points(two_days$date_time, two_days$Sub_metering_2, type="l", col="red")
    points(two_days$date_time, two_days$Sub_metering_3, type="l", col="blue")
    legend("topright" , legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)
dev.off()

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


### Plot 4

png(filename="plot4.png", width=480, height=480, units="px")
    par(mfrow=c(2,2))
    
    plot(two_days$date_time, two_days$Global_active_power, type="l", xlab="", ylab="Global Active Power")
    plot(two_days$date_time, two_days$Voltage, type="l", xlab="datetime", ylab="Voltage")
    
    plot(two_days$date_time, two_days$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    points(two_days$date_time, two_days$Sub_metering_2, type="l", col="red")
    points(two_days$date_time, two_days$Sub_metering_3, type="l", col="blue")
    legend("topright" , legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)

    with( two_days, plot(date_time, Global_reactive_power, type="l", xlab="datetime"))
dev.off()

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 

