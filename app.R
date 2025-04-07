# 📁 app.R
# ✅ Climate Crisis Dashboard 

install.packages("shiny")

library(shiny)
library(ggplot2)
library(dplyr)
library(prophet)

temp <- read.csv("GLB.Ts+dSST.csv")
co2 <- read.csv("owid-co2-data.csv")
energy <- read.csv("owid-energy-data.csv")
korea <- read.csv("owid-co2-data-south-korea.csv")

# ======= Part 1: 온도 vs CO₂ =======
co2_avg <- co2 %>%
  group_by(year) %>%
  summarise(avg_co2 = mean(co2, na.rm = TRUE))

combined <- left_join(temp, co2_avg, by = c("Year" = "year"))

# ======= Part 2: 지속 가능성 점수 =======

rownames(energy) <- energy$country
energy <- energy[, -which(names(energy) == "country")]
energy_scaled <- scale(energy)
energy_scaled <- as.data.frame(energy_scaled)
energy_scaled$sustain_score <- (
  energy_scaled$renewables_share_energy +
    energy_scaled$gdp_per_unit_co2 -
    energy_scaled$co2_per_capita
)
energy_scaled$country <- rownames(energy_scaled)


# ======= Part 3: Prophet 예측 =======
korea_prophet <- korea %>%
  rename(ds = year, y = co2)
korea_prophet$ds <- as.Date(paste0(korea_prophet$ds, "-01-01"))

model <- prophet(korea_prophet)
future <- make_future_dataframe(model, periods = 25, freq = "year")
forecast <- predict(model, future)

# ======= UI =======
ui <- fluidPage(
  titlePanel("🌍 Climate Crisis Dashboard"),
  
  tabsetPanel(
    
    tabPanel("🌡️ Temp vs CO₂",
             h4("Global Temperature Anomaly vs CO₂ Emissions"),
             plotOutput("plot1")
    ),
    
    tabPanel("🌱 Sustainability Score",
             h4("Country Sustainability Comparison"),
             plotOutput("plot2")
    ),
    
    tabPanel("🇰🇷 Korea Forecast",
             h4("Korea's CO₂ Emissions Forecast (Prophet)"),
             plotOutput("plot3")
    )
  )
)

# ======= SERVER =======
server <- function(input, output) {
  
  output$plot1 <- renderPlot({
    ggplot(combined, aes(x = avg_co2, y = Anomaly)) +
      geom_point(color = "tomato", size = 3) +
      geom_smooth(method = "lm", se = FALSE, color = "steelblue") +
      labs(
        title = "🌡️ Temperature vs. CO₂",
        x = "Avg CO₂ Emissions (Mt)",
        y = "Temp Anomaly (°C)"
      ) +
      theme_minimal()
  })
  
  output$plot2 <- renderPlot({
    ggplot(energy_scaled, aes(x = reorder(country, sustain_score), y = sustain_score)) +
      geom_col(fill = "forestgreen") +
      coord_flip() +
      labs(
        title = "🌱 Sustainability Score by Country",
        x = "Country", y = "Sustainability Score"
      ) +
      theme_minimal()
  })
  
  output$plot3 <- renderPlot({
    plot(model, forecast) +
      ggtitle("🇰🇷 Korea's CO₂ Forecast") +
      theme_minimal()
  })
}
shinyApp(ui = ui, server = server)
