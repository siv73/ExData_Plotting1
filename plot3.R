library(lubridate)
filename <- "household_power_consumption.txt"
if(!file.exists(filename)){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "household.zip")
        unzip("household.zip")
}

household.powerdata <- read.table("household_power_consumption.txt", header = TRUE,
                                  sep = ";", stringsAsFactors = FALSE) 


household.powerdata$Date <- as.Date(household.powerdata$Date, "%d/%m/%Y")

household.powerdata <- subset(household.powerdata, 
                              Date == "2007-02-01" | Date == "2007-02-02")
household.powerdata$Global_active_power <- as.numeric(household.powerdata$Global_active_power)
date.time <- with(household.powerdata , ymd(household.powerdata$Date) + hms(household.powerdata$Time))
png(filename = "plot3.png", height = 480, width = 480)
plot(date.time, household.powerdata$Sub_metering_1, type = "n", xlab = "", ylab = "Engery Sub Metering")
points(date.time, household.powerdata$Sub_metering_1, type = "l")
points(date.time, household.powerdata$Sub_metering_2, type = "l", col = "green")
points(date.time, household.powerdata$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "green", "blue"), lty =c(1,1,1) , legend = c("Submetering1", 
                                                                                 "Submetering2",
                                                                                 "Submetering3"))
dev.off()