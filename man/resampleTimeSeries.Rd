% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/resampleTimeSeries.R
\docType{methods}
\name{resampleTimeSeries}
\alias{resampleTimeSeries}
\alias{resampleTimeSeries,twdtwTimeSeries-method}
\alias{resampleTimeSeries-twdtwMatches}
\title{Resample time series}
\usage{
resampleTimeSeries(object, length = NULL)

\S4method{resampleTimeSeries}{twdtwTimeSeries}(object, length = NULL)
}
\arguments{
\item{object}{an object of class twdtwTimeSeries.}

\item{length}{An integer. The number of samples to resample the time series to. 
If not declared the length is set to the length of the longest time series.}
}
\value{
An object of class \code{\link[dtwSat]{twdtwTimeSeries}} whose 
time series have the same number of samples (points).
}
\description{
Resample time series in the object to have the same length.
}
\examples{
# Resampling time series from objects of class twdtwTimeSeries
patt = twdtwTimeSeries(MOD13Q1.patterns.list)
npatt = resampleTimeSeries(patt, length=46)
nrow(patt)
nrow(npatt)

}
\seealso{
\code{\link[dtwSat]{twdtwTimeSeries-class}}, and
\code{\link[dtwSat]{twdtwApply}}
}
\author{
Victor Maus, \email{vwmaus1@gmail.com}
}
