library(rvest)
library(dplyr)
library(stringr)
library(readr)
library(leaflet)
library(readxl)
library(ggmap)
library(shiny)


## http://geolytix.co.uk/blog/tag/waitrose/ has supermarket locations

#so downloaded that

locations <- read_excel("locations.xls")

# create a popup
locations$popup <- sprintf("<table cellpadding='4' style='line-height:1'><tr>
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

exclude <- c("Costco","Dansk Supermarked","Whole Foods")
#locs <- locs[!locs$Retailer %in% exclude,]

locs <- locations %>% 
  data.frame(.) %>% 
  filter(!Retailer %in% exclude) %>% 
  select(Retailer,longitude=LongWGS84,latitude=LatWGS84, Fascia,popup)

retailerChoice <- sort(unique(locs$Retailer))

pal <- colorFactor("Paired", domain=NULL)