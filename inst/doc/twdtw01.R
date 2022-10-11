## ---- echo=FALSE, include=FALSE-----------------------------------------------
knitr::opts_chunk$set(collapse = TRUE)
knitr::opts_chunk$set(fig.height = 4.5)
knitr::opts_chunk$set(fig.width = 6)

## ---- echo = TRUE, eval = TRUE, warning = FALSE, message = FALSE--------------
library(dtwSat)

veg_profiles <- twdtwTimeSeries(MOD13Q1.MT.yearly.patterns)

veg_profiles

class(veg_profiles)

plot(veg_profiles, type = "patterns")

## ---- echo = TRUE, eval = TRUE, warning = FALSE, message = FALSE--------------
veg_ts <- twdtwTimeSeries(MOD13Q1.ts)

veg_ts

class(veg_ts)

plot(veg_ts, type = "timeseries")

## ----echo = TRUE, eval = TRUE, warning = FALSE, message = FALSE---------------
# Define logistic time-weight, see Maus et al. (2016)
weight_fun <- logisticWeight(alpha = -0.1, beta = 50) 

# Run TWDTW analysis 
twdtw_matches <- twdtwApply(x = veg_ts, 
                            y = veg_profiles, 
                            weight.fun = weight_fun, 
                            keep = TRUE, legacy=TRUE) 

class(twdtw_matches)

twdtw_matches

## ---- echo = TRUE, eval = TRUE, warning = FALSE, message = FALSE--------------
plot(x = twdtw_matches, 
     type = "alignments", 
     threshold = 10.0)

## ---- echo = TRUE, eval = TRUE, warning = FALSE, message = FALSE--------------
plot(x = twdtw_matches,
     type = "matches", 
     attr = "evi", 
     patterns.labels = "Soybean-cotton", 
     k = 2) 

## ---- echo = TRUE, eval = TRUE, warning = FALSE, message = FALSE--------------
plot(x = twdtw_matches, 
     type = "paths", 
     patterns.labels = "Soybean-cotton")

## ---- echo = TRUE, eval = TRUE, warning = FALSE, message = FALSE--------------
twdtw_classification <- twdtwClassify(x = twdtw_matches, 
                                      from = "2009-09-01", 
                                      to = "2014-08-31", 
                                      by = "12 month")

twdtw_classification

plot(twdtw_classification, type = "classification")

