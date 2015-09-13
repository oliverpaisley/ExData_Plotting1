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

png("plot4.png", width = 480, height = 480)

# Setup the window to display 4 plots in a 2x2 grid.
par(mfrow = c(2, 2))

# Create the first plot in the grid (top left).
plot(df$DateTime, 
     df$Global_active_power, 
     type = "l", 
     ylab = "Global Active Power", 
     xlab = "")

# Create the second plot in the grid (top right).
plot(df$DateTime, 
     df$Voltage, 
     type = "l", 
     ylab = "Voltage", 
     xlab = "datetime")

# Create the third plot in the grid (bottom left).
plot(df$DateTime, 
     df$Sub_metering_1, 
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")
points(df$DateTime, 
       df$Sub_metering_2, 
       type = "l", 
       col = "red")
points(df$DateTime, 
       df$Sub_metering_3, 
       type = "l", 
       col = "blue")
legend("topright",
       lty = 1,
       col = c("black", 
               "red", 
               "blue"),
       legend = c("sub_metering_1", 
                  "sub_metering_2", 
                  "sub_metering_3"))

# Create the fourth plot in the grid (bottom right).
plot(df$DateTime, 
     df$Global_reactive_power, 
     type = "l", 
     ylab = "Global_reactive_power", 
     xlab = "datetime")

# Reset the viewing window back to the default.
par(mfrow = c(1, 1))

dev.off()