## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, collapse = TRUE, dev = "png")

## ----echo = TRUE, eval = TRUE, warning = FALSE, message = FALSE---------------
library(dtwSat)

samples <- st_read(system.file("mato_grosso_brazil/samples.gpkg", package = "dtwSat"), quiet = TRUE)

## ----echo = TRUE, eval = TRUE, warning = FALSE, message = FALSE---------------
tif_files <- dir(system.file("mato_grosso_brazil", package = "dtwSat"), pattern = "\\.tif$", full.names = TRUE)

acquisition_date <- as.Date(regmatches(tif_files, regexpr("[0-9]{8}", tif_files)), format = "%Y%m%d")

print(acquisition_date)

## ----echo = TRUE, eval = TRUE, warning = FALSE, message = FALSE---------------
# read data-cube
dc <- read_stars(tif_files,
                 proxy = FALSE,
                 along = list(time = acquisition_date),
                 RasterIO = list(bands = 1:6))

# set band names
dc <- st_set_dimensions(dc, 3, c("EVI", "NDVI", "RED", "BLUE", "NIR", "MIR"))

# convert band dimension to attribute
dc <- split(dc, c("band"))

print(dc)

## ----echo = TRUE, eval = TRUE, warning = FALSE, message = FALSE---------------
twdtw_model <- twdtw_knn1(x = dc,
                          y = samples,
                          cycle_length = 'year',
                          time_scale = 'day',
                          time_weight = c(steepness = 0.1, midpoint = 50),
                          formula = band ~ s(time))

print(twdtw_model)

## ----echo = TRUE, eval = TRUE, warning = FALSE, message = FALSE---------------
plot(twdtw_model)

## ----echo = TRUE, eval = TRUE, warning = FALSE, message = FALSE---------------
lu_map <- predict(dc, model = twdtw_model)
print(lu_map)

## ----echo = TRUE, eval = TRUE, warning = FALSE, message = FALSE---------------
ggplot() +
  geom_stars(data = lu_map) +
  theme_minimal()

## ----echo = TRUE, eval = FALSE, warning = FALSE, message = FALSE--------------
#  write_stars(lu_map, "lu_map.tif")

