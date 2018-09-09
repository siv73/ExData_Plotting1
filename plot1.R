## Text file containing the data for plot
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
                                  sep = ";", stringsAsFactors = FALSE) 

##converting the date column from character to date.
household.powerdata$Date <- as.Date(household.powerdata$Date, "%d/%m/%Y")
##filtering the required data
household.powerdata <- subset(household.powerdata, 
                              Date == "2007-02-01" | Date == "2007-02-02")
##since everything is read as character, converting the required variable for 
## for plotting as numeric
household.powerdata$Global_active_power <- as.numeric(household.powerdata$Global_active_power)
##opening png graphic device
png(filename = "plot1.png", height = 480, width = 480)
hist(household.powerdata$Global_active_power, col = "Red", xlab = "Global Active Power (kilowatts)"
     , main = "Global Active Power")
##closing the graphic device
dev.off()
