if(!file.exists("Source_Classification_Code.rds")){
  url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url,"data")
  unzip("data")
  file.remove("data")
}

require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

maryland=subset(NEI,NEI$fips == "24510")

png("plot3.png",width=620,height=620)

plot3 = ggplot(maryland,aes(factor(year),Emissions,fill=type))+geom_bar(stat="identity")+ 
  labs(x="Year", y=expression("Total PM 2.5 Emission (Tons)")) + 
  labs(title=expression("PM 2.5 Emissions, Baltimore City 1999-2008 by Source"))+guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free")+theme_bw()

print(plot3)

dev.off()