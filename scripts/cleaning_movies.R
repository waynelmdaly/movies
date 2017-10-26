# Clear workspace
rm(list=ls()) # remove everything currently held in the R memory
options(stringsAsFactors=FALSE)
graphics.off()

# Load libraries
library(dplyr)
library(tidyr)
library(ggplot2)

## Set working directory
setwd("~/Users/Wayne/Desktop/Coursera")
d<-read.csv("movies.csv", header=TRUE)
