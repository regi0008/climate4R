library(downscaleR)
library(visualizeR)
#Calibration and cross validation
#Example done on the NCEP/NCAR Reanalysis 1 dataset
#and the VALUE station dataset.

#Bias correct winter mean temperature
#using period: 1983-2002
#season: c(12,1,2)


#Observations: temperature
data(VALUE_Iberia_tas)
y.t <- VALUE_Iberia_tas

#predictors
data(NCEP_Iberia_tas)
x.t <- NCEP_Iberia_tas

#load necessary library to visualize plots
library(visualizeR)
library(sp)
spatialPlot(climatology(x.t), backdrop.theme = "coastline", 
            sp.layout = list(list(SpatialPoints(getCoordinates(y)), 
                                  pch = 17, col = "black", cex = 1.5)))
#Use function biasCorrection() and 
#your choice of method: eQM (emphirical quantile mapping)
cal.t <- biasCorrection(y = y.t, x = x.t, newdata = x.t, 
                        method = "eqm")
quickDiagnostics(y.t, x.t, cal.t, type = "daily", location = c(-2.0392, 43.3075))

# time series plotting for Igueldo station
#PROBLEMS AT THIS SECTION with "cal"???
Igueldo.cal.t <- subsetGrid(cal, station.id = "000234")
Ig.coords <- getCoordinates(Igueldo.cal.t)
Igueldo.raw <- subsetGrid(x.t, lonLim = Ig.coords$x.t, latLim = Ig.coords$y.t) 
temporalPlot(Igueldo.cal, Igueldo.raw, cols = c("blue", "red"))

# time series plotting for Igueldo station as a continuous series
temporalPlot(Igueldo.cal, Igueldo.raw, cols = c("blue", "red"), x.axis = "index")

#Cross-validation for temp
#using leave-one-year-out:
cal <- biasCorrection(y=y.t,x=x.t,
                      precipitation = TRUE,
                      method = "eqm",
                      window = c(30,15),
                      wet.threshold = 0.1,
                      cross.val = "loo")
quickDiagnostics(y.t,x.t,cal.t,type="daily",location = c(-2.0392,43.3075))
