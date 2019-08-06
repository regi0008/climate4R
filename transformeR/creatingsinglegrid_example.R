library(transformeR)
library(downscaleR)
library(visualizeR)
library(loadeR)
library(SpecsVerification)

data(NCEP_Iberia_tas)
example <- plotMeanGrid(NCEP_Iberia_tas)

annualtemp <- aggregateGrid(NCEP_Iberia_tas, aggr.d = list(FUN = "sum", na.rm = TRUE),
                                             aggr.m = list(FUN = "sum", na.rm = TRUE),
                                             aggr.y = list(FUN = "sum", na.rm = TRUE))
#message return before this reports that the input data
#is not sub-daily, being the daily aggregation option ignored
#Aggregation is done by steps, data is first monthly aggregated
#and then annually

tas.clim <- climatology(NCEP_Iberia_tas, list(FUN = "mean", na.rm = TRUE))
example.clim <- makeMultiGrid(tas.clim)
spatialPlot(example.clim, backdrop.theme = "countries")

str(example$Data)
tas <- subsetGrid(example, var = "tas")