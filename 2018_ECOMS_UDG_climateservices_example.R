#2018_ECOMS-UDG_ClimateServices.pdf
#towards seasonal pred. dat provision and research producibility

library(loadeR.ECOMS)             #for data-downloading
library(transformeR)              #for post-processing and plotting
library(easyVerification)         #for verification
library(RColorBrewer)             #for spectral color palette used in the paper in the correlation maps

cols <- brewer.pal(n = 11, name = "Spectral")
veri.colors <- colorRampPalette(rev(cols))

#loading of data
##NCEP Reanalysis SLP
url <-  "http://meteo.unican.es/work/UDG/NCEP_psl_DJF_annual_1949_2010_LD.Rdata"
temp_file <- tempfile()
download.file(url, destfile = temp_file)
load(temp_file, .GlobalEnv, verbose = TRUE)
##CFSv2 SLP
url <- "http://meteo.unican.es/work/UDG/CFS_24_lm1_psl_DJF_annual_1983_2010_LD.Rdata"
temp_file <- tempfile()
download.file(url, destfile = temp_file)
load(temp_file, .GlobalEnv, verbose = TRUE)

#access the UDG
loginUDG(username = "uSeRnAmE_regi0008", password = "pAssWord")

##NCEP Reanalysis1 data
lonLim = c(-90,40)
latLim = c(20,80)
var = "pal"             #pal is denoted as sea-level pressure

#"pal" data is loaded to reconstruct observed winter NAO index
#with seasons = c(12,1,2) for analysis period of 1950-2010.
#argument time = "DD" converts data from 6-hour to daily
#argument aggr.d = "mean" indicates aggregation func.
#argument aggr.m = "mean" indicates daily data to be monthly averaged.

NCEP_Iberia_psl <- loadECOMS("NCEP_reanalysis1",
                      var = var,
                      lonLim = lonLim,
                      latLim = latLim,
                      season = c(12,1,2),
                      years = NULL,
                      time = "DD",
                      aggr.d = "mean",
                      aggr.m = "mean")

#plot the mean sea-level pressure winter climo.
spatialPlot(climatology(NCEP_Iberia_psl),
                backdrop.theme = "coastline",
                main = "NCEP mean DJF SLP (1950-2010)")

#temporal aggregation
NCEP_Iberia_psl <- aggregateGrid(grid = CFS_Iberia_psl, aggr.y = list(FUN="mean"))
CFS_Iberia_psl <- aggregateGrid(grid = CFS_Iberia_psl, aggr.y = list(FUN="mean"))

