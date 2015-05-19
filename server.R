
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  location <- reactive({
    print("enter reactive")
    centre <-geocode(input$postcode)
    print(centre)
    
    stores <- input$retailers
    print(input$retailers)
    info=list(lon=centre$lon,lat=centre$lat,stores=stores)
    
    return(info)
  })
  
  output$leafletMap <- renderLeaflet({
    print("enter map")
   if (is.null(input$postcode)) return()
    print(input$postcode)
    print(location()$lon)
    print(location()$lat)
    locs %>% 
      group_by(Retailer) %>% 
      filter(Retailer %in% location()$stores) %>% 
      leaflet() %>% 
      addTiles(options=tileOptions(opacity=0.5)) %>% 
     # setView(location()centre$lon, location()$lat, zoom = 13) %>% 
      setView(location()$lon, location()$lat, zoom = 13) %>% 
      addCircles( color = ~pal(Retailer),radius=25, popup=~popup,opacity=1) %>% 
      addLegend(pal = pal, values = ~Retailer, opacity=1)

  })

})
