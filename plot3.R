## Assignment question:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999-2008 
# for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the 
# ggplot2 plotting system to make a plot answer this question.

NEI <- readRDS("../data/summarySCC_PM25.rds")

library(dplyr)
library(ggplot2)

NEI <- NEI %>%
  filter(fips == "24510")

total_emmisions <- NEI %>%
  group_by(year, type) %>%
  summarise(sum(Emissions))

colnames(total_emmisions)[2] <- "Type"
colnames(total_emmisions)[3] <- "TotalEmmissions"

qplot(year, TotalEmmissions, data = total_emmisions, color = Type, geom = "line") +
  ggtitle("Baltimore City PM2.5 Emissions by Source Type and Year") +
  xlab("Year") +
  ylab(expression("Total PM2.5 Emissions (Tons)"))


dev.copy(png, "plot3.png")
dev.off()
