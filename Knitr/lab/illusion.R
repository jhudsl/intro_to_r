## ----'install instructions', eval = FALSE--------------------------------
## ## Run manually if you need to install these packages
## install.packages(c("plyr", "rmarkdown", "devtools"))

## ----'cafe wall'---------------------------------------------------------
library("grid")
rs <- expand.grid(x = seq(0, 1, 1/10), y = seq(0, 1, 1/10))
grid.rect(rs$x, rs$y, 1/10/2, 1/10/2, gp = gpar(fill = "black", col = NA))
grid.rect(rs$x + 1/10/4, rs$y + 1/10/2, 1/10/2, 1/10/2, gp = gpar(fill = "black", 
    col = NA))
ls <- expand.grid(x = 0:1, y = seq(0, 1, 1/20) - 1/20/2)
grid.polyline(ls$x, ls$y, id = gl(nrow(ls)/2, 2), gp = gpar(col = "grey50", 
    lwd = 1))

## ----'un-named illusion'-------------------------------------------------
nx <- 6; ny <- 6; lwd <- 10; cr <- 1/100
grid.newpage()
grid.rect(0.5, 0.5, 1, 1, gp = gpar(fill = "black"))
ls <- expand.grid(x = 0:1, y = seq(0, 1, 1/nx/2) - 1/nx/2/2)
grid.polyline(ls$x, ls$y, id = gl(nrow(ls)/2, 2), gp = gpar(col = "grey", lwd = lwd))
ls <- expand.grid(y = 0:1, x = seq(0, 1, 1/ny/2) - 1/ny/2/2)
grid.polyline(ls$x, ls$y, id = gl(nrow(ls)/2, 2), gp = gpar(col = "grey", lwd = lwd))
ls <- expand.grid(x = seq(0, 1, 1/nx/2) - 1/nx/2/2, y = seq(0, 1, 1/ny/2) - 1/ny/2/2)
grid.circle(ls$x, ls$y, r= cr, gp = gpar(col = NA, fill = "white"))

## ----'ouchi'-------------------------------------------------------------
grid.newpage()
nx <- 10
ny <- 30
rs <- expand.grid(x = seq(0, 1, 1/nx/2), y = seq(0, 1, 1/ny/2))
grid.rect(rs$x, rs$y, 1/nx/2, 1/ny/2, gp = gpar(col = NA, fill = c("black", 
    "white")))
rs <- expand.grid(x = seq(0.25, 0.75, 1/nx/2), y = seq(0.25, 0.75, 1/ny/2))
grid.rect(rs$y, rs$x, 1/ny/2, 1/nx/2, gp = gpar(col = NA, fill = c("black", 
    "white")))

## ----'fraser'------------------------------------------------------------
library("plyr")
grid.newpage()
n <- 10
ny <- 8
L <- 0.01
c <- seq(0, 1, length = n)
d <- 1.2 * diff(c)[1]/2
col <- c("black", "white")
x <- c(c - d, c, c + d, c)
y <- rep(c(0, -d, 0, d), each = n)
w <- c(c - d, c - d + L, c + d, c + d - L)
z <- c(0, L, 0, -L)
ys <- seq(0, 1, length = ny)
grid.rect(gp = gpar(fill = gray(0.5), col = NA))
plyr::l_ply(1:ny, function(i) {
    n
    if (i%%2 == 0) {
        co <- rev(col)
        z <- -z
    } else {
        co <- col
    }
    grid.polygon(x, y + ys[i], id = rep(1:n, 4), gp = gpar(fill = co, col = NA))
    grid.polygon(w, rep(z, each = n) + ys[i], id = rep(1:n, 4), gp = gpar(fill = rev(co), 
        col = NA))
})

## ----'fraser-wilcox'-----------------------------------------------------
grid.newpage()
No <- 3
wo <- 1/3/2
po <- seq(0, 1, by = wo)[(1:No) * 2]
Nc <- 8
tc <- seq(pi * 11/12, pi * 1/12, len = Nc)
px <- c(outer(wo * cos(tc), po, `+`))
wc <- rep(sin(tc), No)
ag <- rep(1:No, each = Nc)
dc <- 21
th <- seq(0, 2 * pi, len = dc)
grid.rect(gp = gpar(col = NA, fill = "#D2D200"))
for (y0 in seq(0, 1, len = 10)) {
    for (i in seq_along(px)) {
        th <- seq(pi/2, pi/2 + 2 * pi, len = 21)
        if (ag[i]%%2 == 0) 
            th <- rev(th)
        x <- px[i] + 0.5 * 0.04 * cos(th) * wc[i]
        y <- y0 + 0.04 * sin(th)
        grid.polygon(x, y, gp = gpar(fill = "#3278FE"))
        grid.polyline(x[1:((dc + 1)/2)], y[1:((dc + 1)/2)], gp = gpar(lineend = "butt", 
            lwd = 3, col = gray(0)))
        grid.polyline(x[-(1:((dc - 1)/2))], y[-(1:((dc - 1)/2))], gp = gpar(lineend = "butt", 
            lwd = 3, col = gray(1)))
    }
}

## ----'parallel'----------------------------------------------------------
x = 1:100
y = 1/log10(x)
y2 = y + 0.2
plot(x, y, type = "l", ylim = c(0, 1.5))
lines(x, y2)

## ----'snake'-------------------------------------------------------------
nt <- 41; nr <- 15; br <- 0.8
col1 <- c("black", "white")
col2 <- c("aquamarine4", "gold2")

f <- function(x0, y0) {
  r <- embed(br^(0:nr), 2)
  t <- embed(seq(0, 2*pi, length=nt), 2)
  i <- as.matrix(expand.grid(1:nrow(r), 1:nrow(t)))
  ci <- 1 + (i[,2]%%2 + i[,1]%%2) %% 2

  p <- t(apply(i, 1, function(x) c(r[x[1], ], t[x[2], ])))
  x <- c(p[,1]*cos(p[,3]), p[,1]*cos(p[,4]), p[,2]*cos(p[,4]), p[,2]*cos(p[,3]))
  y <- c(p[,1]*sin(p[,3]), p[,1]*sin(p[,4]), p[,2]*sin(p[,4]), p[,2]*sin(p[,3]))
  grid.polygon(x0+x/2, y0+y/2, id = rep.int(1:nrow(p), 4),
               gp = gpar(fill = col1[ci], col=NA), default.units="native")

  p <- expand.grid(1:nrow(r), sign((abs(x0-y0)==1)-0.5)*seq(0, 2*pi, length=41)[-1])
  p <- cbind(p[,2], rowMeans(r)[p[,1]], (r[,2]-r[,1])[p[,1]]/2)
  t <- seq(0, 2*pi, length=20)[-1]
  x <- c(apply(p, 1, function(a) a[2]*cos(a[1])+a[3]*(cos(a[1])*cos(t)-0.5*sin(a[1])*sin(t))))
  y <- c(apply(p, 1, function(a) a[2]*sin(a[1])+a[3]*(sin(a[1])*cos(t)+0.5*cos(a[1])*sin(t))))
  col <- if(abs(x0-y0)==1) {col2} else {rev(col2)}
  grid.polygon(x0+x/2, y0+y/2, id = rep(1:nrow(p), each=length(t)),
               gp = gpar(fill = col[ci], col=NA), default.units="native")

}

grid.newpage()
pushViewport(viewport(xscale = c(0, 3), yscale = c(0, 3)))
for (x0 in 0.5+0:2) for (y0 in 0.5+0:2) f(x0, y0)
for (x0 in 1:2) for (y0 in 1:2) f(x0, y0)

