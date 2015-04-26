if(!file.exists("Source_Classification_Code.rds")){
  url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url,"data")
  unzip("data")
  file.remove("data")
}

require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Baltimore = subset(NEI,NEI$fips == "24510")

vehicle = grepl("vehicle",SCC$SCC.Level.Two,ignore.case=TRUE)

SCC=SCC[vehicle,]

condition=SCC$SCC

VehicleData = subset(Baltimore,SCC %in% condition)

png("plot5.png",width=480,height=480)

plot5 = ggplot(VehicleData,aes(factor(year),Emissions/10^2))+ geom_bar(stat="identity")+
  labs(x="Year", y=expression("Total PM 2.5 Emission (Tons 10^2)")) + 
  labs(title = expression("PM 2.5 Emissions from Motor vehicles in Baltimore"))+theme_bw()

print(plot5)

dev.off()