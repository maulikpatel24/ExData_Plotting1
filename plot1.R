setwd("C:\\") # SETTING THE WORKING DIRECTORY in C:/ 
if(!file.exists("./power")){dir.create("./power")} # CREATING A FOLDER "POWER" IN C:/
setwd("C:\\power") # SETTING THE WORKING DIRECTORY TO SAVE DATA AND ALL PLOT FILES HERE.

# DOWNLOADING THE DATA FILE
if(!file.exists("household_power_consumption.txt"))
        {
        download.file(url = "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip", destfile = "power.zip")
        unzip("./power.zip")
        }

# READINGTHE DATA FILE
power = read.table("household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep = ";")
head(power)

power$Date = as.Date(power$Date, "%d/%m/%Y")
class(power$Date)

power2 = power[power$Date >= "2007-02-01" & power$Date <= "2007-02-02",]
head(power2)

library(chron)
power2$Time = chron(time = power2$Time)
class(power2$Time)

power2$Global_active_power = as.numeric(power2$Global_active_power)
power2$Global_reactive_power = as.numeric(power2$Global_reactive_power)
power2$Voltage = as.numeric(power2$Voltage)
power2$Global_intensity = as.numeric(power2$Global_intensity)
power2$Sub_metering_1 = as.numeric(power2$Sub_metering_1)
power2$Sub_metering_2 = as.numeric(power2$Sub_metering_2)

str(power2)

power2$DateTime = as.POSIXct(paste(power2$Date, power2$Time))

# PLOT-1

# plot on R-Studio screen
hist(power2$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# plot as plot1.png file at "C:\power"
png(filename="plot1.png", width=480, height=480, units="px")
hist(power2$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()