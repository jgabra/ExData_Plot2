# Plot6.R
# Question Addressed: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
# Output is plot6.png

library(ggplot2)

# code below is from project prompt and modified
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Merge NEI and SCC data to later subset of Baltimore City and Motor Vehicle Sources
merged_Data<-merge(NEI,SCC,by.x="SCC",by.y="SCC")
SubData <- subset(merged_Data, fips == "24510" | fips =="06037")

# Get specific factors for Sector
Emission_Source<-as.vector(unique(SCC$EI.Sector))

#Subset Coal Data
MotorVehicle<- subset(SubData,EI.Sector==Emission_Source[21]|EI.Sector==Emission_Source[22]|EI.Sector==Emission_Source[23]|EI.Sector==Emission_Source[24])

# Get the total emissions from each year
data<-aggregate(MotorVehicle$Emissions, by=list(year=MotorVehicle$year,location=MotorVehicle$fips), FUN=sum)
data$location[data$location=="24510"] <- "Baltimore City, MD"
data$location[data$location=="06037"] <- "Los Angeles County, CA"

#plot
g<-ggplot(data,aes(year,x))
g+geom_point()+ facet_wrap(~location)+
geom_smooth(method="lm", se=FALSE)+labs(x="Year")+labs(y="Total PM2.5 Emission")+ggtitle("Motor Vehicle Sources in Baltimore City and LA County")+theme(plot.title = element_text(hjust = 0.5))

# Verified plot looks correct in viewer and copy to png file
dev.copy(png,'plot6.png')
dev.off()