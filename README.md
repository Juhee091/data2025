
# 🌍 Climate Crisis Dashboard using R Shiny

This project visualizes the global climate crisis through an interactive Shiny dashboard, using real-world data on global temperature, CO₂ emissions, and sustainability indicators.

## 📊 Dashboard Features

### 🌡️ Temperature vs CO₂ Emissions
Explore the correlation between global temperature rise and CO₂ emissions using a scatter plot and regression line.  
✅ **Finding**: A strong positive correlation indicates human-driven climate change.

### 🌱 Country Sustainability Score
Compare countries based on renewable energy usage, per capita CO₂ emissions, and GDP-based carbon efficiency.  
✅ **Finding**: Countries with higher sustainability scores are more climate-resilient.

### 🇰🇷 Korea's Carbon Neutrality Forecast
Using Prophet time-series forecasting, project Korea’s CO₂ emissions through 2050.  
✅ **Finding**: Korea needs more aggressive climate policies to meet its 2050 net-zero goal.

## 📂 Folder Structure
```
climate-crisis-dashboard/
├── data/
│   ├── GLB.Ts+dSST.csv
│   ├── owid-co2-data.csv
│   ├── owid-energy-data.csv
│   └── owid-co2-data-south-korea.csv
├── eda.R
├── analysis1_temp_co2.R
├── analysis2_sustain_score.R
├── analysis3_korea_forecast.R
├── app.R
└── README.md
```

## 🚀 How to Run Locally
```r
shiny::runApp("app.R")
```

## 🌐 Live App (after publishing)
If deployed via [shinyapps.io](https://www.shinyapps.io):
```
https://<yourname>.shinyapps.io/climate-crisis-dashboard/
```

---

Built with ❤️ using **R, ggplot2, dplyr, prophet, and Shiny**.
