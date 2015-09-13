library(lubridate)

# Read in the data.
df <- read.table("household_power_consumption.txt", 
                 sep = ";", 
                 header = TRUE, 
                 stringsAsFactors = FALSE)

# Subset the data to only include the rows we want.
df <- df[df$Date == "1/2/2007" | df$Date == "2/2/2007", ]

# Fixing the Global_active_power variable, to prepare for plotting.
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))

png("plot1.png", width = 480, height = 480)

# Creating the first plot.
hist(df$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

dev.off()