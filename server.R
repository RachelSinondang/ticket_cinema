#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$plot_film <- renderPlotly({
        
        film_a = tick_b %>% select(c(film_code,cinema_code,tickets_sold,total_sales)) %>%
            group_by(film_code,cinema_code) %>%
            summarise(total = round(sum(tickets_sold)),
                      sales = round(sum(total_sales))) %>%
            arrange(desc(sales))
        
        plot_film = ggplot(data = film_a %>%
                               filter(film_code == input$film),aes(x = reorder(cinema_code,sales),y = sales, text = glue("cinema: {cinema_code}
                                     tiket sold: {total}
                                     total sales : {sales}"))) +
            geom_col(aes(fill = sales),show.legend = F) +
            theme(axis.text.x=element_blank(),
                  axis.ticks.x=element_blank()) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                        panel.background = element_blank(), axis.line = element_line(colour = "black"))+
            labs(title = "Sales of Film in Every Cinemas",
                 x = "Cinema's Code",
                 y = "Mean of Sales") +
            ggtitle("Sales of Film in Every Cinemas") +
            theme(plot.title = element_text(hjust = 0.5)) + theme_algoritma
        
        ggplotly(plot_film, tooltip = "text")
    })
    
    output$plot_cin <- renderPlotly({
        
        cinema = tick_b %>% select(c(film_code,cinema_code,tickets_sold)) %>%
            group_by(film_code,cinema_code) %>%
            summarise(rerata = round(mean(tickets_sold))) %>%
            arrange(desc(rerata))
        
        plot_cin = ggplot(data = cinema %>%
                              filter(cinema_code == input$cine) ,aes(x = reorder(film_code,rerata),y = rerata, text = glue("Film: {film_code}
                                     mean: {rerata}"))) +
            geom_col(aes(fill = rerata),show.legend = F) +
            scale_fill_gradient(low = "#FF4500", high = "#FF8C00")   +
            theme(axis.text.x=element_blank(),
                  axis.ticks.x=element_blank()) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                        panel.background = element_blank(), axis.line = element_line(colour = "black"))+
            labs(title = "Mean of Every Films Sold in a cinema",
                 x = "Film's Code",
                 y = "Mean of Sales") +
            ggtitle("Daily Mean of Each Films Sold in a Cinema") +
            theme(plot.title = element_text(hjust = 0.5)) + theme_algoritma
        
        ggplotly(plot_cin, tooltip = "text")
        
    })
    
    output$plot_film_gen <- renderPlotly({
        
        tick_e = tick_b %>% select(c(cinema_code,tickets_sold,total_sales)) %>%
            group_by(cinema_code) %>%
            summarise(total = round(sum(tickets_sold)),
                      sales = round(sum(total_sales))) %>%
            arrange(desc(sales))
        
        plot_film_gen = ggplot(data = tick_e %>%
                                   filter(cinema_code == input$cin1 | cinema_code == input$cin2 | cinema_code == input$cin3 | cinema_code == input$cin4 | cinema_code == input$cin5 | cinema_code == input$cin6),aes(x = reorder(cinema_code,sales),y = sales, text = glue("cinema: {cinema_code}
                                     tiket sold: {total}
                                     total sales : {sales}"))) +
            geom_col(aes(fill = sales),show.legend = F) +
            scale_fill_gradient(low = "#006400", high = "#00FF00") +
            theme(axis.text.x=element_blank(),
                  axis.ticks.x=element_blank()) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                        panel.background = element_blank(), axis.line = element_line(colour = "black"))+
            labs(title = "Sales in every cinemas",
                 x = "Cinema's Code",
                 y = "Mean of Sales") +
            ggtitle("Sales in every cinemas") +
            theme(plot.title = element_text(hjust = 0.5)) + theme_algoritma
        
        ggplotly(plot_film_gen, tooltip = "text")
    })
    
    output$plot_semua_film <- renderPlotly({
        
        jual = tick_b %>% select(c(film_code, tickets_sold,total_sales)) %>%
            group_by(film_code) %>%
            summarise(ticket = round(sum(tickets_sold)),
                      sales = round(sum(total_sales))) %>%
            arrange(desc(sales))
        
        plot_semua_film = ggplot(data = jual %>%
                                     filter(film_code == input$fil1 | film_code == input$fil2 | film_code == input$fil3 | film_code == input$fil4 | film_code == input$fil5 | film_code == input$fil6),aes(x = reorder(film_code,sales),y = sales, text = glue("film: {film_code}
                                     tiket sold: {ticket}
                                     total sales : {sales}"))) +
            geom_col(aes(fill = sales),show.legend = F) +
            scale_fill_gradient(low = "#800000", high = "#F08080") +
            theme(axis.text.x=element_blank(),
                  axis.ticks.x=element_blank()) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                        panel.background = element_blank(), axis.line = element_line(colour = "black"))+
            labs(title = "Total Sales of Film",
                 x = "Film's Code",
                 y = "Total Sales") +
            ggtitle("Total Sales of Film") +
            theme(plot.title = element_text(hjust = 0.5)) + theme_algoritma
        
        ggplotly(plot_semua_film, tooltip = "text")
        
    })
    
    
    output$plot_film_month <- renderPlotly({
        
        film_month = clean %>%
            select(c(film_code, tickets_sold, total_sales, month, year)) %>%
            group_by(film_code,month,year) %>%
            summarise(total = round(sum(tickets_sold)),
                      sales = round(sum(total_sales))) %>%
            arrange(desc(sales))
        
        plot_film_month = ggplot(data = film_month %>%
                                     filter(month == input$month & year == input$year),aes(x = reorder(film_code,sales),y = sales, text = glue("film: {film_code}
                                     tiket sold: {total}
                                     total sales : {sales}"))) +
            geom_col(aes(fill = sales),show.legend = F) +
            scale_fill_gradient(low = "#4B0082", high = "#BA55D3") +
            theme(axis.text.x=element_blank(),
                  axis.ticks.x=element_blank()) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                        panel.background = element_blank(), axis.line = element_line(colour = "black"))+
            labs(title = "Total Sales of Film in Current Period",
                 x = "Film's Code",
                 y = "Total Sales") +
            ggtitle("Total Sales of Film in Current Period") +
            theme(plot.title = element_text(hjust = 0.5)) + theme_algoritma
        
        ggplotly(plot_film_month, tooltip = "text")
        
    })
    
    output$plot_tanggal <- renderPlotly({
        
        tanggal_a = tick_b %>% select(c(film_code,tickets_sold,date, cinema_code)) %>%
            mutate(wday = wday(date))  %>%
            group_by(film_code,date,wday,cinema_code) %>%
            summarise(jumlah = round(sum(tickets_sold)))
        
        b = tanggal_a   %>%
            filter(film_code == input$filday)
        
        c = b %>%
            filter(cinema_code == input$cinema) 
        
        plot_tanggal_a <- ggplot(data = c, aes(x = date, y = jumlah))+ 
            geom_point( col = "blue", aes(
                text = glue("
                         {date}
                         Tickets Sold: {jumlah}")))+geom_line() +
            geom_point( data = c  %>% 
                            filter(wday == "1"), col = "red")+
            theme_algoritma +
            labs(title = "Total Sales of a Day",
                 x = "Date",
                 y = "Total Sales") 
        
        ggplotly(plot_tanggal_a, tooltip = "text")
    })
    
    output$plot_percent <- renderPlotly({
        
        time = tick_b %>% select(c(cinema_code,tickets_sold,show_time)) %>%
            filter(cinema_code == input$cin) %>%
            group_by(cinema_code,show_time) %>%
            summarise(rerata = round(mean(tickets_sold)))
        
        fig <- time %>% plot_ly(labels = ~show_time, values = ~rerata)
        fig <- fig %>% add_pie(hole = 0.6)
        fig <- fig %>% layout(title = "Ticket Sold per Show Time",  showlegend = F,
                              xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                              yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
        
        fig
        
    })
    
})
