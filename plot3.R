# Plot3.R
# Question Addressed: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.
# Output is plot3.png

library(ggplot2)

# code below is from project prompt and modified
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset data for only Baltimore City, Maryland
NEI_Baltimore <- subset(NEI, fips == "24510")

# Get the total emissions from each year
data<-aggregate(NEI_Baltimore$Emissions, by=list(year=NEI_Baltimore$year,type=NEI_Baltimore$type), FUN=sum)

#plot
g<-ggplot(data,aes(year,x))
g+geom_point()+facet_wrap(~type, nrow = 2, ncol = 2)+ geom_smooth(method="lm", se=FALSE)+labs(x="Year")+labs(y="Total PM2.5 Emission")+ggtitle("Baltimore City, MD")+theme(plot.title = element_text(hjust = 0.5))

# Verified plot looks correct in viewer and copy to png file
dev.copy(png,'plot3.png')
dev.off()