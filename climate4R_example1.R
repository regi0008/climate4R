#climate4R example 1

library(transformeR)
library(downscaleR)
library(visualizeR)
library(loadeR)
library(climate4R.climdex)

eobs <- "http://opendap.knmi.nl/knmi/thredds/dodsC/e-obs_0.25regular/tx_0.25deg_reg_v17.0.nc"
di <- dataInventory(eobs)

summerindex <- loadGridData(eobs, var="tx",
                            season=1:12,
                            years=1971:2000,
                            lonLim = lon,
                            latLim = lat,
                            aggr.m = "sum",
                            condition = "GT",
                            threshold = 25)