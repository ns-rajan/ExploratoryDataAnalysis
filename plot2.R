## Script Name: plot2.R
## Exploratory Data Analysis - Project 2 - Second plot
## No Libraries needed

## First Step: Set working directory
setwd("E:/Sivarajan/Coursera-Exploratory Data Analysis/Project2")

## Step 1: read in the data
NEI <- readRDS("project2-data/summarySCC_PM25.rds")
SCC <- readRDS("project2-data/Source_Classification_Code.rds")

## Step 2: obtain the subsets to plot
baltimore <- subset (NEI, fips == "24510")
total.PM25yr <- tapply(baltimore$Emissions, baltimore$year, sum)

## Step 3: plot prepare to plot to png
png("plot2.png")
plot(names(total.PM25yr), total.PM25yr, type = "l", xlab="Year", 
ylab= expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), 
main=expression("Total for Baltimore City" ~ PM[2.5] ~ "Emissions by Year"), col = "red")
dev.off()     
## Step 4: plot to markdown file
plot(names(total.PM25yr), total.PM25yr, type = "l", xlab="Year", 
ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), 
main=expression("Total for Baltimore City" ~ PM[2.5] ~ "Emissions by Year"), col="red")
