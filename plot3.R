##################################
#####
##### plot3.png
#####
##################################

# Creating the directory to store the Dataset
if(!file.exists("./data")){dir.create("./data")}

# Downloading the course project data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/Electronic power consumption.zip", method="curl")

# Unzipping the downloaded Dataset
unzip(zipfile="./data/Electronic power consumption.zip", exdir="./data")

# Reading "household_power_consumption.txt" data set
HPC <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

# Subsetting '01/02/2007' and '02/02/2007' observations and Taking a look into HCP data set
HPC <- subset(HPC, Date %in% c("1/2/2007", "2/2/2007"))
summary(HPC)

# Adjusting the class of variables that are going to be used in the plot
class(HPC$Global_active_power)
HPC$Global_active_power <- as.numeric(HPC$Global_active_power)
class(HPC$Global_active_power)

class(HPC$Sub_metering_1)
HPC$Sub_metering_1 <- as.numeric(HPC$Sub_metering_1)
class(HPC$Sub_metering_1)

class(HPC$Sub_metering_2)
HPC$Sub_metering_2 <- as.numeric(HPC$Sub_metering_2)
class(HPC$Sub_metering_2)

class(HPC$Sub_metering_3)
HPC$Sub_metering_3 <- as.numeric(HPC$Sub_metering_3)
class(HPC$Sub_metering_3)

class(HPC$Date)
class(HPC$Time)
HPC$datetime <- strptime(paste(HPC$Date, HPC$Time), "%d/%m/%Y %H:%M:%S")
class(HPC$datetime)

# Making the plot
png("plot3.png", width=480, height=480)
with(HPC, plot(datetime, Sub_metering_1, type="l", col=par("col"), xlab="", ylab="Energy sub metering"))
with(HPC, lines(datetime, Sub_metering_2, col="red"))
with(HPC, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", lty=1, lwd=1, col=c(par("col"), "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()