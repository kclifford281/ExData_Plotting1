# Read raw data file, subset to include Dates = 2007-02-01, 
# 2007-02-02, add POSIXDate Var combining Date + Time and 
# changing date format to POSIXlt

df <- read.csv("./household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)
df <- subset(df, df$Date %in% c("1/2/2007","2/2/2007"))
POSIXDate <- strptime(paste(df[,1]," ",df[,2]),"%d/%m/%Y %H:%M:%S", tz = "")
df <- data.frame(df,POSIXDate=POSIXDate)

# Convert variables from character to numeric

for (i in 3:9) {
  
  df[,i] <- as.numeric(df[,i])
  
}


# Create Plot 3

png("plot3.png", width = 480, height = 480)

with(df,plot(POSIXDate, Sub_metering_1, xlab="", ylab = "Energy sub metering", type="l", cex.axis=.7, cex.main=.7, cex.lab=.7))
lines(df$POSIXDate, df$Sub_metering_2, col="red")
lines(df$POSIXDate, df$Sub_metering_3, col="blue")
legend("topright", lty=1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=.7, y.intersp=.7)

dev.off()