library(shiny)

# historyServer.R - written by Michael N.
server <- {
  name <- reactive({input$nname})
  demo <- reactive({input$ndemo})
  lead <- reactive({input$nlead})
  
  turn <- reactiveVal(0)
  year <- reactiveVal(-10000)
  
  play_prosperity <- reactiveVal(0)
  play_prestige <- reactiveVal(0)
  play_progress <- reactiveVal(0)
  
  output$natdetails <- renderText(sprintf("The stage of history is set, and the curtains open on %s, led by %s. Where will the %s people stand in the river flows of history?", 
                                          name(), lead(), demo()))
  
  output$prosperity <- renderText(play_prosperity())
  output$prestige <- renderText(play_prestige())
  output$progress <- renderText(play_progress())
  
  output$issue <- renderText(sprintf("Click the button below to start, %s.", lead()))
  output$issueBox <- renderUI(selectInput("govAction", choices=c("Let us play history.", "Let's start!"), label="", selected="Let's start!", width="720px"))
  
  formatYear <- reactive({
    if(year() < 0) {
      sprintf("%s BCE", abs(year()))
    } else {
      sprintf("%s CE", year())
    }
  })
  
  issue_data <- function() {
    switch(as.character(turn()),
           "0" = c(-8000, sprintf("Click the button below to start, %s.", lead()), "Choice One", 0, 0, 0, "Choice Two", 0, 0, 0),
           "1" = c(-8000, sprintf("%s people have begun experimenting with cultivating crops, and for the first time you find yourself leading a fledging civilization.", demo()), sprintf("I, as %s, will lead %s to greatness and prosperity.", lead(), name()), 6, 4, 2, sprintf("I, as %s, will lead %s to greatness and progress.", lead(), name()), 2, 4, 6),
           "2" = c(0, "", "", 0, 0, 0, "", 0, 0, 0),
           "3" = c(0, "", "", 0, 0, 0, "", 0, 0, 0),
           "4" = c(0, "", "", 0, 0, 0, "", 0, 0, 0),
           "5" = c(0, "", "", 0, 0, 0, "", 0, 0, 0),
           "6" = c(0),
           "7" = c(0),
           "8" = c(0),
           "9" = c(0),
           "10" = c(0),
           "11" = c(0),
           "12" = c(0),
           "13" = c(0),
           "14" = c(0),
           "15" = c(0),
           "16" = c(0),
           "17" = c(0),
           "18" = c(0),
           "19" = c(0),
           "20" = c(0),
           "21" = c(0),
           "22" = c(0),
           "23" = c(0),
           "24" = c(0),
           "25" = c(0),
           "26" = c(0),
           "27" = c(0),
           "28" = c(0),
           "29" = c(0),
           "30" = c(0),
           "31" = c(0),
           "32" = c(0),
           "33" = c(0),
           "34" = c(0),
           "35" = c(0),
           "36" = c(0),
           "37" = c(0),
           "38" = c(0),
           "39" = c(0),
           "40" = c(0),
           "41" = c(0),
           "42" = c(0),
           "43" = c(0),
           "44" = c(0),
           "45" = c(0),
           "46" = c(0),
           "47" = c(0),
           "48" = c(0),
           "49" = c(0),
           "50" = c(0),
           "51" = c(0),
           "52" = c(0),
           "53" = c(0),
           "54" = c(0),
           "55" = c(0),
           "56" = c(0),
           "57" = c(0),
           "58" = c(0),
           "59" = c(0),
           "60" = c(0),
           "61" = c(0),
           "62" = c(0),
           "63" = c(0),
           "64" = c(0),
           "65" = c(0),
    ) 
  }
  
  output$year <- renderText(formatYear())
  output$turn <- renderText(turn())
  observeEvent(input$nextTurn, {
    if(turn() <= 1) { #65 at end
      if(input$govAction == issue_data()[3]) {
        play_prosperity(play_prosperity() + as.integer(issue_data()[4]))
        play_prestige(play_prestige() + as.integer(issue_data()[5]))
        play_progress(play_progress() + as.integer(issue_data()[6]))
      } else {
        play_prosperity(play_prosperity() + as.integer(issue_data()[8]))
        play_prestige(play_prestige() + as.integer(issue_data()[9]))
        play_progress(play_progress() + as.integer(issue_data()[10]))
      }
      year(as.integer(issue_data()[1]))
      output$issue <- renderText(issue_data()[2])
      output$issueBox <- renderUI(selectInput("govAction", choices=c(issue_data()[3], issue_data()[7]), label="", width="720px", ))
    } else {
      year(year() + 1)
    }
    turn(turn() + 1)
  })
}