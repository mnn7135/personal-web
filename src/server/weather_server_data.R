library(shiny)
library(jsonlite)
library(lubridate)

server <- {
  # This class defines all constants and values to be used by weatherServer
  # related functions.
  # Data Positions
  time_pos <- 1
  pressure_pos <- 5
  temp_pos <- 6
  humidity_pos <- 7
  wind_dir_pos <- 9
  wind_speed_pos <- 11
  wind_gust_pos <- 12
  hourly_rain_pos <- 14
  event_rain_pos <- 15
  daily_rain_pos <- 16
  solar_rad_pos <- 20
  uv_index_pos <- 21
  feels_pos <- 22
  dewpoint_pos <- 23
  # Text Descriptions
  weather_sunny <- "Sunny"
  weather_clear <- "Clear"
  weather_cloudy <- "Cloudy"
  weather_windy <- "Windy"
  weather_rain <- "Rain"
  # Font Awesome Icons
  icon_sunny <- "sun"
  icon_clear <- "moon"
  icon_cloudy_sun <- "cloud-sun"
  icon_cloudy_moon <- "cloud-moon"
  icon_windy <- "wind"
  icon_rain <- "cloud-sun-rain" # REMOVE THIS AFTER UPGRADES
  icon_rain_sun <- "cloud-sun-rain"
  icon_rain_moon <- "cloud-moon-rain"
  # Icon Sizes
  size_tooltip <- "fa-1x"
  size_predict <- "fa-6x"
  size_current <- "fa-10x"
  # Prediction Factors
  prediction_factor_tonight <- 0.25
  prediction_factor_tomorrow <- 0.20
  # Indexes for displaying or predicting weather.
  now_index <- 288 # Most recent data
  six_hour_index <-
    216 # Furthest point back for displaying 6-hour changes.
  last_day_index <-
    4 # Furthest point back for displaying 24-hour changes.
  if (!exists("has_run")) {
    pws_data <- fetch_device_data("E8:DB:84:E4:03:97")$content
    date_time <- pws_data[[1]][now_index]
    # Get the current sunrise and sunset information for today.
    sun_data_json <- httr::GET("https://api.sunrise-sunset.org/json?lat=42.982563&lng=-77.408882&date=today&formatted=0")
    sun_data = fromJSON(rawToChar(sun_data_json$content))[[1]]
    has_run <- TRUE
  }
  # Check to make sure data was retrieved.
  if (!is.null(pws_data) && !is.null(sun_data)) {
    # Weather Data
    out_pressure <- pws_data[[pressure_pos]][now_index] * 33.8639 # inHg to mbar
    out_temp <- pws_data[[temp_pos]][now_index]
    out_humidity <- pws_data[[humidity_pos]][now_index]
    wind_dir <- pws_data[[wind_dir_pos]][now_index]
    wind_speed <- pws_data[[wind_speed_pos]][now_index]
    wind_gust <- pws_data[[wind_gust_pos]][now_index]
    hourly_rain <- pws_data[[hourly_rain_pos]][now_index]
    event_rain <- pws_data[[event_rain_pos]][now_index]
    daily_rain <- pws_data[[daily_rain_pos]][now_index]
    solar_rad <- pws_data[[solar_rad_pos]][now_index]
    uv_index <- pws_data[[uv_index_pos]][now_index]
    out_feels <- pws_data[[feels_pos]][now_index]
    out_dewpoint <- pws_data[[dewpoint_pos]][now_index]
    windchill <- 35.74 + (0.6215 * out_temp)
    - (35.75 * wind_speed ^ 0.16) + (0.4275 * out_temp * wind_speed ^ 0.16)
    
    # Times for use in determining icons/prediction formulas.
    current_time_unformatted <-
      as.POSIXlt(pws_data[[time_pos]][now_index])
    current_time <-
      as.POSIXlt(pws_data[[time_pos]][now_index], format = "%H:%M")
    morning_time <- as.POSIXlt(with_tz(ymd_hms(sun_data$sunrise), 
                                       tz = "America/New_York"), format = "%H:%M")
    noon_time <- as.POSIXlt(with_tz(ymd_hms(sun_data$solar_noon), 
                                    tz = "America/New_York"), format = "%H:%M")
    evening_time <- as.POSIXlt(with_tz(ymd_hms(sun_data$sunset), 
                                       tz = "America/New_York"), format = "%H:%M")
  }
}
