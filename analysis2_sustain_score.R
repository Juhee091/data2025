# 📁 analysis2_sustain_score.R
# ✅ 분석 2: Sustainability Scoring

# 1. 패키지 로드
library(tidyverse)

# 2. 데이터 불러오기
energy <- read.csv("owid-energy-data.csv")

# 3. 전처리 및 정규화
energy_scaled <- energy %>%
  column_to_rownames("country") %>%
  scale() %>%
  as.data.frame()

# 4. 지속 가능성 점수 계산
# (재생에너지 ↑, 탄소 효율성 ↑, 1인당 CO₂ ↓)
energy_scaled$sustain_score <- (
  energy_scaled$renewables_share_energy +
    energy_scaled$gdp_per_unit_co2 -
    energy_scaled$co2_per_capita
)

# 국가명 다시 열로 복원
energy_scaled$country <- rownames(energy_scaled)

# 5. 시각화
ggplot(energy_scaled, aes(x = reorder(country, sustain_score), y = sustain_score)) +
  geom_col(fill = "forestgreen") +
  coord_flip() +
  labs(
    title = "🌱 Sustainability Score by Country",
    y = "Sustainability Score", x = "Country"
  ) +
  theme_minimal()

# 6. 분석 로그
cat("✅ Analysis 2 complete: country sustainability scores calculated & visualized.\n")
