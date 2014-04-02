#' Creates a Map
#'
#' This function takes in a dataframe, shapefile path,
#' and variable and outputs a .png file

#' @param data dataframe with the data you want to plot
#' @param shapefile_path string with path to the shapefile
#' @param var string with variable in the dataframe that you want to plot
#' @param id string with id variable in the dataframe (e.g. "geoid")
#' @param colors color scale to use with scale_fill_gradientn(), defaults to tim.colors(100)
#' @param title string with title of the map, defaults to blank
#' @param fill_label string with a label for a legend, defaults to blank
#' @param output string with output filename, defaults to "out.png"
#' @param width defaults to 7
#' @param height defaults to 7
#' @param per TRUE if labels are a percentage (0.2 -> 20%), defaults to FALSE
#' @param region string with region variable in shapefile, defaults to NULL
#' @export
#' @examples
#' makemap(data=d, shapefile_path="data/census/shapefiles/ar/tl_2010_05_county10.shp", var="obese", id="geoid", region="COUNTYFP10", per=TRUE)

makemap <- function(data, shapefile_path, var, id, colors = tim.colors(100),
                    title = "", fill_label = "", output = "out.png",
                    width = 7, height = 7, per = FALSE, region = NULL){
    map <- readShapeSpatial(shapefile_path)
    map <- fortify(map, region = region)
    p <- ggplot()
    p <- p + geom_map(data = data, aes_string(map_id = id, fill = var), map = map)
    p <- p + geom_path(data = map, aes(x = long, y = lat, group = group), colour = "black", size = 0.25)
    if (per){
        p <- p + scale_fill_gradientn(colours = colors, labels = percent)
    } else {
        p <- p + scale_fill_gradientn(colours = colors)
    }
    p <- p + coord_map(projection = "mercator")
    p <- p + labs(title = title, fill = fill_label)
    p <- p + theme_nothing(legend = TRUE)
    message("Plotting Map...")
    ggsave(p, file = output, width = width, height = height, type = "cairo-png")
}
