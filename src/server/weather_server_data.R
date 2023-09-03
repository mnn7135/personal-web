library(shiny)

server <- {
  # This class defines all constants and values to be used by weatherServer
  # related functions.
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
  icon_rain <- "cloud-rain"
  # Icon Sizes
  size_tooltip <- "fa-1x"
  size_predict <- "fa-6x"
  size_current <- "fa-10x"
  # Prediction Factors
  prediction_factor_tonight <- 0.25
  prediction_factor_tomorrow <- 0.20
  # Indexes for displaying or predicting weather.
  now_index <- 288 # Most recent data
  tonight_index <-
    252 # Furthest point back for displaying 6-hour changes.
  tomorrow_index <-
    1 # Furthest point back for displaying 24-hour changes.
  predict_index <-
    4 # Furthest point back for predicting weather with buffer.
  # Handle App level server configurations for fetching data.
  Sys.setenv(AW_API_KEY =
               "9258f994d53042ca9bcbe7f5cc44dfbbfa366e4ca4ac43c19a33268a6e060cb6")
  Sys.setenv(AW_APPLICATION_KEY =
               "78a34a92bffc4cc8962e87525a8a35f843e1d5dda7a94c3f88114283d16389ed")
  Sys.setenv(GITHUB_PAT = "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")
  Sys.setenv(TZ = "America/New_York")
  pws_data <- fetch_device_data("E8:DB:84:E4:03:97")$content
  date_time <- pws_data[[1]][now_index]
  # Times for use in determining icons/prediction formulas.
  current_time <-
    as.POSIXlt(pws_data[[1]][now_index], format = "%H:%M")
  morning_time <- as.POSIXlt("07:00:00", format = "%H:%M") # 7 AM
  noon_time <- as.POSIXlt("12:00:00", format = "%H:%M") # 12 PM
  evening_time <- as.POSIXlt("19:00:00", format = "%H:%M") # 7 PM
  # Check to make sure data was retrieved.
  if (!is.na(date_time)) {
    out_pressure <- pws_data[[5]][now_index] * 33.8639 # inHg to mbar
    out_temp <- pws_data[[6]][now_index]
    out_humidity <- pws_data[[7]][now_index]
    wind_dir <- pws_data[[9]][now_index]
    wind_speed <- pws_data[[11]][now_index]
    wind_gust <- pws_data[[12]][now_index]
    hourly_rain <- pws_data[[14]][now_index]
    event_rain <- pws_data[[15]][now_index]
    daily_rain <- pws_data[[16]][now_index]
    solar_rad <- pws_data[[20]][now_index]
    uv_index <- pws_data[[21]][now_index]
    out_feels <- pws_data[[22]][now_index]
    out_dewpoint <- pws_data[[23]][now_index]
    windchill <- 35.74 + (0.6215 * out_temp)
    - (35.75 * wind_speed ^ 0.16) + (0.4275 * out_temp * wind_speed ^ 0.16)
  }
}
