#climate4R_example2

library(transformeR)
library(downscaleR)
library(visualizeR)
library(loadeR)
library(SpecsVerification)
library(climate4R.climdex)

lon <- c(-10,5)
lat <- c(36,44)

loginUDG(username = "uSeRnAmE_regi0008", password = "pAssWord")

models <- UDG.datasets(pattern = "CORDEX-EUR44.*historical")
ensemble.h <- models$name[1:6]

TXh.list <- lapply(ensemble.h, function(x) loadGridData(dataset=x,
                   var = "tasmax",
                   season=1:12,
                   lonLim = lon,
                   latLim = lat,
                   years = 1971:2000))