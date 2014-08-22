## Script Name: plot6.R
## Exploratory Data Analysis - Project 2 - first plot

## Three Libraries needed for plotting: 
library(plyr)
library(ggplot2)
library(grid)

## First Step : read in the data
NEI <- readRDS("project2-data/summarySCC_PM25.rds")
SCC <- readRDS("project2-data/Source_Classification_Code.rds")

## Second Step : check the levels for types of vehicles defined
mv.sourced <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))

mv.sourcec <- SCC[SCC$EI.Sector %in% mv.sourced, ]["SCC"]


## Third Step : subset our data Baltimore City
emMV.ba <- NEI[NEI$SCC %in% mv.sourcec$SCC & NEI$fips == "24510", ]
## Step 3B: subset our data Los Angeles County
emMV.LA <- NEI[NEI$SCC %in% mv.sourcec$SCC & NEI$fips == "06037", ]

## Fourth Step : bind the data created in steps 3A and 3B
emMV.comb <- rbind(emMV.ba, emMV.LA)
  
## Fifth Step : Find the emmissions due to motor vehicles in 
## Baltimore (city) and Los Angeles County
tmveYR.county <- aggregate (Emissions ~ fips * year, data =emMV.comb, FUN = sum ) 
tmveYR.county$county <- ifelse(tmveYR.county$fips == "06037", "Los Angeles", "Baltimore")

## Plotting Step : plotting to png
png("plot6.png", width=700)
qplot(year, Emissions, data=tmveYR.county, geom="line", color=county) + ggtitle(expression("Motor Vehicle Emission Levels" ~ PM[2.5] ~ "  from 1999 to 2008 in Los Angeles County, CA and Baltimore, MD")) + xlab("Year") + ylab(expression("Levels of" ~ PM[2.5] ~ " Emissions"))
dev.off()

##Last step: Plot to markdown
qplot(year, Emissions, data=tmveYR.county, geom="line", color=county) + ggtitle(expression("Motor Vehicle Emission Levels" ~ PM[2.5] ~ "  from 1999 to 2008 in Los Angeles County, CA and Baltimore, MD")) + xlab("Year") + ylab(expression("Levels of" ~ PM[2.5] ~ " Emissions"))

