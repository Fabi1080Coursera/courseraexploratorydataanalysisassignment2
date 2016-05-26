## Assignment question:
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

NEI <- readRDS("../data/summarySCC_PM25.rds")
SCC <- readRDS("../data/Source_Classification_Code.rds")

library(dplyr)

NEI <- NEI %>%
  filter(fips == "24510")

data <- merge(NEI, SCC, by = "SCC")
data_vehicles <- data[grepl("Vehicles", data$EI.Sector),]


total_emmisions <- data_vehicles %>%
  group_by(year,EI.Sector) %>%
  summarise(sum(Emissions))

colnames(total_emmisions)[3] <- "TotalEmmissions"

# Remove the "Mobile - On-Road " from Sectors
total_emmisions <- total_emmisions %>%
  mutate(EI.Sector = sub("Mobile - On-Road ", "", EI.Sector))

qplot(year, TotalEmmissions, data = total_emmisions, color = EI.Sector, geom = "line") +
  ggtitle("PM2.5 Emissions from Vehicle-related Sources by Year") +
  xlab("Year") +
  ylab(expression("Total PM2.5 Emissions (Tons)")) +
  guides(color=guide_legend(title="Vehicle Types"))


dev.copy(png, "plot5.png")
dev.off()
