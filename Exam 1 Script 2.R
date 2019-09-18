#Script 2 - Working with data sets
load("~/Desktop/R class/R scripts/Test-scripts/test1_data.Rdata")
nrow(d)
ncol(d)
typeof(d$transect.id)
str(d)
as.factor(d$tow)
as.integer(d$haul)
d$sw.density=NULL

