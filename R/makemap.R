#' Creates a Map
#'
#' This function takes in a dataframe, shapefile path,
#' and variable and outputs a .png file
#'
#' @param data Dataframe with the data you want to plot.  Must have
#' two columns with the first column called "id" matching up with the
#' "id" column in the map dataframe.
#' @param map Dataframe with shapefile data (after using fortify()).
#' @param palette Color Brewer palette to use (http://colorbrewer2.org/).
#' @param title String with title of the map, defaults to blank.
#' @param fill_label String with a label for a legend, defaults to blank.
#' @param output String with output filename, defaults to "out.png".
#' @param width Defaults to 7.
#' @param height Defaults to 7.
#' @param per TRUE if labels are a percentage (0.2 -> 20\%), defaults to FALSE.
#' @param reverse_colors TRUE if you want to reverse the colors on the legend,
#' defaults to FALSE.
#' @param reverse_legend TRUE if you want to reverse the legend, defaults to TRUE.
#' @param breaks Sets the breaks for the legend, defaults to pretty_breaks(n = 10).
#' @param projection Method of projection, takes in Mercator or Albers.
#' @param proj_args Any arguments necessary for the projection method
#' (Albers requires lat0 and lat1 arguments).
#' @param border Optional parameter if you want different borders
#' (i.e. census tract data with county borders).
#' @param border_color Color of the borders, defaults to black.
#' @param border_size Size of the borders, defaults to 0.25.
#' @param additional_layers Add additional ggplot layers to customize the chart.
#' @export
#' @examples
#' makemap(data=d, map = map)

makeMap <- function(data, map, palette = "Greens",
                    title = "", fill_label = "", output = "out.png",
                    width = 7, height = 7, per = FALSE, reverse_colors = FALSE,
                    reverse_legend = TRUE, breaks = pretty_breaks(n = 10),
                    projection = c("mercator", "lambert"),
                    proj_args = NULL, border = NULL, border_color = "black",
                    border_size = 0.25, additional_layers = NULL){
    proj <- match.arg(projection)
    colnames(data)[2] <- "var"
    plotData <- left_join(map, data, by = "id")
    p <- ggplot()
    if(is.null(border)){
        border = map
    }
    p <- p + geom_polygon(data = plotData, aes(x = long, y = lat, group = group, fill = var), color = NA) +
        geom_polygon(data = border, aes(x = long, y = lat, group = group), fill = NA, color = border_color, size = border_size)
    if (per & reverse_colors) {
        p <- p + scale_fill_distiller(palette = palette, breaks = breaks, labels = percent, values = c(1,0))
    } else if (per & !reverse_colors) {
        p <- p + scale_fill_distiller(palette = palette, breaks = breaks, labels = percent)
    } else if (!per & reverse_colors) {
        p <- p + scale_fill_distiller(palette = palette, breaks = breaks, values = c(1,0))
    } else {
        p <- p + scale_fill_distiller(palette = palette, breaks = breaks)
    }
    if (proj == "mercator"){
        p <- p + coord_map(projection = "mercator")
    } else {
        p <- p + coord_map(projection = "lambert", lat0 = proj_args[1], lat1 = proj_args[2])
    }
    p <- p + labs(title = title, fill = fill_label)
    p <- p + theme_nothing(legend = TRUE)
    if (reverse_legend) {
        p <- p + guides(fill = guide_legend(reverse = TRUE))
    }
    if (!is.null(additional_layers)) {
        p <- p + additional_layers
    }
    message("Plotting Map...")
    if (substring(output, nchar(output)-2, nchar(output)) == "png") {
        ggsave(p, file = output, width = width, height = height, type = "cairo-png")
    } else{
        ggsave(p, file = output, width = width, height = height)
    }
}
