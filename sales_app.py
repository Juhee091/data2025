import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load the anomaly detection results
df = pd.read_csv("Anomaly_Detection_Data_Reconstructed.csv")
df['date'] = pd.to_datetime(df['date'])

# Run Isolation Forest again to ensure anomaly column exists
from sklearn.ensemble import IsolationForest

# Re-encode product and time_slot
df_encoded = pd.get_dummies(df, columns=['product', 'time_slot'], drop_first=True)
isf_model = IsolationForest(contamination=0.05, random_state=42)
df_encoded['anomaly'] = isf_model.fit_predict(df_encoded.drop(columns=['date', 'sales_qty']))
df['anomaly'] = df_encoded['anomaly']
df['anomaly_label'] = df['anomaly'].map({1: 'normal', -1: 'anomaly'})

# Streamlit App
st.title("🚨 Sales Anomaly Detection Dashboard")

st.subheader("📊 Anomaly Rate Summary")
product_rate = df.groupby('product')['anomaly'].apply(lambda x: (x == -1).sum() / len(x)).reset_index(name='Anomaly Rate')
time_rate = df.groupby('time_slot')['anomaly'].apply(lambda x: (x == -1).sum() / len(x)).reset_index(name='Anomaly Rate')

col1, col2 = st.columns(2)
col1.write("### By Product")
col1.dataframe(product_rate)

col2.write("### By Time Slot")
col2.dataframe(time_rate)

st.subheader("📈 Sales with Anomalies Highlighted")
selected_product = st.selectbox("Select Product", df['product'].unique())
selected_time = st.selectbox("Select Time Slot", df['time_slot'].unique())

filtered = df[(df['product'] == selected_product) & (df['time_slot'] == selected_time)]

fig, ax = plt.subplots(figsize=(10, 4))
sns.scatterplot(data=filtered, x='date', y='sales_qty', hue='anomaly_label', palette={'normal': 'blue', 'anomaly': 'red'}, ax=ax)
ax.set_title(f"{selected_product.title()} Sales at {selected_time}")
ax.set_ylabel("Sales Quantity")
ax.set_xlabel("Date")
ax.grid(True)
st.pyplot(fig)
