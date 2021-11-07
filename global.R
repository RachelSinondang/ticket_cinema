library(shiny)
library(shinydashboard)
library(tidyverse)
library(ggplot2)
library(glue)
library(plotly)
library(lubridate)
library(treemapify)
library(formattable)

comma(1000.64, digits = 1)

options(scipen = 100)

theme_algoritma <- theme(legend.key = element_rect(fill="black"),
                         legend.background = element_rect(color="white", fill="#263238"),
                         plot.subtitle = element_text(size=6, color="white"),
                         panel.background = element_rect(fill="#dddddd"),
                         panel.border = element_rect(fill=NA),
                         panel.grid.minor.x = element_blank(),
                         panel.grid.major.x = element_blank(),
                         panel.grid.major.y = element_line(color="darkgrey", linetype=2),
                         panel.grid.minor.y = element_blank(),
                         plot.background = element_rect(fill="#263238"),
                         text = element_text(color="white"),
                         axis.text = element_text(color="white")
                         
)

ticket = read.csv("cinemaTicket_Ref.csv")
ticket <- ticket %>%
  mutate(film_code = as.factor(film_code),
         cinema_code = as.factor(cinema_code),
         date = as.Date(date)) %>%
  select(-ticket_use)

tick_a <- ticket %>% select(-c(quarter,day, month))

tick_b = tick_a %>% drop_na()

tanggal_a = tick_b %>% select(c(film_code,tickets_sold,date, cinema_code)) %>%
  mutate(wday = wday(date))  %>%
  group_by(film_code,date,wday,cinema_code) %>%
  summarise(jumlah = round(sum(tickets_sold)))

film_a = tick_b %>% select(c(film_code,cinema_code,tickets_sold,total_sales)) %>%
  group_by(film_code,cinema_code) %>%
  summarise(total = round(sum(tickets_sold)),
            sales = round(sum(total_sales))) %>%
  arrange(desc(sales))

cinema = tick_b %>% select(c(film_code,cinema_code,tickets_sold)) %>%
  group_by(film_code,cinema_code) %>%
  summarise(rerata = round(mean(tickets_sold))) %>%
  arrange(desc(rerata))

tick_e = tick_b %>% select(c(cinema_code,tickets_sold,total_sales)) %>%
  group_by(cinema_code) %>%
  summarise(total = round(sum(tickets_sold)),
            sales = round(sum(total_sales))) %>%
  arrange(desc(sales))

jual = tick_b %>% select(c(film_code, tickets_sold,total_sales)) %>%
  group_by(film_code) %>%
  summarise(ticket = round(sum(tickets_sold)),
            sales = round(sum(total_sales))) %>%
  arrange(desc(sales))

film_month = clean %>%
  select(c(film_code, tickets_sold, total_sales, month, year)) %>%
  group_by(film_code,month,year) %>%
  summarise(total = round(sum(tickets_sold)),
            sales = round(sum(total_sales))) %>%
  arrange(desc(sales))