# AI-Based Franchise Optimization System

This repository contains a comprehensive AI-driven project developed to improve franchise management efficiency, particularly for bakery café branches affiliated with CJ Group (Tous Les Jours). The project blends **Data Science** and **Management** principles to solve real-world franchisee challenges.

## 💡 Motivation

As a Data Science undergraduate and part-time employee at a CJ-affiliated Tous Les Jours bakery (Yeoksam Station), I observed operational inefficiencies and lack of communication between franchise owners and corporate HQ. This inspired me to apply AI solutions to bridge this gap using practical, scalable tools.

## 🔧 Project Structure

The project consists of **three submodules**, each addressing a different franchise pain point:

### 1. Sales Anomaly Detection  
Detects abnormal spikes or drops in sales using unsupervised learning.

- Model: `IsolationForest`
- Output: Alerts for sales anomalies caused by holidays, weather, delivery issues  
- [🌐 Streamlit App](https://data2025-cewwag5m8pdgmr4mrfcswd.streamlit.app/)

---

### 2. Inventory Forecasting  
Predicts optimal daily inventory amounts for key product types (sandwiches, cakes, salads, bread).

- Models: `RandomForestRegressor`, BERT-enhanced features
- Input: Date, time, product type, demand tags
- Output: Accurate quantity forecasting to reduce waste and improve supply planning  
- [🔗 Pre-BERT Forecast](https://data2025-c9wjwzcp7mfsllua8ks5wy.streamlit.app/)  
- [🔗 Post-BERT Forecast](https://data2025-kp4qdnfouvtyr8pdvp8raz.streamlit.app/)

---

### 3. Sentiment Analysis of Owner Feedback  
Analyzes qualitative franchisee feedback and classifies sentiments (Positive / Neutral / Negative).

- Model: Fine-tuned `DistilBERT`
- Data: Transformed tweet dataset into owner-like tone
- Output: Dashboard to assess owner satisfaction at scale  
- [💬 Sentiment Analysis App](https://data2025-kmicwfjkh7k2o2i8rrhgxj.streamlit.app/)

---

## 🧠 Tech Stack

- Python (Pandas, scikit-learn, Transformers, Matplotlib, Seaborn)
- Hugging Face Transformers (`DistilBERT`)
- Streamlit (Dashboard UI)
- Google Colab (Training Environment)
- GitHub (Version Control)

---

## 📈 Results

| Model            | RMSE | MAE  | R² Score |
|------------------|------|------|----------|
| RandomForest      | 4.12 | 2.97 | 0.84     |
| RF + BERT Features| 3.75 | 2.45 | 0.89     |

---

## 📁 Repository Contents

```
├── data/                         # Cleaned & preprocessed datasets
├── models/                       # Trained BERT and forecasting models
├── app/                          # Streamlit dashboard source codes
├── notebooks/                    # Development and training notebooks
├── report/                       # Project documentation (Word & PDF)
└── README.md                     # You are here!
```

---

## 🙋‍♀️ About Me

**Juhee Kim**  
Dongduk Women’s University  
B.Sc. in Data Science (Class of 2024)  
Email: datayui05@gmail.com  
GitHub: [@Juhee091](https://github.com/Juhee091)

---

## 📌 License

This project is for academic and research purposes only.  
Feel free to fork and modify for learning use. Commercial use requires permission.