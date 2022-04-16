library(shiny)

tagList(tags$h1(
  strong("Contact Information"),
  hr(),
  "Questions? Feel free to reach out!",
  br(),
  div(img(src="michael.jpg", height=250, length=250)),
), tags$h3(
  "Michael Nersinger",
  br(),
  "Software Engineering Student at RIT",
  br(),
  hr(),
  strong("Discord"),
  hr(),
  "Wulvlox#8580",
  br(),
  hr(),
  strong("Emails"),
  hr(),
  "College: mnn7135@rit.edu",
  br(),
  "Personal: nersingerm@hotmail.com",
  br(),
  hr(),
  
  strong("Other"),
  hr(),
  tags$a(href="https://www.linkedin.com/in/michael-nersinger/", target="_blank", "Michael's Linkedin"),
  br(),
  tags$a(href="https://github.com/mnn7135", target="_blank", "Michael's GitHub"),
))