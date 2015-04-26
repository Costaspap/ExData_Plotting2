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
LosAngeles = subset(NEI,NEI$fips == "06037")

vehicle = grepl("vehicle",SCC$SCC.Level.Two,ignore.case=TRUE)

SCC=SCC[vehicle,]

condition=SCC$SCC

VehicleDataBalt = subset(Baltimore,SCC %in% condition)
VehicleDataLA = subset(LosAngeles,SCC %in% condition)

VehicleDataBalt$City="Baltimore City"
VehicleDataLA$City="Los Angeles"

Data = rbind(VehicleDataBalt,VehicleDataLA)

png("plot6.png",width=480,height=480)

plot6 = ggplot(Data,aes(factor(year),Emissions/1000,fill=City))+geom_bar(stat="identity")+ 
  labs(x="Year", y=expression("Total PM 2.5 Emission (Tons*1000)")) + 
  labs(title=expression("PM 2.5 Emissions, Baltimore City and Los Angeles 1999-2008 by City"))+guides(fill=FALSE)+
  facet_grid(.~City,scales = "free",space="free")+theme_bw()

print(plot6)

dev.off()