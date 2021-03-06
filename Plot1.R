##access the data
temp <- tempfile()
download.file(“https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip”, method = “curl”,  temp)  ## download the zipped data
data <- read.table(unz(temp, “household_power_consumption.txt”), header=T, sep=“;” ) ##unzip and read in the data
unlink(temp)


## reformat date and time variables, and subset only the relevant dates for exploratory analysis
data$Date<-as.Date(as.character(data$Date), format="%d/%m/%Y") ## change to Date format
dat<- subset(data, Date==“2007-2-1” | Date==“2007-2-2”) ##subset only the relevant dates
Time1<- as.character(dat$Time) ## change factor to character
dat$datetime <- paste(dat$Date, Time1) ## paste date and time into same field
dat$datetime<- strptime(dat$datetime, format = "%Y-%m-%d %H:%M:%S") ## reformat date and time

## change these variables from factor to numeric
dat$Global_active_power <- as.numeric(as.character(dat$Global_active_power)) numeric
dat$Global_reactive_power <- as.numeric(as.character(dat$Global_reactive_power)) 
dat$Voltage <- as.numeric(as.character(dat$Voltage))
dat$Sub_metering_1 <- as.numeric(as.character(dat$Sub_metering_1))
dat$Sub_metering_2 <- as.numeric(as.character(dat$Sub_metering_2))
dat$Sub_metering_3 <- as.numeric(as.character(dat$Sub_metering_3))


## Plot1
png(filename = "plotA.png", height = 480, width= 480, bg = "white")
hist(dat$Global_active_power, col = "red", main= "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
