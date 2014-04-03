\name{getStateZip}
\alias{getStateZip}
\title{Retrieves shapefile for state zip codes}
\usage{
getStateZip(state, directory = "shapefiles", region = c("ZCTA5CE10",
  "STATEFP10", "GEOID10", "CLASSFP10"))
}
\arguments{
  \item{state}{string with the abbreviation of the state
  (e.g. "GA")}

  \item{directory}{directory where shapefiles are located,
  or directory for shapefiles to be downloaded into,
  defaults to "shapefiles"}

  \item{region}{region to use with the fortify() function,
  defaults to "ZCTA5CE10". Choices are "ZCTA5CE10",
  "STATEFP10", "GEOID10", "CLASSFP10".}
}
\description{
This function returns a dataframe with map data for every
zip code in a particular state.
}
\examples{
map <- getStateZip("GA")
makemap(data=d, map = map, var="obese", id="geoid", per=TRUE)
}

