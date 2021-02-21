# Plot4.R
# Question Addressed: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
# Output is plot4.png

library(ggplot2)

# code below is from project prompt and modified
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Merge NEI and SCC data to later subset coal
merged_Data<-merge(NEI,SCC,by.x="SCC",by.y="SCC")

# Get specific factors for Sector
FuelComb_Coal<-as.vector(unique(SCC$EI.Sector))

#Subset Coal Data
Coal<- subset(merged_Data,EI.Sector==FuelComb_Coal[1]|EI.Sector==FuelComb_Coal[6]|EI.Sector==FuelComb_Coal[11])

# Get the total emissions from each year
data<-aggregate(Coal$Emissions, by=list(year=Coal$year), FUN=sum)

#plot
g<-ggplot(data,aes(year,x))
g+geom_point()+ geom_smooth(method="lm", se=FALSE)+labs(x="Year")+labs(y="Total PM2.5 Emission")+ggtitle("Coal Combustion Sources in US")+theme(plot.title = element_text(hjust = 0.5))

# Verified plot looks correct in viewer and copy to png file
dev.copy(png,'plot4.png')
dev.off()