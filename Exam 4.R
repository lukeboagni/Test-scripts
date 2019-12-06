#load in Libraries
library(tidyverse)
library(ggplot2)
library(ggmap)
library(osmdata)

#Section 1
load("test_4/sec_stad.Rdata")

##bar graph

bar = ggplot(data = sec_stad, aes(x= Name, y=Capacity)) + 
  geom_col() + theme_classic() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
bar

##flipped bar graph

flip=ggplot(data = sec_stad, aes(x= Name, y=Capacity)) + 
  geom_col() + coord_flip() + theme_classic()
flip

#Section 2

load(file="test_4/team_statistics.Rdata")
sun.yards <- subset(ts, Conference=="Sun Belt Conference",
                  select=c(Team,Pass.Yard, Rush.Yard)) 

gg.yards=ggplot(sun.yards, aes(x=Rush.Yard, y=Pass.Yard, color=Team)) +
  geom_point() + xlab("Rushing yards") + ylab("Passing yards")
gg.yards

#Section 3

big.rush = subset(ts, Conference=="Big Ten Conference",
               select=c(Team, Rush.Yard))

big.box =ggplot(big.rush, aes(x= Team, y =Rush.Yard, fill= Team)) +
  geom_boxplot(fill = "yellow", color = "yellow") + theme_classic() +
  theme(panel.background = element_rect(fill = "darkblue"),
        axis.text.x = element_text(angle = 90, hjust = 1)) 
big.box 

##Minnesota has the most rushing yards on average

#Section 4
load("test_4/football_stats.Rdata")
stats = football.stats;rm(football.stats)

##subset and log
sec.heat=stats[stats$Conference=="Southeastern Conference",] 
sec.heat$log.stat = NA
sec.heat$log.stat = log10(sun.heat$stat)

##heatmap
sec.heat.map = ggplot(sec.heat, aes(x= variable, y = Team, fill = stat)) +
  geom_tile() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
sec.heat.map

##log heatmap
sec.heat.map2 = ggplot(sec.heat, aes(x= variable, y = Team, fill = log.stat)) +
  geom_tile() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
sec.heat.map2

#Section 5

##toner map 1
bbox = c(left = min(sec_stad$lng), bottom = min(sec_stad$lat), 
         right = max(sec_stad$lng+2), top = max(sec_stad$lat+1))
toner1 = get_stamenmap(bbox = bbox,
         zoom = 5, maptype = 'toner') %>% ggmap()
toner1
ggsave("toner1.png")

##toner map 2
toner2 = get_stamenmap(bbox = bbox,
  zoom = 5, maptype = 'toner') %>% ggmap() +  
  geom_point(data = sec_stad, aes(x = lng, y = lat), color = "red")
toner2
ggsave("toner2.png")

##toner map 3
toner3 =  get_stamenmap(bbox = bbox,
  zoom = 5, maptype = 'toner') %>% ggmap() +  
  geom_point(data = sec_stad, aes(x = lng, y = lat, color = sec_stad$Capacity, size = sec_stad$Capacity))
toner3
ggsave("toner3.png")

#Section 6
##largest capacity
max_cap = order(sec_stad$Capacity,decreasing = T)
max_cap
sec_stad[26,1]
sec_stad[26,2]

##The stadium in Knoxville,TN has the largest capacity

##mean and SD
mean.and.sd = sec_stad %>%  group_by(State) %>% summarize (mean.cap = mean(Capacity),mean.sd=sd(Capacity))
mean.and.sd





