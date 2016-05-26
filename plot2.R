## Assignment question:
# Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting
# system to make a plot answering this question.

NEI <- readRDS("../data/summarySCC_PM25.rds")


library(dplyr)

NEI <- NEI %>%
  filter(fips == "24510")

total_emmisions_by_year <- NEI %>%
  group_by(year) %>%
  summarise(sum(Emissions))

colnames(total_emmisions_by_year)[2] <- "TotalEmmissions"

plot(
  total_emmisions_by_year$year,
  total_emmisions_by_year$TotalEmmissions,
  xlab = "Year",
  ylab = "Total Emissions (Tons)",
  main = "Total" ~ PM[2.5] ~ "emission in Baltimore City over all sources"
)
lines(total_emmisions_by_year$year,
      total_emmisions_by_year$TotalEmmissions)
abline(lm(total_emmisions_by_year$TotalEmmissions ~total_emmisions_by_year$year), col="blue", lwd=2)
legend("topright", "Trend", col="blue", lwd=2)

dev.copy(png, "plot2.png")
dev.off()
