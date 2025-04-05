import streamlit as st
from transformers import DistilBertTokenizer, DistilBertForSequenceClassification
import torch
import numpy as np
import os


# Load model and tokenizer (assumes files in ./distilbert-sentiment-model)
@st.cache_resource
def load_model():
    model = DistilBertForSequenceClassification.from_pretrained("./distilbert-sentiment-model")
    tokenizer = DistilBertTokenizer.from_pretrained("./distilbert-sentiment-model")
    return model, tokenizer


model, tokenizer = load_model()

# Label mapping (adjust if your model uses different order)
id2label = {0: "negative", 1: "neutral", 2: "positive"}

# App layout
st.title("💬 Franchisee Feedback Sentiment Analyzer")
st.write("Enter a piece of feedback from a franchisee to analyze its sentiment using a BERT-based model.")

# Text input
text = st.text_area("Feedback Text", "The product quality is really poor and the staff was unkind.")

if st.button("Analyze Sentiment"):
    inputs = tokenizer(text, return_tensors="pt", truncation=True, padding=True)
    with torch.no_grad():
        outputs = model(**inputs)
        prediction = torch.argmax(outputs.logits, dim=1).item()
        sentiment = id2label[prediction]

    st.markdown(f"### 🧠 Predicted Sentiment: **{sentiment.upper()}**")
    st.progress(float(torch.nn.functional.softmax(outputs.logits, dim=1)[0][prediction]))

st.caption("Model: distilbert-base-uncased | Fine-tuned on franchisee feedback")
