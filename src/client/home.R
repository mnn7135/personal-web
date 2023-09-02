library(shiny)

# written by Michael N
#

tagList(
  div(tags$h1(hr(), style = "font-size: 45px;")),
  tags$h1(
    "Hello, I'm Michael Nersinger, a BS Software Engineering student at the
    Rochester Institute of Technology pursuing a History minor. I'm most
    proficient with Java, Python, and R, and I've had experience with
    Amazon Web Services and Cloud Development.",
    hr(),
    fluidRow(
      column(
        9,
        strong(div("Quick Links")),
        hr(),
        fluidRow(
          column(2),
          column(2, div(
            tags$a(
              href = "https://www.bing.com/",
              target = "_blank",
              img(
                src = "bing.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(1),
          column(2, div(
            tags$a(
              href = "https://www.google.com/",
              target = "_blank",
              img(
                src = "google.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(1),
          column(2, div(
            tags$a(
              href = "https://www.rit.edu/",
              target = "_blank",
              img(
                src = "ritp.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(2),
        ),
        hr(),
        fluidRow(
          column(2),
          column(2, div(
            tags$a(
              href = "https://github.com/mnn7135/",
              target = "_blank",
              img(
                src = "git.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(1),
          column(2, div(
            tags$a(
              href = "https://www.linkedin.com/in/michael-nersinger/",
              target = "_blank",
              img(
                src = "lin.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(1),
          column(2, div(
            tags$a(
              href = "https://trello.com/",
              target = "_blank",
              img(
                src = "trello.jpg",
                height = 180,
                length = 180
              )
            )
          ),),
          column(2),
        ),
        hr(),
        fluidRow(
          column(2),
          column(2, div(
            tags$a(
              href = "https://stackoverflow.com/",
              target = "_blank",
              img(
                src = "stack.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(1),
          column(2, div(
            tags$a(
              href = "https://www.firstinspires.org/robotics/frc",
              target = "_blank",
              img(
                src = "first.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(1),
          column(2, div(
            tags$a(
              href = "https://www.indeed.com/?from=gnav-homepage",
              target = "_blank",
              img(
                src = "indeed.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(2),
        )
      ),
      column(
        3,
        strong(div("Contact Details")),
        hr(),
        tags$h3(
          strong("Michael Nersinger"),
          hr(),
          "Software Engineer BS at RIT",
          br(),
          hr(),
          "Research Intern at GTRI",
          br(),
          hr(),
          strong("Email"),
          hr(),
          "mnn7135@rit.edu",
          br(),
          hr(),
        ),
      ),
    ),
  )
)
