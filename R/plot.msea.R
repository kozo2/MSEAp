## Overview plot of MSEA results
## This function plots the results of MSEA.
## It was originally from the MetaboAnalyst.
## The code was modified under the licence GPL-2.
##
# plot <- function(object){
#   UseMethod("plot")
# }

# print <- function(object){
#   UseMethod("print")
# }
#
# ##' @export
# print.msea <- function(object) {
#   object <- data.frame(object)
#   print.data.frame(object)
# }

##' @export
plot.msea <- function(x, col = "cm.colors", show.limit = 20, ...) {
  if (!methods::is(x, "msea")) {
    stop("msea.res should be msea object.")
  }

  barplot(x)
}

#' plot count bar on each meatbolite-set
#'
#' @param x a msea object
#' @param col color scheme
#' @param show.limit the number of metabolite-sets to plot
#' @return plot
#' @examples
#' data(mset_SMPDB_Metabolic_format_HMDB)
#' data(msea.example)
#' res <- msea(mset_SMPDB_Metabolic_format_HMDB, msea.example)
#' barplot(res)
##' @export
barplot <- function(x, col = "cm.colors", show.limit = 20) {
  if (!methods::is(x, "msea")) {
    stop("MSEA result should be msea object.")
  }
  folds <- as.numeric(as.character(x$Expected))
  counts <- as.numeric(as.character(x$Hit))
  names(counts) <- as.character(x$Metaboliteset.name)
  pvals <- as.numeric(as.character(x$p.val))

  # due to space limitation, plot top 50 if more than 50 were given
  title <- "Metabolite Sets Enrichment Overview";
  if (length(folds) > show.limit) {
    folds <- folds[1:show.limit]
    pvals <- pvals[1:show.limit]
    counts <- counts[1:show.limit]
    title <- paste("Enrichment Overview (top ", show.limit, ")")
  }

  op <- graphics::par(mar = c(5, 20, 4, 6), oma = c(0, 0, 0, 4))

  if (col == "cm.colors") {
    col <- grDevices::cm.colors(length(pvals))
  } else if (col == "heat.colors") {
    col <- rev(grDevices::heat.colors(length(pvals)))
  }
  graphics::barplot(rev(counts), horiz = TRUE, col = col,
                    xlab = "Count", las = 1, cex.name=0.75,
                    space = c(0.5, 0.5), main = title)


  minP <- min(pvals)
  maxP <- max(pvals)
  medP <- (minP + maxP) / 2

  axs.args <- list(at = c(minP, medP, maxP),
                   labels = format(c(maxP, medP, minP),
                                   scientific = TRUE, digit = 1), tick = FALSE)
  image.plot(legend.only = TRUE, zlim = c(minP, maxP), col = col,
             axis.args = axs.args, legend.shrink = 0.4, legend.lab = "P-value")
  graphics::par(op)

}


#' plot count-sized dot on (x, y) = (metabolite-sets, pvalue)
#'
#' @param x A msea object
#' @param show.limit the number of metabolite-sets to plot
#' @return plot
#' @examples
#' data(mset_SMPDB_Metabolic_format_HMDB)
#' data(msea.example)
#' res <- msea(mset_SMPDB_Metabolic_format_HMDB, msea.example)
#' dotplot(res)
##' @export
dotplot <- function(x, show.limit = 20) {
  msea.limit <- x[1:show.limit, ]
  indices <- seq(1,show.limit)

  ggplot2::ggplot(msea.limit, ggplot2::aes(x = msea.limit$Expected,
                                    y = stats::reorder(
                                      msea.limit$Metaboliteset.name, -indices))) +
    ggplot2::geom_point(ggplot2::aes(colour =
                                       as.numeric(as.character(msea.limit$p.value)),
                                     size = as.numeric(as.character(msea.limit$Hit))
                                     )) +
    ggplot2::labs(colour = "P-value", size = "Hit [count]") +
    ggplot2::xlab("Expected") +
    ggplot2::ylab("Metabolite sets")
}

