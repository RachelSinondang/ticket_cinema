#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

library(shiny)

header <- dashboardHeader(title = "Cafe Sales Forecast")

sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem(text = "General", 
                 tabName = "gen", 
                 icon = icon("chart-bar")),
        menuItem(text = "Detailed", 
                 tabName = "spec", 
                 icon = icon("balance-scale"))
        
    )
)

body <- dashboardBody(
    tabItems(
        tabItem(tabName = "spec",
                fluidRow(
                    box(title = "Sales of Film in Every Cinemas",
                        background = "teal",
                        height = "550px",
                        width = 12,
                        fluidRow(column(3,
                                        selectInput(inputId = "film", 
                                                    label = "Choose Film",
                                                    choices = unique(film_a$film_code),
                                                    selected = "1492"))),
                        fluidRow(column(width = 12,plotlyOutput(outputId = "plot_film"))
                        )
                    )
                ),
                fluidRow(
                    box(title = "Daily Mean of Each Films Sold in a Cinema",
                        background = "teal",
                        height = "550px",
                        width = 12,
                        fluidRow(column(3,
                                        selectInput(inputId = "cine", 
                                                    label = "Choose Cinema",
                                                    choices = unique(cinema$cinema_code),
                                                    selected = "1492"))),
                        fluidRow(column(width = 12,plotlyOutput(outputId = "plot_cin"))
                        )
                    )
                ),
                fluidRow(
                    box(title = "Total Ticket Sold of A Day",
                        background = "teal",
                        height = "550px",
                        width = 12,
                        fluidRow(column(3,
                                        selectInput(inputId = "filday", 
                                                    label = "Choose Film",
                                                    choices = unique(tanggal_a$film_code),
                                                    selected = "1492")),
                                 column(3,
                                        selectInput(inputId = "cinema", 
                                                    label = "Choose Cinema",
                                                    choices = unique(tanggal_a$cinema_code),
                                                    selected = "72"))),
                        fluidRow(column(width = 12,plotlyOutput(outputId = "plot_tanggal"))
                        )
                    )
                ),
                fluidRow(
                    box(title = "Percentage of Ticket Sold per Show Time",
                        background = "teal",
                        height = "550px",
                        width = 12,
                        fluidRow(column(3,
                                        selectInput(inputId = "cin", 
                                                    label = "Choose Cinema",
                                                    choices = unique(tick_b$cinema_code),
                                                    selected = "72"))),
                        fluidRow(column(width = 12,plotlyOutput(outputId = "plot_percent"))
                        )
                    )
                )
            
        ),
        tabItem(tabName = "gen",
                fluidRow(
                    box(title = "Sales of Film in Every Cinemas",
                        background = "teal",
                        height = "650px",
                        width = 12,
                        fluidRow(column(4,
                                        selectInput(inputId = "cin1", 
                                                    label = "Cinema 1",
                                                    choices = unique(tick_e$cinema_code),
                                                    selected = "448")),
                                 column(4,
                                        selectInput(inputId = "cin2", 
                                                    label = "Cinema 2",
                                                    choices = unique(tick_e$cinema_code),
                                                    selected = "304")),
                                 column(4,
                                        selectInput(inputId = "cin3", 
                                                    label = "Cinema 3",
                                                    choices = unique(tick_e$cinema_code),
                                                    selected = "344")),
                                 column(4,
                                        selectInput(inputId = "cin4", 
                                                    label = "Cinema 4",
                                                    choices = unique(tick_e$cinema_code),
                                                    selected = "71")),
                                 column(4,
                                        selectInput(inputId = "cin5", 
                                                    label = "Cinema 5",
                                                    choices = unique(tick_e$cinema_code),
                                                    selected = "489")),
                                 column(4,
                                        selectInput(inputId = "cin6", 
                                                    label = "Cinema 6",
                                                    choices = unique(tick_e$cinema_code),
                                                    selected = "518")),
                        column(width = 12,plotlyOutput(outputId = "plot_film_gen"))
                        )
                    )
                ),
                fluidRow(
                    box(title = "Total Sales of Film in general",
                        background = "teal",
                        height = "650px",
                        width = 12,
                        fluidRow(column(4,
                                        selectInput(inputId = "fil1", 
                                                    label = "Film 1",
                                                    choices = unique(jual$film_code),
                                                    selected = "1554")),
                                 column(4,
                                        selectInput(inputId = "fil2", 
                                                    label = "Film 2",
                                                    choices = unique(jual$film_code),
                                                    selected = "1483")),
                                 column(4,
                                        selectInput(inputId = "fil3", 
                                                    label = "Film 3",
                                                    choices = unique(jual$film_code),
                                                    selected = "1500")),
                                 column(4,
                                        selectInput(inputId = "fil4", 
                                                    label = "Film 4",
                                                    choices = unique(jual$film_code),
                                                    selected = "1571")),
                                 column(4,
                                        selectInput(inputId = "fil5", 
                                                    label = "Film 5",
                                                    choices = unique(jual$film_code),
                                                    selected = "1584")),
                                 column(4,
                                        selectInput(inputId = "fil6", 
                                                    label = "Film 6",
                                                    choices = unique(jual$film_code),
                                                    selected = "1502")),
                                 column(width = 12,plotlyOutput(outputId = "plot_semua_film"))
                        )
                    )
                ),
                fluidRow(
                    box(title = "Total Sales of Film in Current Period",
                        background = "teal",
                        height = "550px",
                        width = 12,
                        fluidRow(column(3,
                                        selectInput(inputId = "month", 
                                                    label = "Choose Month",
                                                    choices = unique(film_month$month),
                                                    selected = "8")),
                                 column(3,
                                        selectInput(inputId = "year", 
                                                    label = "Choose Year",
                                                    choices = unique(film_month$year),
                                                    selected = "2018"))),
                        fluidRow(column(width = 12,plotlyOutput(outputId = "plot_film_month"))
                        )
                    )
                )
        )
    )
    
)

dashboardPage(
    header = header,
    body = body,
    sidebar = sidebar, 
    skin = "blue"
)