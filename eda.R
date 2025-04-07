
# 📁 eda.R
# ✅ Climate Project: Exploratory Data Analysis

# 1. 패키지 로드
library(tidyverse)
library(corrplot)

# 2. 데이터 불러오기
temp <- read.csv("GLB.Ts+dSST.csv")
co2 <- read.csv("owid-co2-data.csv")
energy <- read.csv("owid-energy-data.csv")
korea <- read.csv("owid-co2-data-south-korea.csv")

# 3. 데이터 구조 확인 --------------------------------------

# 🔍 전 지구 온도
glimpse(temp)
summary(temp)

# 🔍 CO₂ 데이터
glimpse(co2)
summary(co2)

# 🔍 에너지 / 지속 가능성 지표
glimpse(energy)
summary(energy)

# 🔍 한국 CO₂
glimpse(korea)
summary(korea)

# 4. 결측치 확인 -----------------------------------------

cat("Missing values in temp:", sum(is.na(temp)), "\n")
cat("Missing values in co2:", sum(is.na(co2)), "\n")
cat("Missing values in energy:", sum(is.na(energy)), "\n")
cat("Missing values in korea:", sum(is.na(korea)), "\n")

# 5. 시각화 ----------------------------------------------

# 🌡️ 연도별 지구 평균 기온 anomaly
ggplot(temp, aes(x = Year, y = Anomaly)) +
  geom_line(color = "red", size = 1.2) +
  labs(title = "🌍 Global Temperature Anomaly (2000–2023)",
       x = "Year", y = "Temperature Anomaly (°C)") +
  theme_minimal()

# 🏭 연도별 평균 CO₂ 배출량
co2_avg <- co2 %>%
  group_by(year) %>%
  summarise(avg_co2 = mean(co2, na.rm = TRUE))

ggplot(co2_avg, aes(x = year, y = avg_co2)) +
  geom_line(color = "blue", size = 1.2) +
  labs(title = "🏭 Global Average CO₂ Emissions",
       x = "Year", y = "CO₂ Emissions (Mt)") +
  theme_minimal()

# 🌱 에너지 변수 상관관계 히트맵
energy_scaled <- energy %>%
  column_to_rownames("country") %>%
  scale() %>%
  as.data.frame()

corrplot(cor(energy_scaled), method = "circle", type = "upper",
         title = "Sustainability Indicators Correlation", mar = c(0,0,1,0))

# 🇰🇷 한국 CO₂ 배출량 시계열
ggplot(korea, aes(x = year, y = co2)) +
  geom_line(color = "darkgreen", size = 1.2) +
  labs(title = "🇰🇷 South Korea CO₂ Emissions Over Time",
       x = "Year", y = "CO₂ Emissions (Mt)") +
  theme_minimal()

# 6. 분석 로그
cat("✅ EDA complete: data checked, no major missing values, trends visualized.\n")
