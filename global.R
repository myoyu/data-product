## global.R
NEI = readRDS("summarySCC_PM25.rds");
countyFIPS = read.csv("US_FIPS_Codes.csv", header = TRUE, sep = ",",colClasses=c("FIPSState"="character","FIPSCounty"="character"))
county = countyFIPS$CountyName

