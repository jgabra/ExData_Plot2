# Plot5.R
# Question Addressed: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# Output is plot5.png

library(ggplot2)

# code below is from project prompt and modified
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Merge NEI and SCC data to later subset of Baltimore City and Motor Vehicle Sources
merged_Data<-merge(NEI,SCC,by.x="SCC",by.y="SCC")
Baltimore <- subset(merged_Data, fips == "24510")

# Get specific factors for Sector
Emission_Source<-as.vector(unique(SCC$EI.Sector))

#Subset Coal Data
MotorVehicle<- subset(Baltimore,EI.Sector==Emission_Source[21]|EI.Sector==Emission_Source[22]|EI.Sector==Emission_Source[23]|EI.Sector==Emission_Source[24])

# Get the total emissions from each year
data<-aggregate(MotorVehicle$Emissions, by=list(year=MotorVehicle$year), FUN=sum)

#plot
g<-ggplot(data,aes(year,x))
g+geom_point()+ geom_smooth(method="lm", se=FALSE)+labs(x="Year")+labs(y="Total PM2.5 Emission")+ggtitle("Motor Vehicle Sources in Baltimore City")+theme(plot.title = element_text(hjust = 0.5))

# Verified plot looks correct in viewer and copy to png file
dev.copy(png,'plot5.png')
dev.off()