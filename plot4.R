## Assignment question:
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?

NEI <- readRDS("../data/summarySCC_PM25.rds")
SCC <- readRDS("../data/Source_Classification_Code.rds")

data <- merge(NEI, SCC, by = "SCC")
library(dplyr)

data_coal <- data[grepl("Coal", data$EI.Sector),]


total_emmisions <- data_coal %>%
  group_by(year) %>%
  summarise(sum(Emissions))

colnames(total_emmisions)[2] <- "TotalEmmissions"

qplot(year, TotalEmmissions, data = total_emmisions,  geom = "line") +
  ggtitle("PM2.5 Emissions from Coal Combustion-related Sources by Year") +
  xlab("Year") +
  ylab(expression("Total PM2.5 Emissions (Tons)"))


dev.copy(png, "plot4.png")
dev.off()
