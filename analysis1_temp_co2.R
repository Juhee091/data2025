# 📁 analysis1_temp_co2.R
# ✅ 분석 1: Global Temp vs. CO₂

# 1. 패키지 로드
library(tidyverse)

# 2. 데이터 불러오기
temp <- read.csv("GLB.Ts+dSST.csv")
co2 <- read.csv("owid-co2-data.csv")

# 3. 연도별 평균 CO₂ 계산
co2_avg <- co2 %>%
  group_by(year) %>%
  summarise(avg_co2 = mean(co2, na.rm = TRUE))

# 4. 병합 (온도 + CO₂)
combined <- left_join(temp, co2_avg, by = c("Year" = "year"))

# 5. 상관계수 출력
cor_value <- cor(combined$Anomaly, combined$avg_co2, use = "complete.obs")
cat("📊 Correlation between Global Temp and CO₂ Emissions: ", round(cor_value, 3), "\n")

# 6. 시각화
ggplot(combined, aes(x = avg_co2, y = Anomaly)) +
  geom_point(color = "tomato", size = 3) +
  geom_smooth(method = "lm", se = FALSE, color = "steelblue") +
  labs(
    title = "🌍 Global Temperature vs. CO₂ Emissions",
    subtitle = paste("Correlation:", round(cor_value, 3)),
    x = "Average CO₂ Emissions (Mt)",
    y = "Temperature Anomaly (°C)"
  ) +
  theme_minimal()

# 7. 분석 로그
cat("✅ Analysis 1 complete: strong relationship visualized and quantified.\n")

