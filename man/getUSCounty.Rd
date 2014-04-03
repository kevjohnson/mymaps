\name{getUSCounty}
\alias{getUSCounty}
\title{Retrieves shapefile for US counties}
\usage{
getUSCounty(state = NULL, region = c("GEO_ID", "STATE", "COUNTY", "NAME",
  "LSAD", "CENSUSAREA"))
}
\arguments{
  \item{state}{string with the full name of the state,
  default is NULL which gives all states.}

  \item{region}{region to use with the fortify() function,
  defaults to "GEO_ID". Choices are "GEO_ID", "STATE",
  "COUNTY", "NAME", "LSAD", "CENSUSAREA".}
}
\description{
This function returns a dataframe with map data for every
county in the US or every county in a particular state.
}
\examples{
map <- getUSCounty("Georgia")
makemap(data=d, map = map, var="obese", id="geoid", per=TRUE)
}

