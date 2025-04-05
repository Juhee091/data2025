import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
import re, string

# Load Data
df = pd.read_csv("Owner_Feedback_English_Only.csv")

# Preprocess text
def preprocess(text):
    text = text.lower()
    text = re.sub(f"[{string.punctuation}]", "", text)
    text = re.sub(r"\d+", "", text)
    text = re.sub(r"\s+", " ", text).strip()
    return text

df['cleaned'] = df['owner_feedback'].astype(str).apply(preprocess)

# TF-IDF
vectorizer = TfidfVectorizer(stop_words='english', max_features=1000)
X = vectorizer.fit_transform(df['cleaned'])
y = df['sentiment']

# Model training
model = LogisticRegression(max_iter=200)
model.fit(X, y)

# Streamlit App
st.title("💬 Franchisee Feedback Sentiment Dashboard")

st.subheader("📊 Sentiment Distribution")
sentiment_counts = df['sentiment'].value_counts().reset_index()
sentiment_counts.columns = ['Sentiment', 'Count']
fig1, ax1 = plt.subplots()
sns.barplot(data=sentiment_counts, x='Sentiment', y='Count', palette='coolwarm', ax=ax1)
ax1.set_title("Sentiment Count")
st.pyplot(fig1)

st.subheader("🧠 Predict Sentiment")
user_input = st.text_area("Enter franchisee feedback:", "The staff is helpful and service is quick.")

if st.button("Analyze"):
    processed = preprocess(user_input)
    vectorized = vectorizer.transform([processed])
    prediction = model.predict(vectorized)[0]
    st.success(f"Predicted Sentiment: {prediction.capitalize()}")