write.network <- function(mset, shared.metabolite = 3) {
  
  ### This snippet is cleaner than the follwing non-commented code, but this is slower than it.
  # ids <- map_chr(mset, 1)
  # names(mset) <- ids
  # 
  # # Create mset ID combinations
  # cases <- cross2(ids, ids, .filter = `>=`) %>%
  #   map(set_names, c("from", "to"))
  # 
  # indices <- cases %>%
  #   map(~ intersect(mset[[.$from]][[3]],
  #                   mset[[.$to]][[3]])) %>%
  #   map_int(length) %>%
  #   { . >= shared.metabolite }
  # 
  # edges <- dplyr::bind_rows(cases[indices])
  
  from <- c()
  to <- c()
  shared <- c()
  for (i in seq(1, length(mset) - 1)) {
    fromCpds <- mset[[i]][[3]]
    fromId <- mset[[i]][[1]]
    for (j in seq(i+1, length(mset))) {
      toCpds <- mset[[j]][[3]]
      sharedCpds <- intersect(fromCpds, toCpds)
      if (length(sharedCpds) >= shared.metabolite) {
        from <- c(from, fromId)
        toId <- mset[[j]][[1]]
        to <- c(to, toId)
        #print(paste(sharedCpds, collapse=' '))
        shared <- c(shared, paste(sort(sharedCpds), collapse=' '))
      }
    }
  }
  edges <- data.frame(from = from, to = to, shared = shared)
  #write.csv(edges, file = paste(deparse(substitute(mset)), "_edges_share", shared.metabolite, ".csv", sep = ""), row.names = FALSE)
}

#' plot msea result with network
#' 
#' @importFrom magrittr %>%
#' @importFrom grDevices colorRamp rgb
#' @importFrom utils read.csv write.csv
#' @keywords internal
#' @export
#' 
#' @param x A msea result
#' @param mset A list of metabolite-sets
#' @param shared.metabolite The number of shared metabolites to connect the metabolite-set nodes with edges
#' @param show.limit The number of metabolite-sets to plot
#' @examples 
#' data(kusano)
#' data(mset_SMPDB_format_KEGG)
#' res <- msea(mset_SMPDB_format_KEGG, kusano)
#' netplot(res, mset_SMPDB_format_KEGG, shared.metabolite = 20)

netplot <- function(x, mset, shared.metabolite = 3, show.limit = 20, cyexport = FALSE) {
  msea <- x[1:show.limit, ]
  pathwayIds <- msea$pathway.ID
  pvals <- as.numeric(as.character(msea$p.value))
  pvalmax <- max(pvals)
  cols <- colorRamp(c("red", "gray"))(pvals/pvalmax)
  
  torgb <- function(y){
    y <- as.integer(y)
    return(rgb(y[1], y[2], y[3], maxColorValue = 255))
  }
  
  nodecols <- apply(cols, 1, torgb)
  
  msea <- msea %>% 
    dplyr::rename(id = "pathway.ID", label = "Metaboliteset.name", value = "Hit") %>% 
    dplyr::mutate(color=nodecols)
  htmltables <- apply(msea, 1, knitr::kable, format = "html")
  msea$title <- htmltables
  
  edges <- write.network(mset, shared.metabolite)
  edges <- edges %>% 
    dplyr::filter_(~ from %in% pathwayIds) %>% dplyr::filter_(~ to %in% pathwayIds)
  
  if (is.character(cyexport)) {
    msea <- subset(msea, select = -c(title))
    write.table(msea, file = paste(cyexport, "nodes.tsv", sep = "_"), row.names = FALSE, quote = FALSE, sep = '\t')
    write.table(edges, file = paste(cyexport, "edges.tsv", sep = "_"), row.names = FALSE, quote = FALSE, sep = '\t')
  } else {
    visNetwork::visNetwork(msea, edges)
  }
  
}


