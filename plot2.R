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

# Using lubridate to fix the Date variable and create a new variable called DateTime.
df$Date <- dmy(df$Date)
df$DateTime <- as.POSIXct(paste(as.Date(df$Date),
                                df$Time), 
                          format = "%Y-%m-%d %H:%M:%S")

png("plot2.png", width = 480, height = 480)

# Creating the second plot.
plot(df$DateTime, 
     df$Global_active_power, 
     type = "l", 
     ylab = "Global Active Power (kilowatts)", 
     xlab = "")

dev.off()

