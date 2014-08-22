## Script Name: plot1.R
## Exploratory Data Analysis - Project 2 - first plot

## No Libraries needed

## Pre-Step One: Set working directory
setwd("E:/Sivarajan/Coursera-Exploratory Data Analysis/Project2")

## First Step Pull in the data
NEI <- readRDS("project2-data/summarySCC_PM25.rds")
SCC <- readRDS("project2-data/Source_Classification_Code.rds")

length(NEI$Emissions)
length(NEI$year)
tot.PM25yr <- tapply(NEI$Emissions, NEI$year, sum)

###Second Step: prepare the plot to make png
png("plot1.png")
plot(names(tot.PM25yr), tot.PM25yr, type="l", xlab = "Year", ylab = expression
     ("Total" ~ PM[2.5] ~"Emissions (tons)"), main = expression("Total US" ~ 
     PM[2.5] ~ "Emissions by Year"), col="Green")
dev.off()


###Last Step: create the plot to the markdown file
plot(names(tot.PM25yr), tot.PM25yr, type="l", xlab = "Year", 
ylab = expression ("Total" ~ PM[2.5] ~"Emissions (in tons)"), 
main = expression("Total USA" ~ PM[2.5] ~ "Emissions by Year"), col="Green")