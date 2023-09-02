library(shiny)

source("src/server/weather_server_helper.R", local=TRUE)
source("src/server/weather_server_data.R", local=TRUE)

server <- {
  
  # Current weather icon displayed.
  icon_name <- ""
  icon_desc <- ""
  
  # Predict the weather based on a specific index to compare to as well as
  # a confidence interval.
  predict_weather_tonight <- (function(index, confidence) {
    
    icon_temp <- ""
    desc_temp <- ""
    hour_count <- index/12
    
    if((pws_data[[11]][NOW_INDEX]
        - pws_data[[11]][index])/hour_count
       + pws_data[[11]][NOW_INDEX] >= 20/confidence) {
      
      icon_temp <- ICON_WINDY
      desc_temp <- WEATHER_WINDY
      
    } else if((pws_data[[5]][NOW_INDEX]
               - pws_data[[5]][index])/hour_count 
              >= PREDICTION_FACTOR_TONIGHT/confidence) {
      
      icon_temp <- ICON_CLOUDY_MOON
      desc_temp <- WEATHER_CLOUDY
      
    } else if((pws_data[[5]][NOW_INDEX]
               - pws_data[[5]][index])/hour_count
              <= -PREDICTION_FACTOR_TONIGHT/confidence) {
      
      if((pws_data[[7]][NOW_INDEX]
          - pws_data[[7]][index])/hour_count >= 20
         || pws_data[[7]][NOW_INDEX] >= 85) {
        
        icon_temp <- ICON_RAIN
        desc_temp <- WEATHER_RAIN
        
      } else {
        
        icon_temp <- ICON_CLOUDY_MOON
        desc_temp <- WEATHER_CLOUDY
        
      }
    } else {
      
      if(icon_name == "moon") {
        
        icon_temp <- ICON_SUNNY
        desc_temp <- WEATHER_SUNNY
        
      } else {
        
        icon_temp <- icon_name
        desc_temp <- icon_desc
        
      }
      
    }
    
    temp_trend <- 0.66
    
    if(CURRENT_TIME < NOON_TIME) {
      
      # Likely to warm up a lot in the next 6 hours.
      temp_trend <- 0.66
      
    } else {
      
      # Likely to cool down a lot in the next 6 hours.
      temp_trend <- -0.66
      
    }
    
    output$weather_icon_later <- renderText(as.character(icon(icon_temp, 
                                                                SIZE_PREDICT)))
    output$weather_desc_later <- renderText(desc_temp)
      
    temp_out <- renderText(sprintf("Low %.0f\u00B0 F", (
      pws_data[[6]][NOW_INDEX] - pws_data[[6]][index])/PREDICTION_FACTOR_TONIGHT
      * temp_trend
      + pws_data[[6]][NOW_INDEX]))
      
    output$out_high_later <- temp_out
      
  })
  
  predict_weather_tomorrow <- (function(index, confidence) {
    
    icon_temp <- ""
    desc_temp <- ""
    hour_count <- index/12
    
    if((pws_data[[11]][NOW_INDEX]
        - pws_data[[11]][index])/hour_count
       + pws_data[[11]][NOW_INDEX] >= 20/confidence) {
      
      icon_temp <- ICON_WINDY
      desc_temp <- WEATHER_WINDY
      
    } else if((pws_data[[5]][NOW_INDEX]
               - pws_data[[5]][index])/hour_count 
              >= PREDICTION_FACTOR_TOMORROW/confidence) {

        
      icon_temp <- ICON_CLOUDY_SUN
      desc_temp <- WEATHER_CLOUDY
      
    } else if((pws_data[[5]][NOW_INDEX]
               - pws_data[[5]][index])/hour_count
              <= -PREDICTION_FACTOR_TOMORROW/confidence) {
      
      if((pws_data[[7]][NOW_INDEX]
          - pws_data[[7]][index])/hour_count >= 20
         || pws_data[[7]][NOW_INDEX] >= 85) {
        
        icon_temp <- ICON_RAIN
        desc_temp <- WEATHER_RAIN
        
      } else {
        
        icon_temp <- ICON_CLOUDY_SUN
        desc_temp <- WEATHER_CLOUDY
        
      }
    } else {
       
      if(icon_name == "cloud-moon") {
        
        icon_temp <- ICON_CLOUDY_SUN
        desc_temp <- icon_desc
        
      } else {
        
        icon_temp <- icon_name
        desc_temp <- icon_desc
        
      }
      
    }
    
    temp_trend <- 0.33
      
    output$weather_icon_1_day <- renderText(as.character(icon(icon_temp, 
                                                                SIZE_PREDICT)))
    output$weather_desc_1_day <- renderText(desc_temp)
      
    temp_out <- renderText(sprintf("High %.0f\u00B0 F", (
      pws_data[[6]][NOW_INDEX] - pws_data[[6]][index])
      / PREDICTION_FACTOR_TOMORROW 
      * temp_trend
      + pws_data[[6]][NOW_INDEX]))
      
    output$out_high_1_day <- temp_out
    
  })
  
  # Get the current weather conditions.
  get_current_weather <- (function() {
    
    if(hourly_rain > 0) {
      
      icon_name <- ICON_RAIN
      icon_desc <- WEATHER_RAIN
      
    } else if(wind_speed >= 20) {
      
      icon_name <- ICON_WINDY
      icon_desc <- WEATHER_WINDY
      
    } else {
      
      if(MORNING_TIME <= CURRENT_TIME && CURRENT_TIME < EVENING_TIME) {
        
        # Display Daytime Indicators
        if(uv_index > 3) {
          
          icon_name <- ICON_SUNNY
          icon_desc <- WEATHER_SUNNY
          
        } else {
          
          icon_name <- ICON_CLOUDY_SUN
          icon_desc <- WEATHER_CLOUDY
          
        }
        
      } else {
        
        # Display Nighttime Indicators
        if((pws_data[[5]][NOW_INDEX]
            - pws_data[[5]][TOMORROW_INDEX]) <= -0.20) {
          
          icon_name <- ICON_CLOUDY_MOON
          icon_desc <- WEATHER_CLOUDY
          
        } else {
          
          icon_name <- ICON_MOON
          icon_desc <- WEATHER_CLEAR
          
        }
        
      }
      
    }
    
    # Render current weather icons.
    output$weather_icon <- renderText(as.character(icon(icon_name, 
                                                        SIZE_CURRENT)))
    output$weather_tooltip <- renderText(as.character(icon(icon_name,
                                                           SIZE_TOOLTIP)))
    output$weather_desc <- renderText(icon_desc)
    
  })
  
}