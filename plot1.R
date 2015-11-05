library(readr)
library(lubridate)
#this file assumes that the dataset is in the same folder
#the dataset is downloaded from 
#https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+
#power+consumption

file = "household_power_consumption.txt"

# n1 is the number of rows to skip when reading in the data. It is calculated
# by counting how many rows start with a date which contains 2006 or January 
# 2007. As this is
# a rather expensive task, after the first run in which it is effectively
#calculated, n1 should be hard-coded. 
#The further addition of 1 is needed to start reading the file 
#from the first day of Feb 2007 as opposed to the last of Jan 2007

#n1 = length(grep("^(([0-9]+/[0-9]+/2006)|[0-9]+/1/2007)",readLines(file)))+1 

n1 = 66637

#n2 is the numbers of rows to read in. It is calculated by counting how many rows
# start with a date which is either Jan or Feb 2007. After the first run, it is 
#hard-coded

#n2 = length(grep("^((1|2)/2/2007)",readLines(file)));
n2 = 2880


col_names = c("Date","Time","GlobalActivePower_kWatt",
              "GlobalReactivePower_kWatt","Voltage_Volt",
              "GlobalIntensity_Ampere","SubMetering1","SubMetering2",
              "SubMetering3")
data = read.table(file,skip = n1, nrows = n2, sep = ";", col.names = col_names)
#plot 1
GAP = as.numeric(data$GlobalActivePower_kWatt)
png("plot1.png",width = 480, height = 480)
hist(GAP, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()