#' Creates a Map
#'
#' This function takes in a dataframe, shapefile path,
#' and variable and outputs a .png file
#'
#' @param data dataframe with the data you want to plot
#' @param map dataframe with map data (after using fortify())
#' @param var string with variable in the dataframe that you want to plot
#' @param id string with id variable in the dataframe (e.g. "geoid")
#' @param colors color scale to use with scale_fill_gradientn(), defaults
#' to tim.colors(100)
#' @param title string with title of the map, defaults to blank
#' @param fill_label string with a label for a legend, defaults to blank
#' @param output string with output filename, defaults to "out.png"
#' @param width defaults to 7
#' @param height defaults to 7
#' @param per TRUE if labels are a percentage (0.2 -> 20%), defaults to FALSE
#' @param projection method of projection, takes in Mercator or Albers
#' (Albers requires lat0 and lat1 arguments)
#' @param proj_args any arguments necessary for the projection method
#' @export
#' @examples
#' makemap(data=d, map = map, var="obese", id="geoid", per=TRUE)

makeMap <- function(data, map, var, id, colors = tim.colors(100),
                    title = "", fill_label = "", output = "out.png",
                    width = 7, height = 7, per = FALSE,
                    projection = c("mercator", "albers"), proj_args = NULL){
    p <- ggplot()
    p <- p + geom_map(data = data, aes_string(map_id = id, fill = var), map = map)
    p <- p + geom_path(data = map, aes(x = long, y = lat, group = group), colour = "black", size = 0.25)
    if (per){
        p <- p + scale_fill_gradientn(colours = colors, labels = percent)
    } else {
        p <- p + scale_fill_gradientn(colours = colors)
    }
    proj <- match.arg(projection)
    if (proj == "mercator"){
        p <- p + coord_map(projection = "mercator")
    } else {
        p <- p + coord_map(projection = "albers", lat0 = proj_args[1], lat1 = proj_args[2])
    }
    p <- p + labs(title = title, fill = fill_label)
    p <- p + theme_nothing(legend = TRUE)
    message("Plotting Map...")
    ggsave(p, file = output, width = width, height = height, type = "cairo-png")
}
