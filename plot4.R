if(!file.exists("Source_Classification_Code.rds")){
  url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url,"data")
  unzip("data")
  file.remove("data")
}

require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

comb = grepl("comb",SCC$SCC.Level.One,ignore.case=TRUE)
coal = grepl("coal",SCC$SCC.Level.Four,ignore.case=TRUE)
coalcomb = (coal & comb)

SCC=SCC[coalcomb,]

condition=SCC$SCC

coalCombEmissionsData = subset(NEI,SCC %in% condition)

png("plot4.png",width=480,height=480)

plot4 = ggplot(coalCombEmissionsData,aes(factor(year),Emissions/10^5))+ geom_bar(stat="identity")+
  labs(x="Year", y=expression("Total PM 2.5 Emission (Tons 10^5)")) + 
  labs(title = expression("PM 2.5 Emissions from coal combustion in the US"))+theme_bw()

print(plot4)

dev.off()