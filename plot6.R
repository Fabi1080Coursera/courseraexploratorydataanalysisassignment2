## Assignment question:
# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

NEI <- readRDS("../data/summarySCC_PM25.rds")
SCC <- readRDS("../data/Source_Classification_Code.rds")

library(dplyr)


NEI <- NEI %>%
  filter(fips %in% c("24510", "06037"))

data <- merge(NEI, SCC, by = "SCC")

data_vehicles <- data[grepl("Vehicles", data$EI.Sector), ]

# Group by year and city
data_vehicles_year <- data_vehicles %>%
  group_by(year, fips) %>%
  summarise("Emissions" = sum(Emissions))

# Get the maximum value for each city to later show a change in percent
maxvals <- data_vehicles_year %>%
  group_by(fips) %>%
  summarise("max_Emissions" = max(Emissions))

# Get the first value for each city to later show a change in percent
firstvals <- data_vehicles_year %>%
  filter(year == 1999)

firstvals$year <- NULL
colnames(firstvals)[2] <- "FirstEmmissions"

# Merge new info to table
data_vehicles_year <-
  merge(data_vehicles_year, maxvals, by = "fips")
data_vehicles_year <-
  merge(data_vehicles_year, firstvals, by = "fips")

# add city name
data_vehicles_year <-
  merge(data_vehicles_year, data.frame(
    "fips" = c("06037", "24510"),
    "Region" = c("Los Angeles County, California", "Baltimore City")
  ), by = "fips")

# Calculate the change in emissions 
data_vehicles_year_change <- data_vehicles_year %>%
  mutate(
    Emissions = (Emissions - FirstEmmissions) / max_Emissions)

# Plot
qplot(year,
      Emissions,
      data = data_vehicles_year_change,
      color = Region,
      geom = "line") +
  scale_y_continuous(name = "Change of Emissions since 1999",labels = scales::percent) +
  xlab("Year")


dev.copy(png, "plot6.png")
dev.off()
