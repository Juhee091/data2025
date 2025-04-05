import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score
import numpy as np

# Load data
df = pd.read_csv("Inventory_Data_Model_Ready.csv")
X = df.drop(columns=['date', 'weekday', 'sales_qty', 'event'])
y = df['sales_qty']

# Split data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train model
rf_model = RandomForestRegressor(n_estimators=100, random_state=42)
rf_model.fit(X_train, y_train)
y_pred = rf_model.predict(X_test)

# Metrics
rmse = np.sqrt(mean_squared_error(y_test, y_pred))  # fix for 'squared' error
mae = mean_absolute_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)

# Streamlit app
st.title("📊 Sales Forecasting Dashboard")

st.subheader("✅ Model Performance")
metrics_df = pd.DataFrame({
    'Model': ['Random Forest'],
    'RMSE': [rmse],
    'MAE': [mae],
    'R2 Score': [r2]
})
st.dataframe(metrics_df)

st.subheader("📈 Actual vs Predicted Sales Quantity")
fig, ax = plt.subplots(figsize=(10, 4))
ax.plot(y_test.values[:100], label='Actual', marker='o')
ax.plot(y_pred[:100], label='Predicted', marker='x')
ax.set_title("Actual vs Predicted (Sample of 100)")
ax.set_xlabel("Sample Index")
ax.set_ylabel("Sales Quantity")
ax.legend()
st.pyplot(fig)

st.subheader("🔢 Predict Sales Quantity (Optional Input)")
user_input = {}
for col in X.columns:
    val = st.number_input(f"{col}", value=float(X[col].mean()))
    user_input[col] = val

if st.button("Predict"):
    input_df = pd.DataFrame([user_input])
    prediction = rf_model.predict(input_df)[0]
    st.success(f"📌 Predicted Sales Quantity: {round(prediction, 2)}")
