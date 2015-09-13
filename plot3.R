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

png("plot3.png", width = 480, height = 480)

# Creating the third plot.
# X-axis is time, Y-axis is energy sub metering, and line color is sub_metering_1, etc.
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

dev.off()