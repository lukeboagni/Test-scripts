#Exam 3 script 
library(dplyr)
library(ggplot2)
library(reshape2)
library(plyr)
library(stringr)
#Section 1
load("test3_data.Rdata")

fields = names(d[,c(1:17)])
d2 = d[,c(fields)]
d3 = arrange(d2, transect.id, desc(dateTime))

#Section 2
dir.create("Exam_3")

#tried to do this problem 2 ways, first with ddply and by subsetting
#ddply would run when outside the loop, but was getting an error when inside
#couldn't get the date breaks to work no matter what I tried

a = ddply(.data = d, .variables = "transect.id", function(x){
  name = unique(x$transect.id)
  pl = ggplot(x,aes(x = dateTime, y = -depth)) + geom_point(color = "darkblue") +
    scale_x_datetime(name = "Time", date_labels ="%H:%M",breaks = "15 min") + geom_smooth() +
    ggtitle(name)

}, .progress = "text")

d.und = d[d$tow == "und",]
d.s = d[d$tow == "s",]
d.m = d[d$tow == "m",]

dp.und = ggplot(d.und,aes(x = dateTime, y = -depth)) + geom_point(color = "darkblue") +
  scale_x_datetime(name = "Time", date_labels ="%H:%M",breaks = "15 min") + geom_smooth()
dp.s = ggplot(d.s,aes(x = dateTime, y = -depth)) + geom_point(color = "darkblue") +
  scale_x_datetime(name = "Time", date_labels ="%H:%M",breaks = "15 min") + geom_smooth()
dp.m = ggplot(d.m,aes(x = dateTime, y = -depth)) + geom_point(color = "darkblue") +
  scale_x_datetime(name = "Time", date_labels ="%H:%M",breaks = "15 min") + geom_smooth()


#Section 3

#function
study.fxn <- function(x){
  
  t <- str_split_fixed(string = x[['transect.id']], pattern = "-", n = 3)
  s <- t[2]
  
  if(str_detect(string = s, pattern = "L")){
    study <- "lagrangian"
    
  } else if(str_detect(string = s, pattern = fixed("Eddy"))){
    
    
  } else if(str_detect(string = s, pattern = "W")) {
    study <- "spatial"
    
  } else if(str_detect(string = s, pattern = "E")) {
    study <- "spatial"
    
  } else if(str_detect(string = s, pattern = "C")) {
    study <- "spatial"
    
  } else if(str_detect(string = s, pattern = "DVM")) {
    study <- "dvm"
    
  } else {}
  
  return(study)
}

#loop
d$study = NA
for(i in 1:nrow(d)){
  d[i,]$study <- study.fxn(x = d[i,])
}

#apply
d$study <- apply(X = d, MARGIN =  1, FUN = study.fxn)

#Section 4
d.spac = d[d$study=="spatial",]
press = ggplot(d.spac, aes(x = region,y = pressure)) + geom_boxplot() + facet_wrap(.~region_fac)
press

#Section 5
d.spac.s = d.spac[d.spac$tow=="s",]
d.spac.m = d.spac[d.spac$tow=="m",]
#tried to subset for both tow groups, but wouldn't work
d.spac.sm = d.spac[d.spac$tow== "m" & "s",]
#not sure why, but sometimes when i create w1 and w2, it leaves out region, which messes up my melt 
w1 <- d.spac.s %>% group_by(region) %>% summarise(mean = mean(temp,na.rm = T), sd = sd(temp,na.rm = T))
w2 <- d.spac.m %>% group_by(region) %>% summarise(mean = mean(temp,na.rm = T), sd = sd(temp,na.rm = T))
w3 <- d.spac.sm %>% group_by(region) %>% summarise(mean = mean(temp,na.rm = T), sd = sd(temp,na.rm = T))

w1$f_deg = NA
w1$K_deg = NA
w2$f_deg = NA
w2$K_deg = NA

for(i in 1:nrow(w1)){
  w1[i,]$f_deg = (w1[i,]$sd + 32)*(5/9)
  w1[i,]$K_deg = (w1[i,]$sd + 273.15)
}

for(i in 1:nrow(w2)){
  w2[i,]$f_deg = (w2[i,]$sd + 32)*(5/9)
  w2[i,]$K_deg = (w2[i,]$sd + 273.15)
}

id.vars = c("region")
m.vars = c("f_deg","K_deg","sd")
melt1 = melt(w1, id.vars=id.vars, measure.vars=m.vars)
melt2 = melt(w2, id.vars=id.vars, measure.vars=m.vars)

#Section 6

bar1 = ggplot(melt1,aes(x = variable, y = value)) + geom_bar(stat = "identity", position = "dodge") + facet_grid(.~region) 
bar2 = ggplot(melt2,aes(x = variable, y = value)) + geom_bar(stat = "identity", position = "dodge") + facet_grid(.~region)

bar.log = ggplot(melt1,aes(x = variable, y = value)) + geom_bar(stat = "identity", position = "dodge") + 
  facet_grid(.~region) + scale_y_continuous(trans = 'log10')
