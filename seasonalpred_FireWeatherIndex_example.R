#Under Notebooks - 2018_fireDanger_ClimateServices.pdf
#Seasonal pred. of Fire Weather Index example 2018

#load necessary libraries
library(visualizeR)
library(loadeR)
library(loadeR.java)
library(loadeR.ECOMS)
library(downscaleR)
library(downscaleR.java)
library(transformeR)
library(fireDanger)
library(easyVerification)
library(RColorBrewer)

#access User Data Gateway
loginUDG(username = "uSeRnAmE_regi0008", password = "pAssWord")

#this example is developed from using NCEP's CFS-v2 hindcast
#a 27-year hindcast period of 1983:2009
#area of interest: Mediterranean Europe (see if can change spatial domain)

#fire season stated in example is from May to end September
#Supposed to be June-Sept but May is the initialization month
dataset <- "CFSv2_seasonal"
season <- 5:9
leadMonth <- 0
years <- 1983:2009
latLim <- c(35,47)
lonLim <- c(-10,30)
members <- 1:15

#load temperature
#SOME ERROR HERE - with "temp"
temp <- loadECOMS(dataset, var= "tas", members = members,
                  lonLim = lonLim, latLim = latLim,
                  years = years, season = season,
                  leadMonth = leadMonth,
                  time = "DD", aggr.d = "mean")

plotClimatology(climatology(temp), backdrop.theme = "coastline",
            main = "CFSv2 T2M Climatology period 1983-2009")

#loading observations
#defining target dataset
dataset.obs <- "WFDEI"
#load temperature
temp.obs <- loadECOMS(dataset.obs, var= "tas",
                      lonLim = lonLim, latLim = latLim,
                      years = years, season = season)
#multi-grid creation:
multigrid_obs <- makeMultiGrid(temp.obs)

#seasonal forecast and obs data (multigrid_hind and multigrid_obs) can be directly loaded
load(url("http://www.meteo.unican.es/work/fireDanger/wiki/data/multigrid_hind.rda"))
load(url("http://www.meteo.unican.es/work/fireDanger/wiki/data/multigrid_obs.rda"))

#calculating observed (WFDEI) Fire Weather Index (FWI)
obs <- fwiGrid(multigrid = multigrid_obs)

#Seasonal forecast hindcast
#CFSv2 model mask is used to avoid sea surface
#when computing FWI.
cfs_mask <- loadECOMS(dataset, var= "lm",
                      lonLim = lonLim, latLim = latLim)
mask <- interpGrid(cfs_mask, getGrid(multigrid_hind))

hindcast <- fwiGrid(multigrid_hind, mask)

#Adjusting the fire season
#there is a spin-up period of 1 month (of May) to compute FWI.
#Now we remove month of May and retain the rest: JJAS

hindcastJJAS <- subsetGrid(hindcast, season = 6:9)
obsJJAS <- subsetGrid(obs, season = 6:9)

#mean FWI climo. (period 1983-2009) is mapped
fwi.colors <- colorRampPalette(c(rev(brewer.pal(9, "YlGnBu")[3:5]),
                                     brewer.pal(9, "yl0rRd")[3:9]))

