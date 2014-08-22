## Script Name: plot4.R
## Exploratory Data Analysis - Project 2 - Fourth plot

## Two Libraries needed for plotting:
library(plyr)
library(ggplot2)

## First Step : read in the data
NEI <- readRDS("project2-data/summarySCC_PM25.rds")
SCC <- readRDS("project2-data/Source_Classification_Code.rds")

## Second Step: subset our data for only coal-combustion
coalcomb.scc <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal", 
  "Fuel Comb - Electric Generation - Coal", "Fuel Comb - Industrial Boilers, ICEs - 
  Coal"))

## Third Step : comparisons so that we didn't ommit anything weird
coalcomb.scc1 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))

nrow(coalcomb.scc)
nrow(coalcomb.scc1)

## Fourth Step : set the differences 
dif1 <- setdiff(coalcomb.scc$SCC, coalcomb.scc1$SCC)
dif2 <- setdiff(coalcomb.scc1$SCC, coalcomb.scc$SCC)

length(dif1)#0
length(dif2)#91

##Based on other coursera courses and previous history...
###it's time to look at the union of these sets
coalcomb.codes <- union(coalcomb.scc$SCC, coalcomb.scc1$SCC)
length(coalcomb.codes) #91

## Fifth Step : subset again for what we want
coal.comb <- subset(NEI, SCC %in% coalcomb.codes)

## Sixth Step : get the PM25 values as well
coalcomb.pm25year <- ddply(coal.comb, .(year, type), function(x) sum(x$Emissions))

#rename the col
colnames(coalcomb.pm25year)[3] <- "Emissions"

## One more Step : finally plot4.png prepare to plot to png
png("plot4.png")
qplot(year, Emissions, data=coalcomb.pm25year, color=type, geom="line") + 
stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", 
color = "green", aes(shape="total"), geom="line") + geom_line(aes(size="total", shape = NA)) + 
ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + 
xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()

## Last Step : prepare to plot to markdown - Finish
qplot(year, Emissions, data=coalcomb.pm25year, color=type, geom="line") + 
stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", 
color = "green", aes(shape="total"), geom="line") + 
geom_line(aes(size="total", shape = NA)) + ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + 
xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

