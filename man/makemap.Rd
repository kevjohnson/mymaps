\name{makemap}
\alias{makemap}
\title{Creates a Map}
\usage{
makemap(data, shapefile_path, var, id, colors = tim.colors(100), title = "",
  fill_label = "", output = "out.png", width = 7, height = 7,
  per = FALSE, region = NULL)
}
\arguments{
  \item{data}{dataframe with the data you want to plot}

  \item{shapefile_path}{string with path to the shapefile}

  \item{var}{string with variable in the dataframe that you
  want to plot}

  \item{id}{string with id variable in the dataframe (e.g.
  "geoid")}

  \item{colors}{color scale to use with
  scale_fill_gradientn(), defaults to tim.colors(100)}

  \item{title}{string with title of the map, defaults to
  blank}

  \item{fill_label}{string with a label for a legend,
  defaults to blank}

  \item{output}{string with output filename, defaults to
  "out.png"}

  \item{width}{defaults to 7}

  \item{height}{defaults to 7}

  \item{per}{TRUE if labels are a percentage (0.2 -> 20%),
  defaults to FALSE}

  \item{region}{string with region variable in shapefile,
  defaults to NULL}
}
\description{
This function takes in a dataframe, shapefile path, and
variable and outputs a .png file
}
\examples{
makemap(data=d, shapefile_path="data/census/shapefiles/ar/tl_2010_05_county10.shp", var="obese", id="geoid", region="COUNTYFP10", per=TRUE)
}

