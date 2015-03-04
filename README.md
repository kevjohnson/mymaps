# mymaps

I make a lot of maps so I made a simple R package to do it for me so I don't have type a bunch of ggplot commands over and over again.  This isn't really meant for other people to use and it is heavily geared toward my specific use cases.

###Installation
```R
install.packages("devtools")
library(devtools)
install_github("kevjohnson/mymaps")
```

###Usage
Available functions include:
* `getUSState()`: loads a shapefile of all 48 contiguous states (shapefile is included in package)
* `getUSCounty()`: loads a shapefile of all counties in all 48 contiguous states (takes an optional "state" argument if you only want one state)
* `getStateTract(state = "GA")`: downloads a shapefile for all census tracts in a given state
* `getStateZip(state = "GA")`: downloads a shapefile for all zip codes in a given state
* `makeMap()`: makes a map and saves it to a file, has a whole bunch of parameters (type `?makeMap` to get a description of all parameters)

At minimum, `makeMap()` needs two arguments: a dataframe with your data and a dataframe returned by one of the four shapefile functions.  Your data dataframe must have two columns.  The first column has to match up with the "id" column of the shapefile dataframe (this will be used to join the two dataframes).  The second column is the variable you want to plot on the map.

Here is a short example of a map of every county in the US with some randomly generated data.

```R
library(mymaps)
county <- getUSCounty()
data <- data.frame(id = unique(county$id))
data$var <- runif(nrow(data))
makeMap(data = data, map = county,
    projection = "lambert", proj_args = c(33,45),
    output = "out.png", width = 7, height = 4,
    additional_layers = theme(legend.position = c(1,0), legend.justification = c(1,0)))
```

By default, the function draws the borders of whatever your data is.  If you want to plot county level data but draw state borders then you can use this:

```R
state <- getUSState()
makeMap(data = data, map = county, border = state,
    projection = "lambert", proj_args = c(33,45),
    output = "out.png", width = 7, height = 4,
    additional_layers = theme(legend.position = c(1,0), legend.justification = c(1,0)))
```
