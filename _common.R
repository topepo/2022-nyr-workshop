options(digits = 4, width = 84)
options(dplyr.print_min = 6, dplyr.print_max = 6)
options(cli.width = 85)
options(crayon.enabled = FALSE)

hexes <- function(x) {
  x <- rev(sort(x))
  bad_svg <- c("dplyr", "tidyr")
  x <- ifelse(x %in% bad_svg, paste0(x, ".png"), paste0(x, ".svg"))
  markup <- function(pkg) glue::glue('<img src="images/{pkg}" class="title-hex">')
  res <- purrr::map_chr(x, markup)
  paste0(res, collapse = "")
}

pkg <- function(x) {
  cl <- match.call()
  x <- as.character(cl$x)
  paste0('<span class="pkg">', x, '</span>')
}

link <- rmarkdown::metadata$url
slide_url <- glue::glue("[{link}](https://github.com/topepo/{link})")


# original from https://raw.githubusercontent.com/mrbilltran/the-win-column/master/nhl_rink_plot.R

nhl_rink_plot <- function (NHL_red = rgb(0, 0, 0, .2), NHL_blue = rgb(0, 0, 0, .2), NHL_light_blue = rgb(0, 0, 0, .2)) {
  library(ggforce)

  # Plotting an NHL rink completely following the NHL rule book:
  # https://cms.nhl.bamgrid.com/images/assets/binary/308893668/binary-file/file.pdf
  # Line widths, lengths, colours, all followed as closely as possible

  ggplot() +

    # Faceoff circles
    geom_circle(aes(x0 = 0, y0 = 0, r = 15), colour = NHL_blue, size = 2 / 12) + # Centre
    geom_circle(aes(x0 = 69, y0 = 22, r = 15), colour = NHL_red, size = 2 / 12) + # Top-Right
    geom_circle(aes(x0 = 69, y0 = -22, r = 15), colour = NHL_red, size = 2 / 12) + # Bottom-Right
    geom_circle(aes(x0 = -69, y0 = 22, r = 15), colour = NHL_red, size = 2 / 12) + # Top-Left
    geom_circle(aes(x0 = -69, y0 = -22, r = 15), colour = NHL_red, size = 2 / 12) + # Bottom-Left

    # Hash marks in T-R/B-R/T-L/B-R order, groups of four
    # geom_tile(aes(x = 66.125, y = 37.77, width = 2 / 12, height = 2), fill = NHL_red) +
    # geom_tile(aes(x = 66.125, y = 6.23, width = 2 / 12, height = 2), fill = NHL_red) +
    # geom_tile(aes(x = 71.875, y = 37.77, width = 2 / 12, height = 2), fill = NHL_red) +
    # geom_tile(aes(x = 71.875, y = 6.23, width = 2 / 12, height = 2), fill = NHL_red) +
    # geom_tile(aes(x = 66.125, y = -37.77, width = 2 / 12, height = 2), fill = NHL_red) +
    # geom_tile(aes(x = 66.125, y = -6.23, width = 2 / 12, height = 2), fill = NHL_red) +
    # geom_tile(aes(x = 71.875, y = -37.77, width = 2 / 12, height = 2), fill = NHL_red) +
    # geom_tile(aes(x = 71.875, y = -6.23, width = 2 / 12, height = 2), fill = NHL_red) +
    # geom_tile(aes(x = -66.125, y = 37.77, width = 2 / 12, height = 2), fill = NHL_red) +
  # geom_tile(aes(x = -66.125, y = 6.23, width = 2 / 12, height = 2), fill = NHL_red) +
  # geom_tile(aes(x = -71.875, y = 37.77, width = 2 / 12, height = 2), fill = NHL_red) +
  # geom_tile(aes(x = -71.875, y = 6.23, width = 2 / 12, height = 2), fill = NHL_red) +
  # geom_tile(aes(x = -66.125, y = -37.77, width = 2 / 12, height = 2), fill = NHL_red) +
  # geom_tile(aes(x = -66.125, y = -6.23, width = 2 / 12, height = 2), fill = NHL_red) +
  # geom_tile(aes(x = -71.875, y = -37.77, width = 2 / 12, height = 2), fill = NHL_red) +
  # geom_tile(aes(x = -71.875, y = -6.23, width = 2 / 12, height = 2), fill = NHL_red) +

  # Centre line
  geom_tile(aes(x = 0, y = 0, width = 1, height = 85), fill = NHL_red) + # Centre line

    # Faceoff dots - Plot AFTER centre lines for centre ice circle to show up above
    geom_circle(aes(x0 = 0, y0 = 0, r = 6 / 12), colour = NHL_red, fill = NHL_red, size = 0) + # Centre dot with unique red
    geom_circle(aes(x0 = 69, y0 = 22, r = 1), colour = NHL_red, fill = NHL_red, size = 0) + # Top-Right
    geom_circle(aes(x0 = 69, y0 = -22, r = 1), colour = NHL_red, fill = NHL_red, size = 0) + # Bottom-Right
    geom_circle(aes(x0 = -69, y0 = 22, r = 1), colour = NHL_red, fill = NHL_red, size = 0) + # Top-Left
    geom_circle(aes(x0 = -69, y0 = -22, r = 1), colour = NHL_red, fill = NHL_red, size = 0) + # Bottom-Left

    geom_circle(aes(x0 = 20.5, y0 = 22, r = 1), colour = NHL_red, fill = NHL_red, size = 0) + # Neutral Top-Right
    geom_circle(aes(x0 = 20.5, y0 = -22, r = 1), colour = NHL_red, fill = NHL_red, size = 0) + # Neutral Bottom-Right
    geom_circle(aes(x0 = -20.5, y0 = 22, r = 1), colour = NHL_red, fill = NHL_red, size = 0) + # Neutral Top-Left
    geom_circle(aes(x0 = -20.5, y0 = -22, r = 1), colour = NHL_red, fill = NHL_red, size = 0) + # Neutral Bottom-Left

    # Ells surrounding faceoff dots
    # geom_tile(aes(x = 65, y = 22.83, width = 4, height = 2 / 12), fill = NHL_red) + # Top-Right
    # geom_tile(aes(x = 73, y = 22.83, width = 4, height = 2 / 12), fill = NHL_red) +
    # geom_tile(aes(x = 65, y = 21.17, width = 4, height = 2 / 12), fill = NHL_red) +
    # geom_tile(aes(x = 73, y = 21.17, width = 4, height = 2 / 12), fill = NHL_red) +
    # geom_tile(aes(x = 66.92, y = 24.25, width = 2 / 12, height = 3), fill = NHL_red) +
    # geom_tile(aes(x = 71.08, y = 24.25, width = 2 / 12, height = 3), fill = NHL_red) +
    # geom_tile(aes(x = 66.92, y = 19.75, width = 2 / 12, height = 3), fill = NHL_red) +
    # geom_tile(aes(x = 71.08, y = 19.75, width = 2 / 12, height = 3), fill = NHL_red) +

  # geom_tile(aes(x = 65, y = -22.83, width = 4, height = 2 / 12), fill = NHL_red) + # Bottom-Right
  # geom_tile(aes(x = 73, y = -22.83, width = 4, height = 2 / 12), fill = NHL_red) +
  # geom_tile(aes(x = 65, y = -21.17, width = 4, height = 2 / 12), fill = NHL_red) +
  # geom_tile(aes(x = 73, y = -21.17, width = 4, height = 2 / 12), fill = NHL_red) +
  # geom_tile(aes(x = 66.92, y = -24.25, width = 2 / 12, height = 3), fill = NHL_red) +
  # geom_tile(aes(x = 71.08, y = -24.25, width = 2 / 12, height = 3), fill = NHL_red) +
  # geom_tile(aes(x = 66.92, y = -19.75, width = 2 / 12, height = 3), fill = NHL_red) +
  # geom_tile(aes(x = 71.08, y = -19.75, width = 2 / 12, height = 3), fill = NHL_red) +

  # geom_tile(aes(x = -65, y = 22.83, width = 4, height = 2 / 12), fill = NHL_red) + # Top-Left
  # geom_tile(aes(x = -73, y = 22.83, width = 4, height = 2 / 12), fill = NHL_red) +
  # geom_tile(aes(x = -65, y = 21.17, width = 4, height = 2 / 12), fill = NHL_red) +
  # geom_tile(aes(x = -73, y = 21.17, width = 4, height = 2 / 12), fill = NHL_red) +
  # geom_tile(aes(x = -66.92, y = 24.25, width = 2 / 12, height = 3), fill = NHL_red) +
  # geom_tile(aes(x = -71.08, y = 24.25, width = 2 / 12, height = 3), fill = NHL_red) +
  # geom_tile(aes(x = -66.92, y = 19.75, width = 2 / 12, height = 3), fill = NHL_red) +
  # geom_tile(aes(x = -71.08, y = 19.75, width = 2 / 12, height = 3), fill = NHL_red) +

  # geom_tile(aes(x = -65, y = -22.83, width = 4, height = 2 / 12), fill = NHL_red) + # Bottom-Left
  # geom_tile(aes(x = -73, y = -22.83, width = 4, height = 2 / 12), fill = NHL_red) +
  # geom_tile(aes(x = -65, y = -21.17, width = 4, height = 2 / 12), fill = NHL_red) +
  # geom_tile(aes(x = -73, y = -21.17, width = 4, height = 2 / 12), fill = NHL_red) +
  # geom_tile(aes(x = -66.92, y = -24.25, width = 2 / 12, height = 3), fill = NHL_red) +
  # geom_tile(aes(x = -71.08, y = -24.25, width = 2 / 12, height = 3), fill = NHL_red) +
  # geom_tile(aes(x = -66.92, y = -19.75, width = 2 / 12, height = 3), fill = NHL_red) +
  # geom_tile(aes(x = -71.08, y = -19.75, width = 2 / 12, height = 3), fill = NHL_red) +

  # Referee crease
  # geom_arc(aes(x0 = 0, y0 = -42.5, start = -pi / 2, end = pi / 2, r = 10), colour = NHL_red) +

  # Left goalie crease
  geom_tile(aes(x = -86.75, y = 0, width = 4.5, height = 8), fill = NHL_light_blue) +
    geom_arc_bar(aes(x0 = -89, y0 = 0, start = atan(4.5/4) - 0.01, end = pi - atan(4.5 / 4) + 0.01, r0 = 4, r = 6), fill = NHL_light_blue, colour = NHL_light_blue, size = 1 / 12) + # manually adjusted arc
    geom_tile(aes(x = -86.75, y = -4, width = 4.5, height = 2 / 12), fill = NHL_red) +
    geom_tile(aes(x = -86.75, y = 4, width = 4.5, height = 2 / 12), fill = NHL_red) +
    geom_arc(aes(x0 = -89, y0 = 0, start = atan(4.5/4) - 0.01, end = pi - atan(4.5 / 4) + 0.01, r = 6), colour = NHL_red, size = 2 / 12) + # manually adjusted arc
    geom_tile(aes(x = -85, y = 3.75, width = 2 / 12, height = 0.42), fill = NHL_red) +
    geom_tile(aes(x = -85, y = -3.75, width = 2 / 12, height = 0.42), fill = NHL_red) +

    # Right goalie crease
    geom_tile(aes(x = 86.75, y = 0, width = 4.5, height = 8), fill = NHL_light_blue) +
    geom_arc_bar(aes(x0 = 89, y0 = 0, start = -atan(4.5/4) + 0.01, end = -pi + atan(4.5 / 4) - 0.01, r0 = 4, r = 6), fill = NHL_light_blue, colour = NHL_light_blue, size = 1 / 12) + # manually adjusted arc
    geom_tile(aes(x = 86.75, y = -4, width = 4.5, height = 2 / 12), fill = NHL_red) +
    geom_tile(aes(x = 86.75, y = 4, width = 4.5, height = 2 / 12), fill = NHL_red) +
    geom_arc(aes(x0 = 89, y0 = 0, start = -atan(4.5/4) + 0.01, end = -pi + atan(4.5 / 4) - 0.01, r = 6), colour = NHL_red, size = 2 / 12) + # manually adjusted arc
    geom_tile(aes(x = 85, y = 3.75, width = 2 / 12, height = 0.42), fill = NHL_red) +
    geom_tile(aes(x = 85, y = -3.75, width = 2 / 12, height = 0.42), fill = NHL_red) +

    # Goalie nets placed as rectangles
    geom_tile(aes(x = -90.67, y = 0, width = 3.33, height = 6), fill = "#E5E5E3") + # Left # with grey fills
    geom_tile(aes(x = 90.67, y = 0, width = 3.33, height = 6), fill = "#E5E5E3") + # Right

    # Trapezoids
    geom_polygon(aes(x = c(-100, -100, -89, -89), y = c(10.92, 11.08, 7.08, 6.92)), fill = NHL_red) + # Left
    geom_polygon(aes(x = c(-100, -100, -89, -89), y = c(-10.92, -11.08, -7.08, -6.92)), fill = NHL_red) + # Left
    geom_polygon(aes(x = c(100, 100, 89, 89), y = c(10.92, 11.08, 7.08, 6.92)), fill = NHL_red) + # Right
    geom_polygon(aes(x = c(100, 100, 89, 89), y = c(-10.92, -11.08, -7.08, -6.92)), fill = NHL_red) + # Right

    # Lines
    geom_tile(aes(x = -25.5, y = 0, width = 1, height = 85), fill = NHL_blue) + # Left Blue line
    geom_tile(aes(x = 25.5, y = 0, width = 1, height = 85),  fill = NHL_blue) + # Right Blue line
    geom_tile(aes(x = -89, y = 0, width = 2 / 12, height = 73.50), fill = NHL_red) + # Left goal line (73.5 value is rounded from finding intersect of goal line and board radius)
    geom_tile(aes(x = 89, y = 0, width = 2 / 12, height = 73.50), fill = NHL_red) + # Right goal line

    # Borders as line segments - plotted last to cover up line ends, etc.
    geom_line(aes(x = c(-72, 72), y = c(42.5, 42.5))) + # Top
    geom_line(aes(x = c(-72, 72), y = c(-42.5, -42.5))) + # Bottom
    geom_line(aes(x = c(-100, -100), y = c(-14.5, 14.5))) + # Left
    geom_line(aes(x = c(100, 100), y = c(-14.5, 14.5))) + # Right
    geom_arc(aes(x0 = 72, y0 = 14.5, start = pi / 2, end = 0, r = 28)) + # Top-Right
    geom_arc(aes(x0 = 72, y0 = -14.5, start = pi, end =  pi / 2, r = 28)) + # Bottom-Right
    geom_arc(aes(x0 = -72, y0 = 14.5, start = - pi / 2, end = 0, r = 28)) + # Top-Left
    geom_arc(aes(x0 = -72, y0 = -14.5, start = pi, end =  3 * pi / 2, r = 28)) + # Bottom-Left

    # Fixed scale for the coordinate system
    coord_fixed() +

    # Max's mods
    theme_void() +
    theme(legend.position = "top") +
    theme(
      axis.title.x = element_blank(),
      axis.text.x  = element_blank(),
      axis.ticks.x = element_blank(),
      axis.title.y = element_blank(),
      axis.text.y  = element_blank(),
      axis.ticks.y = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.border = element_blank()
    )
}

# theme_void() # include this for a blank plot, but likely easier to include in ggplot2 function in main code to control layering

plot_rink <- function(dat, group = on_goal, ...) {

  nhl_rink_plot() +
    geom_point(
      data = dat,
      aes(x = coord_x, y = coord_y, col = {{group}}, pch = {{group}}),
      ...
    )
}

