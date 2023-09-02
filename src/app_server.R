library(shiny)
library(ambientweatheR)

server <- function(input, output) {
  
  # Handle App level server configurations for fetching data.
  Sys.setenv(AW_API_KEY = 
               "9258f994d53042ca9bcbe7f5cc44dfbbfa366"
             + "e4ca4ac43c19a33268a6e060cb6")
  
  Sys.setenv(AW_APPLICATION_KEY = 
               "78a34a92bffc4cc8962e87525a8a35f843e1d"
             + "5dda7a94c3f88114283d16389ed")
  
  Sys.setenv(GITHUB_PAT = "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")
  
  
}