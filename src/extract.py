import pandas as pd
from dotenv import load_dotenv
import os

load_dotenv()

api_url = os.getenv('API_URL')

# Load data from the API URL
df = pd.read_parquet(api_url) 

# Print top 20 rows in the table and columns in the dataframe
print(df.head(20))