## image.plot
##
## Plot strip of color key by figure side
## Adapted from the image.plot in fields package to correct label
## so that small p value is bigger, located in top of the color key
image.plot <- function(..., add = FALSE, nlevel = 64,
                       horizontal = FALSE, legend.shrink = 0.9, legend.width = 1.2,
                       legend.mar = ifelse(horizontal, 3.1, 5.1), legend.lab = NULL,
                       graphics.reset = FALSE, bigplot = NULL, smallplot = NULL,
                       legend.only = FALSE, col = fields::tim.colors(nlevel), lab.breaks = NULL,
                       axis.args = NULL, legend.args = NULL, midpoint = FALSE) {

  old.par <- graphics::par(no.readonly = TRUE)
  #  figure out zlim from passed arguments
  info <- image.plot.info(...)
  if (add) {
    big.plot <- old.par$plt
  }
  if (legend.only) {
    graphics.reset <- TRUE
  }
  if (is.null(legend.mar)) {
    legend.mar <- ifelse(horizontal, 3.1, 5.1)
  }
  #
  # figure out how to divide up the plotting real estate.
  #
  temp <- image.plot.plt(add = add, legend.shrink = legend.shrink,
                         legend.width = legend.width, legend.mar = legend.mar,
                         horizontal = horizontal, bigplot = bigplot, smallplot = smallplot)
  #
  # bigplot are plotting region coordinates for image
  # smallplot are plotting coordinates for legend
  smallplot <- temp$smallplot
  bigplot <- temp$bigplot
  #
  # draw the image in bigplot, just call the R base function
  # or poly.image for polygonal cells note logical switch
  # for poly.grid parsed out of call from image.plot.info
  if (!legend.only) {
    if (!add) {
      graphics::par(plt = bigplot)
    }
    if (!info$poly.grid) {
      graphics::image(..., add = add, col = col)
    }
    else {
      fields::poly.image(..., add = add, col = col, midpoint = midpoint)
    }
    big.par <- graphics::par(no.readonly = TRUE)
  }
  ##
  ## check dimensions of smallplot
  if ((smallplot[2] < smallplot[1]) | (smallplot[4] < smallplot[3])) {
    graphics::par(old.par)
    stop("plot region too small to add legend\n")
  }
  # Following code draws the legend using the image function
  # and a one column image.
  # calculate locations for colors on legend strip
  ix <- 1
  minz <- info$zlim[1]
  maxz <- info$zlim[2]
  binwidth <- (maxz - minz)/nlevel
  midpoints <- seq(minz + binwidth/2, maxz - binwidth/2, by = binwidth)
  iy <- midpoints
  iz <- matrix(iy, nrow = 1, ncol = length(iy))
  # extract the breaks from the ... arguments
  # note the breaks delineate intervals of common color
  breaks <- list(...)$breaks
  # draw either horizontal or vertical legends.
  # using either suggested breaks or not -- a total of four cases.
  #
  # next par call sets up a new plotting region just for the legend strip
  # at the smallplot coordinates
  graphics::par(new = TRUE, pty = "m", plt = smallplot, err = -1)
  # create the argument list to draw the axis
  #  this avoids 4 separate calls to axis and allows passing extra
  # arguments.
  # then add axis with specified lab.breaks at specified breaks
  if (!is.null(breaks) & !is.null(lab.breaks)) {
    # axis with labels at break points
    axis.args <- c(list(side = ifelse(horizontal, 1, 4),
                        mgp = c(3, 1, 0), las = ifelse(horizontal, 0, 2),
                        at = breaks, labels = lab.breaks), axis.args)
  }
  else {
    # If lab.breaks is not specified, with or without breaks, pretty
    # tick mark locations and labels are computed internally,
    # or as specified in axis.args at the function call
    axis.args <- c(list(side = ifelse(horizontal, 1, 4),
                        mgp = c(3, 1, 0), las = ifelse(horizontal, 0, 2)),
                   axis.args)
  }
  #
  # draw color scales the four cases are horizontal/vertical breaks/no breaks
  # add a label if this is passed.
  if (!horizontal) {
    if (is.null(breaks)) {
      graphics::image(ix, iy, iz, xaxt = "n", yaxt = "n", xlab = "",
            ylab = "", col = col)
    }
    else {
      graphics::image(ix, iy, iz, xaxt = "n", yaxt = "n", xlab = "",
            ylab = "", col = col, breaks = breaks)
    }
  }
  else {
    if (is.null(breaks)) {
      graphics::image(iy, ix, t(iz), xaxt = "n", yaxt = "n", xlab = "",
            ylab = "", col = col)
    }
    else {
      graphics::image(iy, ix, t(iz), xaxt = "n", yaxt = "n", xlab = "",
            ylab = "", col = col, breaks = breaks)
    }
  }

  #
  # now add the axis to the legend strip.
  # notice how all the information is in the list axis.args
  #
  do.call("axis", axis.args)

  # add a box around legend strip
  graphics::box()

  #
  # add a label to the axis if information has been  supplied
  # using the mtext function. The arguments to mtext are
  # passed as a list like the drill for axis (see above)
  #
  if (!is.null(legend.lab)) {
    legend.args <- list(text = legend.lab, side = ifelse(horizontal,
                                                         1, 3), line = 1)
  }
  #
  # add the label using mtext function
  if (!is.null(legend.args)) {
    do.call(graphics::mtext, legend.args)
  }
  #
  #
  # clean up graphics device settings
  # reset to larger plot region with right user coordinates.
  mfg.save <- graphics::par()$mfg
  if (graphics.reset | add) {
    graphics::par(old.par)
    graphics::par(mfg = mfg.save, new = FALSE)
    invisible()
  }
  else {
    graphics::par(big.par)
    graphics::par(plt = big.par$plt, xpd = FALSE)
    graphics::par(mfg = mfg.save, new = FALSE)
    invisible()
  }
}

