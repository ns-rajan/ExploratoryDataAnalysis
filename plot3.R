## Script Name: plot3.R
## Exploratory Data Analysis - Project 2 - Third plot

## Two Libraries needed:
library(ggplot2)
library(plyr)

## First Step : pull in the data
NEI <- readRDS("project2-data/summarySCC_PM25.rds")
SCC <- readRDS("project2-data/Source_Classification_Code.rds")

## Second Step : subset our data
baltimore <- subset (NEI, fips == "24510")
typePM25.year <- ddply(baltimore, .(year, type), function(x) sum(x$Emissions))

## Renaming the col: Emissions
colnames(typePM25.year)[3] <- "Emissions"

## Third Step : prepare to plot to png
png("plot3.png") 
qplot(year, Emissions, data=typePM25.year, color=type, geom ="line") + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emission by source, type and year")) +  xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)"))
dev.off()

## pdf 


## Last Step : prepare to plot to markdown
qplot(year, Emissions, data=typePM25.year, color=type, geom ="line") + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emission by source, type and year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)")) 
