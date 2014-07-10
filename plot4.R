
# setwd("~/Desktop/Exploratory Data Analysis/03-Course Projects/Course Project 1")

### Load data from the file

# We will only be using data from the dates 2007-02-01 and 2007-02-02 (line 66638 to line 69517 = 2880 lines). 
# So read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
# Note that in this dataset, fields are separated by ";" and missing values are coded as ?.

# Set column classes

# classes <- sapply(head(data), class)
col_Classes = c(rep("character",2),rep("numeric",7))

# Read data for the dates 2007-02-01 and 2007-02-02, line 66638 - line 69517 = 2880 lines
data <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", row.names = NULL, 
                   na.strings = "?", colClasses = col_Classes, nrows = 2880,
                   skip = 66637,strip.white = TRUE,stringsAsFactors = FALSE)

# Read and set header
header <- scan(file = "household_power_consumption.txt", what = "character", sep = ";", , nlines = 1, na.strings = "?", quiet = TRUE)
colnames(data) = header

# head(data)
# tail(data)
# dim(data)
# sum(complete.cases(data))
# class(data)


### Convert the Date and Time variables to Date/Time classes using the strptime() and as.Date() functions.

# class(head(data[, 1])) # "character"
# class(head(data[, 2])) # "character"

# Change Time before change Date
data$Time <- strptime(paste(data$Date, data$Time),format = "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")

# class(head(data[, 1])) # "Date"
# class(head(data[, 2])) # "POSIXlt" "POSIXt"


# Plot into a PNG file

png(filename = "plot4.png", width = 480, height = 480)

# ?par
par(oma = c(2,2,0,0))
par(mfcol = c(2, 2))

# plot 2
plot(data$Time, data$Global_active_power, ylab= "Global Active Power (kilowatts)", 
     type = "l", lwd = 1, xlab = "")

# plot 3
plot(data$Time, data$Sub_metering_1, xlab = "", ylab= "Energy sub metering", type = "n")
lines(data$Time, data$Sub_metering_1)
lines(data$Time, data$Sub_metering_2, col = "red")
lines(data$Time, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"))

# plot 4-1
plot(data$Time, data$Voltage, xlab = "datetime", ylab= "Voltage", type = "l", lwd = 1)

# plot 4-2

plot(data$Time, data$Global_reactive_power, xlab = "datetime", ylab= "Global_reactive_power", type = "l", lwd = 1)

dev.off()


