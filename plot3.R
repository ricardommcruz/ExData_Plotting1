# 0. Load the data.table library for faster read/manipulation
library(data.table)

# 1. Read data using the fast read function (data.table package)
data <- fread('household_power_consumption.txt', na.strings = "?")

# 2. Do the necessary column type conversions using the set function provided by the data.table package
# 2.1 Create a new column with the date and time as a single object (x axis)
data[,DateTime:=as.POSIXct(paste(data[,Date], data[,Time]), format='%d/%m/%Y %H:%M:%S')]
# 2.2 Convert the columns (series) that we will plot against time (y axis)
data[,Sub_metering_1 := as.numeric(data[,Sub_metering_1])]
data[,Sub_metering_2 := as.numeric(data[,Sub_metering_2])]
data[,Sub_metering_3 := as.numeric(data[,Sub_metering_3])]

# 3. Subset only the rows we are interested in and drop the rest
data <- data[data$DateTime>='2007-02-01 00:00:00' & data$DateTime<='2007-02-02 23:59:59']

# 4. Open the png graphics device (no need to render the plot in the display first...)
png(filename = "plot3.png", width = 480, height = 480, bg = 'transparent')

# 5. Plot a line for the first series while setting some parameters
plot(data[,DateTime], data[,Sub_metering_1], type = 'l', xlab = "", ylab = "Energy sub metering")

# 5.1 Add a line for each of the remaining series
lines(x = data[,DateTime], y = data[,Sub_metering_2], col='Red')
lines(x = data[,DateTime], y = data[,Sub_metering_3], col='Blue')

# 5.2 Add a legend
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black","red","blue"),
       lty = 1)

# 6. Close the graphics device
dev.off()