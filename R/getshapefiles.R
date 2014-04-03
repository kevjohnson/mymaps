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
#' map <- getUSCounty("Georgia")
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

#' Retrieves shapefile for state census tracts
#'
#' This function returns a dataframe with map data for
#' every census tract in a particular state.
#'
#' @param state string with the abbreviation of the state (e.g. "GA")
#' @param region region to use with the fortify() function, defaults to "GEO_ID".
#' Choices are "GEO_ID", "STATE", "COUNTY", "TRACT", "NAME", "LSAD", "CENSUSAREA".
#' @export
#' @examples
#' map <- getStateTract("GA")
#' makemap(data=d, map = map, var="obese", id="geoid", per=TRUE)

getStateTract <- function(state, region = c("GEO_ID", "STATE", "COUNTY", "TRACT", "NAME", "LSAD", "CENSUSAREA")){
    reg <- match.arg(region)
    data(stateFIPS)
    state <- match.arg(state, choices = fips[,1])
    stateData <- fips[fips[,1] == state,]
    temp <- tempfile()
    url <- paste("http://www2.census.gov/geo/tiger/GENZ2010/gz_2010_", stateData$code, "_140_00_500k.zip", sep="")
    message("Downloading file...")
    download.file(url, temp)
    message("Unzipping file...")
    shp <- unzip(temp, exdir = "shapefiles")
    message("Reading file...")
    file <- paste("shapefiles/gz_2010_", stateData$code, "_140_00_500k.shp", sep="")
    m <- readShapeSpatial(file)
    message("Fortifying dataframe...")
    m <- fortify(m, region = reg)
    unlink(temp)
    return(m)
}

#' Retrieves shapefile for state zip codes
#'
#' This function returns a dataframe with map data for
#' every zip code in a particular state.
#'
#' @param state string with the abbreviation of the state (e.g. "GA")
#' @param region region to use with the fortify() function, defaults to "ZCTA5CE10".
#' Choices are "ZCTA5CE10", "STATEFP10", "GEOID10", "CLASSFP10".
#' @export
#' @examples
#' map <- getStateZip("GA")
#' makemap(data=d, map = map, var="obese", id="geoid", per=TRUE)

getStateZip <- function(state, region = c("ZCTA5CE10", "STATEFP10", "GEOID10", "CLASSFP10")){
    reg <- match.arg(region)
    data(stateFIPS)
    state <- match.arg(state, choices = fips[,1])
    stateData <- fips[fips[,1] == state,]
    temp <- tempfile()
    url <- paste("http://www2.census.gov/geo/tiger/TIGER2010/ZCTA5/2010/tl_2010_", stateData$code, "_zcta510.zip", sep="")
    message("Downloading file...")
    download.file(url, temp)
    message("Unzipping file...")
    shp <- unzip(temp, exdir = "shapefiles")
    message("Reading file...")
    file <- paste("shapefiles/tl_2010_", stateData$code, "_zcta510.shp", sep="")
    m <- readShapeSpatial(file)
    message("Fortifying dataframe...")
    m <- fortify(m, region = reg)
    unlink(temp)
    return(m)
}
