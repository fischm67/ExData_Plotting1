## Exploratory data Project1
## plot1 function requires the "data.table" package

plot4 <- function () {
    
    require(data.table)
    
    ## create temporary file with subset data to reduce data size
    system("grep '^[12]/2/2007' household_power_consumption.txt >> subset_dat.txt")
    
    ## use fread to read in smaller text file
    proj1_dat <- fread("subset_dat.txt")
    file.remove("subset_dat.txt")
    newcolnames <- c("Date", "Time", "Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
    cur_cols <- colnames(proj1_dat)
    setnames(proj1_dat,cur_cols,newcolnames)
    proj1_dat$Date <- as.Date(as.character(proj1_dat$Date), format = "%d/%m/%Y")
    proj1_dat$DateTime <- as.POSIXct(paste(proj1_dat$Date, proj1_dat$Time), format = "%Y-%m-%d %H:%M:%S")
    
    ## create plot4.png
    
    png(file = "plot4.png", width = 480, height = 480)
    par(mfcol = c(2,2))
    par(mar = c(4,4,2,2))
    with(proj1_dat, plot(DateTime, Global_active_power, ylab = "Global Active Power", xlab = "", type = "n"))
    with(proj1_dat, lines(DateTime, Global_active_power))
    with(proj1_dat, plot(DateTime, Sub_metering_1, ylab = "Energy sub metering", xlab= "", type = "n"))
    with(proj1_dat, lines(DateTime, Sub_metering_1))
    with(proj1_dat, lines(DateTime, Sub_metering_2, col = "red"))
    with(proj1_dat, lines(DateTime, Sub_metering_3, col = "blue"))
    legend("topright", pch = "-", lty=1, lwd=1.5, bty = "n", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    with(proj1_dat, plot(DateTime, Voltage, ylab = "Voltage", xlab = "datetime", type = "n"))
    with(proj1_dat, lines(DateTime, Voltage))
    with(proj1_dat, plot(DateTime, Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "n"))
    with(proj1_dat, lines(DateTime, Global_reactive_power))
    dev.off()
    
}