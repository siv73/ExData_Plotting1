##please install lubridate before running this code
library(lubridate)
## if the file doesn't exist then it will download and then unzip the file
filename <- "household_power_consumption.txt"
## if the file doesn't exist then it will download and then unzip the file
if(!file.exists(filename)){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "household.zip")
        unzip("household.zip")
}

##reading the data, can be read for specific columns using skip and nrows
##but i chose let the computer take that burden off of me
household.powerdata <- read.table("household_power_consumption.txt", header = TRUE,
                                  sep = ";", stringsAsFactors = FALSE, na.strings = "?") 

##converting the date column from character to date.
household.powerdata$Date <- as.Date(household.powerdata$Date, "%d/%m/%Y")
##filtering the required data
household.powerdata <- subset(household.powerdata, 
                              Date == "2007-02-01" | Date == "2007-02-02")
##since everything is read as character, converting the required variable for 
## for plotting as numeric
household.powerdata$Global_active_power <- as.numeric(household.powerdata$Global_active_power)
##combining date and time into a single variable using lubridate
date.time <- with(household.powerdata , ymd(household.powerdata$Date) + hms(household.powerdata$Time))
##opening png graphic device
png(filename = "plot3.png", height = 480, width = 480)
##plotting, points will let us plot as required
plot(date.time, household.powerdata$Sub_metering_1, type = "n", xlab = "", ylab = "Engery Sub Metering")
points(date.time, household.powerdata$Sub_metering_1, type = "l")
points(date.time, household.powerdata$Sub_metering_2, type = "l", col = "green")
points(date.time, household.powerdata$Sub_metering_3, type = "l", col = "blue")
##setting the legend
legend("topright", col = c("black", "green", "blue"), lty =c(1,1,1) , legend = c("Submetering1", 
                                                                                 "Submetering2",
                                                                                 "Submetering3"))
##closing the graphic device.
dev.off()
