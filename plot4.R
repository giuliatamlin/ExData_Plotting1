#this file assumes that the dataset is in the same folder
#the dataset is downloaded from 
#https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+
#power+consumption

file = "household_power_consumption.txt"

# n1 is the number of rows to skip when reading in the data. It is calculated
# by counting how many rows start with a date which contains 2006 or January 
# 2007. As this is
# a rather expensive task, it should only be computed in the first run. 
#The further addition of 1 is needed to start reading the file 
#from the first day of Feb 2007 as opposed to the last of Jan 2007
#n2 is the numbers of rows to read in. It is calculated by counting how many rows
# start with a date which is either Jan or Feb 2007.

if (!exists("n1")){
  n1 = length(grep("^(([0-9]+/[0-9]+/2006)|[0-9]+/1/2007)",readLines(file)))+1  
}
if (!exists("n2")){
  n2 = length(grep("^((1|2)/2/2007)",readLines(file)));  
}
#n1 = 66637
#n2 = 2880

col_names = c("Date","Time","GlobalActivePower_kWatt",
              "GlobalReactivePower_kWatt","Voltage_Volt",
              "GlobalIntensity_Ampere","SubMetering1","SubMetering2",
              "SubMetering3")
data = read.table(file,skip = n1, nrows = n2, sep = ";", col.names = col_names)
#plot4.1
GAP = as.numeric(data$GlobalActivePower_kWatt)
#plot4.4
GRP = as.numeric(data$GlobalReactivePower_kWatt)
#plot4.2
V = as.numeric(data$Voltage_Volt)
#plot4.3
s1 = as.numeric(data$SubMetering1)
s2 = as.numeric(data$SubMetering2)
s3 = as.numeric(data$SubMetering3)

datetime = strptime(as.character(paste(data$Date,data$Time)),"%d/%m/%Y %H:%M:%S")
# The following  line is necessary in case the days of the week
# are not displayed in English by default
Sys.setlocale("LC_TIME", "en_US.UTF-8")

png("plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))
plot(datetime,GAP, type = "l", xlab = "",ylab = "Global Active Power")
plot(datetime,V, type = "l", xlab = "datetime",ylab = "Voltage")
plot(datetime,s1,type="l",col="black", xlab = "",ylab = "Energy sub metering")
lines(datetime,s2,col = "red")
lines(datetime,s3,col = "blue")
leg = c("sub metering 1", "sub metering 2", "submetering 3")
col = c("black","red","blue")
legend("topright",legend = leg, col = col, lty = c(1,1,1), bty= "n")
plot(datetime,GRP, type = "l", xlab = "datetime",ylab = "Global_Reactive_Power")
dev.off()