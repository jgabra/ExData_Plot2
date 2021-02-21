# Plot2.R
# Question Addressed: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
# Output is plot2.png


# code below is from project prompt and modified
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset data for only Baltimore City, Maryland
NEI_Baltimore <- subset(NEI, fips == "24510")

# Get the total emissions from each year
data<-aggregate(NEI_Baltimore$Emissions, by=list(year=NEI_Baltimore$year), FUN=sum)

#plot
plot(data$year,data$x, xlab="Year",ylab="Total PM2.5 Emission",type="b",main="Emissions for Baltimore City, Maryland",lwd=2,frame=FALSE)

# Add regression line to show overall trend
abline(lm(x ~ year, data = data), col = "blue")

# Verified plot looks correct in viewer and copy to png file
dev.copy(png,'plot3.png')
dev.off()