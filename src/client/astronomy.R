library(shiny)

# written by Michael N
#
# Simple page that displays astronomical photographs that I have
# taken from my telescope.

tagList(
  div(tags$h1(
    hr(),
    div(align = "center", strong("Personal Web | Astronomy")),
    hr(),
  )),
  tags$h1(
    fluidRow(column(
      12, img(
        src = "astr_moon.jpg",
        height = 500,
        length = 1080,
        style = "border-radius: 25px;"
      ),
      align = "center",
    )),
    hr(),
    fluidRow(column(
      12,
      img(
        src = "astr_space_1.jpg",
        height = 500,
        length = 1080,
        style = "border-radius: 25px;"
      ),
      align = "center",
    )),
    hr(),
    fluidRow(column(
      12,
      img(
        src = "astr_space_2.jpg",
        height = 500,
        length = 1080,
        style = "border-radius: 25px;"
      ),
      align = "center",
    )),
  )
)
