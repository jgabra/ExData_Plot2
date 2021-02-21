# Plot1.R
# Question Addressed: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
# Output is plot1.png

# code below is from project prompt and modified
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get the total emissions from each year
data<-aggregate(NEI$Emissions, by=list(year=NEI$year), FUN=sum)

#plot
plot(data$year,data$x,xlab="Year",ylab="Total PM2.5 Emission All Sources",type="b",lwd=2,main="United States",frame=FALSE)

# Add regression line to show overall trend
abline(lm(x ~ year, data = data), col = "blue")

# Verified plot looks correct in viewer and copy to png file
dev.copy(png,'plot1.png')
dev.off()