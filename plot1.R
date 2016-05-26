## Assignment question:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from
# all sources for each of the years 1999, 2002, 2005, and 2008.


NEI <- readRDS("../data/summarySCC_PM25.rds")
#SCC <- readRDS("../data/Source_Classification_Code.rds")


library(dplyr)

total_emmisions_by_year <- NEI %>%
  group_by(year) %>%
  summarise(sum(Emissions))

colnames(total_emmisions_by_year)[2] <- "TotalEmmissions"

total_emmisions_by_year <- total_emmisions_by_year %>%
  mutate(TotalEmmissions = TotalEmmissions / 1000000)

plot(
  total_emmisions_by_year$year,
  total_emmisions_by_year$TotalEmmissions,
  xlab = "Year",
  ylab = "Total Emissions (1 000 000 Tons)",
  main = "Total" ~ PM[2.5] ~ "emission in the USA over all sources"
)
lines(total_emmisions_by_year$year,
      total_emmisions_by_year$TotalEmmissions)


dev.copy(png, "plot1.png")
dev.off()
