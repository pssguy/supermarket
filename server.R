

shinyServer(function(input, output) {

  location <- reactive({
   
    centre <-geocode(input$postcode)
 
    
    stores <- input$retailers
  
    info=list(lon=centre$lon,lat=centre$lat,stores=stores)
    
    return(info)
  })
  
  output$leafletMap <- renderLeaflet({
 
   if (is.null(input$postcode)) return()

    locs %>% 
      group_by(Retailer) %>% 
      filter(Retailer %in% location()$stores) %>% 
      leaflet() %>% 
      addTiles(options=tileOptions(opacity=0.5)) %>% 
     
      setView(location()$lon, location()$lat, zoom = 14) %>% 
      addCircles( color = ~pal(Retailer),radius=25, popup=~popup,opacity=1) %>% 
      addLegend(pal = pal, values = ~Retailer, opacity=1)

  })

})
