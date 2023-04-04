library(shiny)

# historyServer.R - written by Michael N.
server <- {
  name <- reactive({input$nname})
  demo <- reactive({input$ndemo})
  lead <- reactive({input$nlead})
  
  turn <- reactiveVal(0)
  year <- reactiveVal(-10000)
  
  play_wealth <- reactiveVal(0)
  play_fame <- reactiveVal(0)
  play_progress <- reactiveVal(0)
  
  output$natdetails <- renderText(sprintf("The stage of history is set, and the curtains open on %s, led by %s. Where will the %s people stand in the river flows of history?", 
                                          name(), lead(), demo()))
  
  output$wealth <- renderText(play_wealth())
  output$fame <- renderText(play_fame())
  output$progress <- renderText(play_progress())
  
  output$issue <- renderText(sprintf("Click the button below to start, %s.", lead()))
  output$issueBox <- renderUI(selectInput("govAction", choices=c("Choice One", "Choice Two"), label="", selected="Choice One", width="720px"))
  
  formatYear <- reactive({
    if(year() < 0) {
      sprintf("%s BCE", abs(year()))
    } else {
      sprintf("%s CE", year())
    }
  })
  
  issue_data <- function() {
    switch(as.character(turn()),
           "0" = c(-10000, sprintf("Click the button below to start, %s.", lead()), "Choice One", 0, 0, 0, "Choice Two", 0, 0, 0),
           "1" = c(-8000, sprintf("%s people have begun experimenting with cultivating crops, and for the first time you find yourself leading a fledging civilization.", demo()), sprintf("I, as %s, will lead %s to greatness and wealth.", lead(), name()), 6, 4, 2, sprintf("I, as %s, will lead %s to greatness and progress.", lead(), name()), 2, 4, 6),
    ) 
  }
  
  output$year <- renderText(formatYear())
  output$turn <- renderText(turn())
  observeEvent(input$nextTurn, {
    if(turn() <= 1) { #65 at end
      if(input$govAction == issue_data()[3]) {
        play_wealth(play_wealth() + as.integer(issue_data()[4]))
        play_fame(play_fame() + as.integer(issue_data()[5]))
        play_progress(play_progress() + as.integer(issue_data()[6]))
      } else {
        play_wealth(play_wealth() + as.integer(issue_data()[8]))
        play_fame(play_fame() + as.integer(issue_data()[9]))
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