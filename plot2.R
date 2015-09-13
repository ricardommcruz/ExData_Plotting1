# 0. Load the data.table library for faster read/manipulation
library(data.table)

# 1. Read data using the fast read function (data.table package)
data <- fread('household_power_consumption.txt', na.strings = "?")

# 2. Do the necessary column type conversions using the set function provided by the data.table package
# 2.1 Create a new column with the date and time as a single object (x axis)
data[,DateTime:=as.POSIXct(paste(data[,Date], data[,Time]), format='%d/%m/%Y %H:%M:%S')]
# 2.2 Convert the column that we will plot against time (y axis)
data[,Global_active_power := as.numeric(data[,Global_active_power])]

# 3. Subset only the rows we are interested in and drop the rest
data <- data[data$DateTime>='2007-02-01 00:00:00' & data$DateTime<='2007-02-02 23:59:59']

# 4. Open the png graphics device (no need to render the plot in the display first...)
png(filename = "plot2.png", width = 480, height = 480, bg = 'transparent')

# 5. Plot a line for the Global_active_power variable while setting some parameters
plot(data$DateTime, data$Global_active_power, type = 'l', xlab = "", ylab = "Global Active Power (kilowatts)")

# 6. Close the graphics device
dev.off()