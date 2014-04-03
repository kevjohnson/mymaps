#' Retrieves shapefile for US states
#'
#' This function returns a dataframe with map data for
#' every state in the US.
#'
#' @param region region to use with the fortify() function, defaults to "STATE".
#' Choices are "GEO_ID", "STATE", "NAME", "LSAD", "CENSUSAREA".
#' @export
#' @examples
#' map <- getUS()
#' makemap(data=d, map = map, var="obese", id="geoid", per=TRUE)

getUSState <- function(region = c("STATE", "GEO_ID", "NAME", "LSAD", "CENSUSAREA")){
    data(USState)
    reg <- match.arg(region)
    m <- fortify(m, region = reg)
    return(m)
}

#' Retrieves shapefile for US counties
#'
#' This function returns a dataframe with map data for
#' every county in the US or every county in a particular state.
#'
#' @param state string with the full name of the state, default is NULL which
#' gives all states.
#' @param region region to use with the fortify() function, defaults to "GEO_ID".
#' Choices are "GEO_ID", "STATE", "COUNTY", "NAME", "LSAD", "CENSUSAREA".
#' @export
#' @examples
#' map <- getUS()
#' makemap(data=d, map = map, var="obese", id="geoid", per=TRUE)

getUSCounty <- function(state = NULL, region = c("GEO_ID", "STATE", "COUNTY", "NAME", "LSAD", "CENSUSAREA")){
    data(USCounty)
    reg <- match.arg(region)
    if (!is.null(state)){
        m <- m[m$NAME == state,]
    }
    m <- fortify(m, region = reg)
    return(m)
}


setwd("/home/kevin/Copy/Data/Shapefiles")
fips <- read.csv("statefips.csv", stringsAsFactors=F)
fips <- fips[-c(4,13,42,50),]
fips$code <- substring(as.character(fips$FIPS.Code+100),2,3)
for (i in 1:length(fips$code)){
    temp <- tempfile()
    url <- paste("http://www2.census.gov/geo/tiger/GENZ2010/gz_2010_", fips$code[i], "_140_00_500k.zip", sep="")
    download.file(url, temp)
    unzip(temp, exdir=paste(fips[i,1], "Tract", sep=""))
}

for (i in 1:length(fips$code)){
    temp <- tempfile()
    url <- paste("http://www2.census.gov/geo/tiger/TIGER2010/ZCTA5/2010/tl_2010_", fips$code[i], "_zcta510.zip", sep="")
    download.file(url, temp)
    unzip(temp, exdir=paste(fips[i,1], "Zip", sep=""))
}

for (i in 1:length(fips$code)){
    as.name(paste(fips[i,1], "Tract", sep="")) <- readShapeSpatial()
}
