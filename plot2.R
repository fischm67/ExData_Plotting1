## Exploratory data Project1
## plot1 function requires the "data.table" package

plot2 <- function () {
    
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
    
    ## create plot2.png
    
    png(file = "plot2.png", width = 480, height = 480)
    with(proj1_dat, plot(DateTime, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "n"))
    with(proj1_dat, lines(DateTime, Global_active_power))
    dev.off()
    
}