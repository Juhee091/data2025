# 📁 analysis3_korea_forecast.R
# ✅ 분석 3: Korea's CO₂ Forecast with Prophet

# 1. 패키지 로드
library(tidyverse)
library(prophet)

# 2. 데이터 불러오기
korea <- read.csv("owid-co2-data-south-korea.csv")

# 3. Prophet용 포맷으로 전처리
korea_prophet <- korea %>%
  rename(ds = year, y = co2)

# 연도 → 날짜형으로 변환
korea_prophet$ds <- as.Date(paste0(korea_prophet$ds, "-01-01"))

# 4. 모델 학습
model <- prophet(korea_prophet)

# 5. 향후 25년 예측 (2023 ~ 2048)
future <- make_future_dataframe(model, periods = 25, freq = "year")
forecast <- predict(model, future)

# 6. 시각화
plot(model, forecast) +
  ggtitle("🇰🇷 Forecast of Korea's CO₂ Emissions (Prophet)") +
  theme_minimal()

# 7. 주요 연도 예측 확인
important_years <- forecast %>%
  filter(format(ds, "%Y") %in% c("2030", "2040", "2050")) %>%
  select(ds, yhat, yhat_lower, yhat_upper)

print("📋 CO₂ Emission Forecast for Korea:")
print(important_years)

# 8. 분석 로그
cat("✅ Analysis 3 complete: CO₂ emission forecast generated using Prophet.\n")
