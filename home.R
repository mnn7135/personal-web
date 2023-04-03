library(shiny)

tagList(div(tags$h1(
  strong("Home"),
  hr(), style="font-size: 45px;"
  )),
  tags$h1(
    fluidRow(
      column(9,
             strong(div("Quick Links")),
             hr(),
             fluidRow(
               column(2, div()),
               column(2, div(tags$a(href="https://www.bing.com/", target="_blank", img(src="bing.jpg", height=150, length=150))),
               ),
               column(1, div()),
               column(2, div(tags$a(href="https://www.google.com/", target="_blank", img(src="google.jpg", height=150, length=150))),
               ),
               column(1, div()),
               column(2, div(tags$a(href="https://www.rit.edu/", target="_blank", img(src="ritp.jpg", height=150, length=150))),
               )
             ),
             hr(),
             fluidRow(
               column(2, div()),
               column(2, div(tags$a(href="https://github.com/mnn7135/", target="_blank", img(src="git.jpg", height=150, length=150))),
               ),
               column(1, div()),
               column(2, div(tags$a(href="https://www.linkedin.com/in/michael-nersinger/", target="_blank", img(src="lin.jpg", height=150, length=150))),
               ),
               column(1, div()),
               column(2, div(tags$a(href="https://trello.com/", target="_blank", img(src="trello.jpg", height=150, length=150))),
               ),
             ),
             hr(),
             fluidRow(
               column(2, div()),
               column(2, div(tags$a(href="https://stackoverflow.com/", target="_blank", img(src="stack.jpg", height=150, length=150))),
               ),
               column(1, div()),
               column(2, div(tags$a(href="https://www.firstinspires.org/robotics/frc", target="_blank", img(src="first.jpg", height=150, length=150))),
               ),
               column(1, div()),
               column(2, div(tags$a(href="https://www.indeed.com/?from=gnav-homepage", target="_blank", img(src="indeed.jpg", height=150, length=150))),
               ),
             )
             
      ),
      column(3, strong(div("Contact Details")),
             hr(),
             div(img(src="mn.jpg", height=375, length=250)),
             hr(),
             tags$h3(
             strong("Michael Nersinger"),
        hr(),
        "Software Engineering Student",
        br(),
        hr(),
        strong("Email"),
        hr(),
        "mnn7135@rit.edu",
        br(),
        hr(),
        strong("Resume"),
        hr(),
        actionButton("resume", "Resume PDF", onclick = "window.open('resume.pdf')"),
        br(),
        hr(),
      ),
    ),
  ),
  )
)