library(data.table)
library(dplyr)

#read all the data into a data table
housedata <- data.table(read.table("household_power_consumption.txt",sep = ";", header = TRUE,
                                   colClasses ="character",na.strings = "?"))

#subsetting for the chosen dates
housedata <- housedata[Date %in% c("1/2/2007","2/2/2007")]

#reconstructing the datatable with the corresponding types
housedata<-
    as.POSIXct(paste(housedata$Date,housedata$Time),format="%d/%m/%Y %H:%M:%S") %>%
    data.table(DateTime=.,sapply(housedata[,3:9],function (x) as.numeric(x)))

#open the device and make the plot
#x axis tick marks are in Portuguese because of system language
png("plot3.png", width = 480, height = 480)   

plot(housedata$DateTime,housedata$Sub_metering_1,xlab="",ylab="Energy sub metering",
     type="n")
lines(housedata$DateTime,housedata$Sub_metering_1,type = "l")
lines(housedata$DateTime,housedata$Sub_metering_2,type = "l",col="red")
lines(housedata$DateTime,housedata$Sub_metering_3,type = "l",col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1, col=c("black","red","blue"),y.intersp = 1)

dev.off()