library(sqldf)

setStartDate = strptime("16/12/2006;17:24:00", format = "%d/%m/%Y;%T")
subsetStartDate = strptime("2007-02-01;00:00:00", format = "%Y-%m-%d;%T")
subsetEndDate = strptime("2007-02-03;00:00:00", format = "%Y-%m-%d;%T") # +1 day to get corrent number of minutes

toSkip = difftime(subsetStartDate, setStartDate, units = "mins") + 1 # +1 to skip the header
toRead = difftime(subsetEndDate, subsetStartDate, units = "mins")

df = read.csv("household_power_consumption.txt", header = FALSE, sep = ";", skip = toSkip, nrows = toRead, na.strings = '?')

names(df) = c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')

df = df[,1:3]
df["DateTime"] = NA
df$DateTime = paste(df$Date, df$Time, sep=";")
df = df[,c(4,3)]
df$DateTime = strptime(df$DateTime, format = "%d/%m/%Y;%T")


png(file = "plot2.png", width = 480, height = 480)

plot(df$DateTime, df$Global_active_power, type='l', xlab = '', ylab = 'Global Active Power (killowats)')

dev.off()