## image.plot.info
"image.plot.info" <- function(...) {
  temp <- list(...)
  #
  xlim <- NA
  ylim <- NA
  zlim <- NA
  poly.grid <- FALSE
  #
  # go through various cases of what these can be
  #
  ##### x,y,z list is first argument
  if (is.list(temp[[1]])) {
    xlim <- range(temp[[1]]$x, na.rm = TRUE)
    ylim <- range(temp[[1]]$y, na.rm = TRUE)
    zlim <- range(temp[[1]]$z, na.rm = TRUE)
    if (is.matrix(temp[[1]]$x) & is.matrix(temp[[1]]$y) &
        is.matrix(temp[[1]]$z)) {
      poly.grid <- TRUE
    }
  }
  ##### check for polygrid first three arguments should be matrices
  #####
  if (length(temp) >= 3) {
    if (is.matrix(temp[[1]]) & is.matrix(temp[[2]]) & is.matrix(temp[[3]])) {
      poly.grid <- TRUE
    }
  }
  #####  z is passed without an  x and y  (and not a poly.grid!)
  #####
  if (is.matrix(temp[[1]]) & !poly.grid) {
    xlim <- c(0, 1)
    ylim <- c(0, 1)
    zlim <- range(temp[[1]], na.rm = TRUE)
  }
  ##### if x,y,z have all been passed find their ranges.
  ##### holds if poly.grid or not
  #####
  if (length(temp) >= 3) {
    if (is.matrix(temp[[3]])) {
      xlim <- range(temp[[1]], na.rm = TRUE)
      ylim <- range(temp[[2]], na.rm = TRUE)
      zlim <- range(temp[[3]], na.rm = TRUE)
    }
  }
  #### parse x,y,z if they are  named arguments
  # determine if  this is polygon grid (x and y are matrices)
  if (is.matrix(temp$x) & is.matrix(temp$y) & is.matrix(temp$z)) {
    poly.grid <- TRUE
  }
  xthere <- match("x", names(temp))
  ythere <- match("y", names(temp))
  zthere <- match("z", names(temp))
  if (!is.na(zthere))
    zlim <- range(temp$z, na.rm = TRUE)
  if (!is.na(xthere))
    xlim <- range(temp$x, na.rm = TRUE)
  if (!is.na(ythere))
    ylim <- range(temp$y, na.rm = TRUE)
  # overwrite zlims with passed values
  if (!is.null(temp$zlim))
    zlim <- temp$zlim
  if (!is.null(temp$xlim))
    xlim <- temp$xlim
  if (!is.null(temp$ylim))
    ylim <- temp$ylim
  list(xlim = xlim, ylim = ylim, zlim = zlim, poly.grid = poly.grid)
}


## image.plot.plt
## Copyright 2004-2007, Institute for Mathematics Applied Geosciences
## University Corporation for Atmospheric Research
## Licensed under the GPL -- www.gpl.org/licenses/gpl.html
image.plot.plt <- function(x, add = FALSE, legend.shrink = 0.9,
                           legend.width = 1, horizontal = FALSE, legend.mar = NULL,
                           bigplot = NULL, smallplot = NULL, ...) {
  old.par <- graphics::par(no.readonly = TRUE)
  if (is.null(smallplot))
    stick <- TRUE
  else stick <- FALSE
  if (is.null(legend.mar)) {
    legend.mar <- ifelse(horizontal, 3.1, 5.1)
  }
  # compute how big a text character is
  char.size <- ifelse(horizontal, graphics::par()$cin[2]/graphics::par()$din[2],
                      graphics::par()$cin[1]/graphics::par()$din[1])
  # This is how much space to work with based on setting the margins in the
  # high level par command to leave between strip and big plot
  offset <- char.size * ifelse(horizontal, graphics::par()$mar[1], graphics::par()$mar[4])
  # this is the width of the legned strip itself.
  legend.width <- char.size * legend.width
  # this is room for legend axis labels
  legend.mar <- legend.mar * char.size
  # smallplot is the plotting region for the legend.
  if (is.null(smallplot)) {
    smallplot <- old.par$plt
    if (horizontal) {
      smallplot[3] <- legend.mar
      smallplot[4] <- legend.width + smallplot[3]
      pr <- (smallplot[2] - smallplot[1]) * ((1 - legend.shrink)/2)
      smallplot[1] <- smallplot[1] + pr
      smallplot[2] <- smallplot[2] - pr
    }
    else {
      smallplot[2] <- 1 - legend.mar
      smallplot[1] <- smallplot[2] - legend.width
      pr <- (smallplot[4] - smallplot[3]) * ((1 - legend.shrink)/2)
      smallplot[4] <- smallplot[4] - pr
      smallplot[3] <- smallplot[3] + pr
    }
  }
  if (is.null(bigplot)) {
    bigplot <- old.par$plt
    if (!horizontal) {
      bigplot[2] <- min(bigplot[2], smallplot[1] - offset)
    }
    else {
      bottom.space <- old.par$mar[1] * char.size
      bigplot[3] <- smallplot[4] + offset
    }
  }
  if (stick & (!horizontal)) {
    dp <- smallplot[2] - smallplot[1]
    smallplot[1] <- min(bigplot[2] + offset, smallplot[1])
    smallplot[2] <- smallplot[1] + dp
  }
  return(list(smallplot = smallplot, bigplot = bigplot))
}

