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



# getStateTract <- function(state, region = )
