#seasonal predictions and verification

library(visualizeR)
library(loadeR)
library(loadeR.java)
library(loadeR.ECOMS)
library(downscaleR)
library(transformeR)
library(RColorBrewer)

var <- "tas"
#start year
year.ini <- 1983
#end year
year.end <- 2008
season <- c(12,1,2)
lead.month <- 1
members <- 1:15
lonlim <- c(-10,5)
latlim <- c(35,45)

#loaderECOMS is password-protected
loginUDG(username = "uSeRnAmE_regi0008", password = "pAssWord")

#problems with this one below with "loadECOMS" or "loadeRECOMS"
#for climate data access and post-processing with loadeR package
prd <- loadECOMS(dataset = "CFSv2_seasonal", var=var, lonLim=lonlim, 
                 latLim=latlim, season=season, years = year.ini:year.end,
                 leadMonth=lead.month, members=members, time="DD", aggr.d="mean")
obs <- loadECOMS(dataset = "WFDEI", var=var, lonLim=lonlim, latLim=latlim, 
                 season=season, years = year.ini:year.end)
