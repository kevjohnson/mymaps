makemap <- function(data, shapefile_path, var, colors = tim.colors(100),
                    title = "", fill_label = "", output = "out.png",
                    width = 7, height = 7, percent = FALSE, region = NULL){
    message("butts")
    map <- readShapeSpatial(shapefile_path)
    map <- fortify(map, region = region)
    p <- ggplot()
    p <- p + geom_map(data = data, aes(map_id = id, fill = as.name(var)), map = map)
    p <- p + geom_path(data = map, aes(x = long, y = lat, group = group), colour = "black", size = 0.25)
    if (percent){
        p <- p + scale_fill_gradientn(colours = colors, labels = percent)
    } else {
        p <- p + scale_fill_gradientn(colours = colors)
    }
    p <- p + coord_map(projection = "mercator")
    p <- p + labs(title = title, fill = fill_label)
    p <- p + theme_nothing(legend = TRUE)
    ggsave(p, file = output, width = width, height = height, type = "cairo-png")
}
