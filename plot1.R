# 0. Load the data.table library for faster read/manipulation
library(data.table)

# 1. Read data using the fast read function (data.table package)
data <- fread('household_power_consumption.txt', na.strings = "?")

# 2. Do the necessary column type conversions using the set function provided by the data.table package
# 2.1 Convert the date column for easy subsetting of rows (later)
data[,Date := as.Date(data[,Date],'%d/%m/%Y')]
# 2.2 Convert the column for which we will be creating the histogram
data[,Global_active_power := as.numeric(data[,Global_active_power])]

# 3. Subset only the rows we are interested in and drop the rest
data <- data[data$Date>='2007-02-01' & data$Date<='2007-02-02']

# 4. Open the png graphics device (no need to render the plot in the display first...)
png(filename = "plot1.png", width = 480, height = 480, bg = 'transparent')

# 5. Plot an histogram for the Global_active_power variable while setting some parameters
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = 'Red')

# 6. Close the graphics device
dev.off()