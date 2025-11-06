from dotenv import load_dotenv
import os

load_dotenv()

print(f"DB Name: {os.getenv('DB_NAME')}")
print(f"DB Host: {os.getenv('DB_HOST')}")
# Don't print password in production!