import pandas as pd
from dotenv import load_dotenv
import os

load_dotenv()

api_url = os.getenv('API_URL')

df = pd.read_parquet(api_url)

# Split the billing_month column into month and year
df[['year', 'month']] = df['billing_month'].str.split('-', expand=True)

# Reorder columns
cols = ['customer_id', 'disco', 'billing_month', 'year', 'month', 'tariff_band', 'kwh', 'price_ngn_kwh', 'amount_billed_ngn', 'amount_paid_ngn', 'paid_on_time', 'arrears_ngn']
df = df[cols]

# covert file from parquet to csv 

df.to_csv("nigerian_energy_and_utilities_billing_payments.csv")

print(df.head())