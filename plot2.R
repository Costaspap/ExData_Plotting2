if(!file.exists("Source_Classification_Code.rds")){
  url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url,"data")
  unzip("data")
  file.remove("data")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

maryland=subset(NEI,NEI$fips == "24510")
totalEmissions=aggregate(Emissions ~ year,maryland,sum)

png("plot2.png",width=480,height=480)

barplot(totalEmissions$Emissions,totalEmissions$year,
        names.arg=totalEmissions$year,xlab="Year",ylab="PM 2.5 Total Emissions in Baltimore City, Maryland")

dev.off()