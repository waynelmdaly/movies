# Clear workspace
rm(list=ls()) # remove everything currently held in the R memory
options(stringsAsFactors=FALSE)
graphics.off()

# Load libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(lubridate)
library(arm)
#library(swirl)

## Set working directory
setwd("C:/Users/Wayne/Documents/GitHub/movies")
d<-read.csv("movies.csv", header=TRUE)

d$horror<- grepl("Horror", d$genres)
d$release_date<-as.Date(d$release_date, "%m/%d/%Y")
d$year<-substr(d$release_date, 1, 4)
sort(unique(d$year)) ## This sorts out your unique years in your dataframe
d<-d %>%
  filter(year>=1930)
d$decade<-substr(d$year, 3, 3)
d$decade<-ifelse(d$decade==3, "30s", d$decade)
d$decade<-ifelse(d$decade==4, "40s", d$decade)
d$decade<-ifelse(d$decade==5, "50s", d$decade)
d$decade<-ifelse(d$decade==6, "60s", d$decade)
d$decade<-ifelse(d$decade==7, "70s", d$decade)
d$decade<-ifelse(d$decade==8, "80s", d$decade)
d$decade<-ifelse(d$decade==9, "90s", d$decade)
d$decade<-ifelse(d$decade==0, "00s", d$decade)
d$decade<-ifelse(d$decade==1, "10s", d$decade)
unique(d$decade)

d.horror <- subset(d, d$horror ==TRUE)
unique(d.horror$decade)
length(unique(d.horror$year))
sort(unique(d.horror$year))
hist(d.horror$year) # Error in hist.default(d.horror$year) : 'x' must be numeric
d.horror$year<-as.numeric(d.horror$year)

class(d.horror$popularity)
names(d.horror)
d.horror$budget<-as.numeric(d.horror$budget)

d.horror$bydecade <- reorder(d.horror$decade, d.horror$year)
d.horror$boxoffice<-d.horror$budget + d.horror$revenue

### Stats time...
mod<-lm(revenue~year, data=d.horror)
display(mod)


qplot(bydecade, popularity, data = d.horror, 
      geom = "boxplot")

qplot(bydecade, boxoffice, data = d.horror, 
      geom = "boxplot")

hist(d.horror$boxoffice)

write.csv(d.horror, file="C:/Users/Wayne/Documents/GitHub/movies/analyses/output/horror.csv", row.names = FALSE)

#names(d)
#unique(d$genres)
#class(d$genres)
