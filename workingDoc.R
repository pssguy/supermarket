## supermarket locations - start with waitrose in UK can buy for 39 pounds at aggdata


library(rvest)
library(dplyr)
library(stringr)
library(readr)
library(leaflet)
library(readxl)

u <-read_html("http://www.waitrose.com/content/waitrose/en/bf_home/bf/806.html")

u %>% 
  html_nodes(".branch-details p")
# London Road <br>
#   
#   
#   Headington <br>
#   
#   
#   
#   Oxford <br>
#   
#   
#   Oxfordshire <br>
#   
#   
#   OX3 7RD <br>
#   
#   
#   01865 750299 <br>
#   

#bit ugly might be able to get postal code from next to last line

add

## http://geolytix.co.uk/blog/tag/waitrose/ has supermarket locations

#so downloaded that

locations <- read_excel("locations.xls")

glimpse(locations)

locations %>% 
  data.frame(.) %>% 
  select(Retailer,longitude=LongWGS84,latitude=LatWGS84) %>% 
 # group_by(Retailer) %>% 
  leaflet() %>% 
  addTiles()



locations %>% 
  data.frame(.) %>% 
  select(Retailer,longitude=LongWGS84,latitude=LatWGS84) %>% 
  group_by(Retailer)

locs <- locations %>% 
  data.frame(.) %>% 
  select(Retailer,longitude=LongWGS84,latitude=LatWGS84, Fascia,tt)

glimpse(locs)

m= leaflet(locs)

aldi <-locs %>% 
  filter(Retailer=="Aldi")

aldi %>% 
  select(lon=longitude,lat=latitude) %>%
  leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers()

unique(locs$Retailer) #15 12-class Set3

locs %>% 
  group_by(Retailer) %>% 
  tally()

# remove Dansk Supermarked    5 Whole Foods    9 Costco   26
exclude <- c("Costco","Dansk Supermarked","Whole Foods")
locs <- locs[!locs$Retailer %in% exclude,]
glimpse(locs)
#pal = colorNumeric('OrRd', df$z)
pal = colorFactor('12-class Set3', locs$Retailer)

#Error in col2rgb(colors, alpha = alpha) : 
#invalid color specification "12-class Set3"
pal = colorFactor(colorRamp(c("#000000", "#FFFFFF"), interpolate="spline"), locs$Retailer)
locs %>% 
 group_by(Retailer) %>% 
  #select(lon=longitude,lat=latitude) %>%
  leaflet() %>% 
  addTiles() %>% 
  addCircles( color = "#ff6",radius=2, popup=~Retailer)

cols <- topo.colors(12, alpha = 1)
# [1] "#4C00FFFF" "#0019FFFF" "#0080FFFF" "#00E5FFFF" "#00FF4DFF" "#1AFF00FF" "#80FF00FF" "#E6FF00FF"
# [9] "#FFFF00FF" "#FFE53BFF" "#FFDB77FF" "#FFE0B3FF"
previewColors(pal(countries2$Rank))
previewColors(pal(locs$Retailer))



pal <- colorFactor("Greens", domain=NULL)
pal(locs$Retailer)
previewColors(pal,locs$Retailer) # this does give range of greens

pal <- colorFactor("RdYlBu", domain=NULL)
pal(locs$Retailer)
previewColors(pal,locs$Retailer)

#invalid color specification "12-class Set3"


pal <- colorFactor(cols, domain=NULL)
pal(locs$Retailer)
previewColors(pal,locs$Retailer) # works but may not be best colors

locs %>% 
  group_by(Retailer) %>% 
  #select(lon=longitude,lat=latitude) %>%
  leaflet() %>% 
  addTiles(options=tileOptions(opacity=0.5)) %>% 
 # addCircleMarkers(color = ~pal(tann))
  addCircles( color = ~pal(Retailer),radius=15, popup=~Retailer,opacity=0.9)# %>% 
  addLegend(colors=colorFactor("Paired", domain=NULL),labels=colorFactor("Paired", domain=NULL))

# the above works - just need to get better 
http://howfarawayis.com/ looks avaailable

#try pal <- colorFactor("Paired", domain=NULL)
@

  
  # reduce to just 12 locations
  pal <- colorFactor("Paired", domain=NULL)
locs %>% 
  group_by(Retailer) %>% 
 
  leaflet() %>% 
  addTiles(options=tileOptions(opacity=0.5)) %>% 
  setView(geo$lon, geo$lat, zoom = 13) %>% 
  addCircles( color = ~pal(Retailer),radius=25, popup=~tt,opacity=1) %>% 
  addLegend(pal = pal, values = ~Retailer, opacity=1)

## add an inital address

library(ggmap)

geo <- geocode("BR3 4DT")
lon      lat
1 -0.0484845 51.40002

# an automatic legend derived from the color palette
df = local({
  n = 300; x = rnorm(n); y = rnorm(n)
  z = sqrt(x^2 + y^2); z[sample(n, 10)] = NA
  data.frame(x, y, z)
})
pal = colorNumeric('OrRd', df$z)
leaflet(df) %>%
  addCircleMarkers(~x, ~y, color = ~pal(z)) %>%
  addLegend(pal = pal, values = ~z)

## look at getting info back from clicked *works on choropleth
## https://github.com/rstudio/leaflet/issues/41 

names(locations)

locations$tt <- sprintf("<table cellpadding='4' style='line-height:1'><tr>
                       <th>%1$s</th></tr>
                     <tr align='left'><td>%2$s</td></tr>
                     <tr align='left'><td>%3$s</td></tr>
                      <tr align='left'><td>%4$s</td></tr>
                     <tr align='left'><td>%5$s</td></tr>
                      <tr align='left'><td>%6$s</td></tr>
                     
                     </table>",
                     locations$Fascia,
                     locations$Add1,
                     locations$Add2,
                     locations$Locality,
                     locations$Town,
                     locations$Postcode)