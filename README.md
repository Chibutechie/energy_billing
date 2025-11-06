# Nigerian Energy & Utilities Billing Pipeline

A comprehensive ETL data pipeline that ingests, transforms, and loads Nigerian energy billing and payment data into PostgreSQL for analytics and reporting. This project empowers utilities companies, regulators, and analysts to gain actionable insights into billing efficiency, revenue collection, customer payment behaviors, and billing anomalies.

---

## Overview

### Problem Statement

The Nigerian electricity and utilities sector faces significant challenges:

- **Low collection efficiency**: Only 70-80% billing efficiency reported in many quarters
- **Estimated billing practices**: Widespread non-metered billing leading to inaccuracies
- **Revenue shortfalls**: Large gaps between billed amounts and actual collections
- **Limited transparency**: Insufficient data-driven insights for policy decisions

According to [Nairametrics](https://nairametrics.com/2022/09/25/discos-collected-n210-billion-out-of-n303-billion-billed-to-customers-in-q4-2021), Distribution Companies (DisCos) collected only ₦210 billion out of ₦303 billion billed to customers in Q4 2021.

### Solution

This pipeline provides stakeholders with:

- Automated data ingestion and transformation
- Centralized data warehouse for analytics
- Insights into billing efficiency trends
- Customer payment behavior analysis
- Revenue leakage identification

---

## Project Objectives

Successfully extract, transform, and load data from source to data warehouse with the following deliverables:

1. **Automated ETL Pipeline**: Batch processing system for reliable data movement
2. **Pipeline Architecture**: Clear visualization of data workflow and transformations
3. **Analytics-Ready Data**: Structured data warehouse optimized for reporting

---

## Architecture

![alt text](image-1.png)
---

## Dataset

**Source**: [Hugging Face Dataset](https://huggingface.co/datasets/electricsheepafrica/nigerian_energy_and_utilities_billing_payments)

### Schema

| Column | Type | Description |
|--------|------|-------------|
| `customer_id` | String | Unique identifier for each customer |
| `disco` | String | Distribution Company name |
| `billing_month` | String | Month and year of billing cycle |
| `tariff_band` | String | Customer tariff classification |
| `kwh` | Float | Kilowatt-hours consumed |
| `price_ngn_kwh` | Float | Price per kWh in Nigerian Naira |
| `amount_billed_ngn` | Float | Total amount billed |
| `amount_paid_ngn` | Float | Total amount paid by customer |
| `paid_on_time` | Boolean | Payment timeliness indicator |
| `arrears_ngn` | Float | Outstanding arrears amount |

---

## Technologies

| Technology | Purpose |
|-----------|---------|
| **[Python 3.x](https://www.python.org/downloads/)** | Core programming language |
| **[Pandas](https://pandas.pydata.org/)** | Data manipulation and analysis |
| **[SQLAlchemy](https://www.sqlalchemy.org/)** | Database ORM and connection management |
| **[PostgreSQL](https://www.postgresql.org/)** | Data warehouse and analytics database |
| **[python-dotenv](https://pypi.org/project/python-dotenv/)** | Environment variable management |

---

## Getting Started

### Prerequisites

- Python 3.8 or higher
- PostgreSQL 12 or higher
- Git

### Installation

#### 1. Create Project Directory

```bash
mkdir energy_billing
cd energy_billing
````

#### 2. Set Up Virtual Environment

```bash
# Create virtual environment
python3 -m venv .venv

# Activate virtual environment
source .venv/bin/activate        # Linux/Mac
# OR
.venv\Scripts\activate           # Windows
```

#### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

**requirements.txt**

```txt
python-dotenv==1.0.0
pandas==2.0.0
sqlalchemy==2.0.0
psycopg2-binary==2.9.9
```

#### 4. Configure Environment Variables

Create a `.env` file in the project root:

```ini
# PostgreSQL Connection Configuration
PG_USER=postgres
PG_PASSWORD=yourpassword
PG_HOST=localhost
PG_PORT=5432
PG_DATABASE=energydb
```

>  **Security Note**: Add `.env` to `.gitignore` to prevent credential exposure.

#### 5. Create Project Structure

```bash
mkdir -p extract transform load
touch extract/extract.py transform/transform.py load/load.py
```

---

## Project Structure

```
energy_billing/
│
├── extractor/
│   └── extract.py           # Data extraction from Hugging Face
│
├── transformer/
│   └── transform.py         # Data transformation and cleaning
│
├── postgres/
│   └── load.py             # Data loading into PostgreSQL
│
│       
├── .gitignore
└── README.md            
```

---

## Pipeline Implementation

### 1. Extract Stage (`extract/extract.py`)

Fetches raw data from Hugging Face and saves locally.


### 2. Transform Stage (`transform/transform.py`)

Cleans and transforms raw data for analytics.

### 3. Load Stage (`load/load.py`)

Loads transformed data into PostgreSQL database.

---

## Running the Pipeline

```bash
# Extract data
python extract/extract.py

# Transform data
python transform/transform.py

# Load data
python load/load.py
```

---

## Acknowledgments

- Electric Sheep Africa for providing the dataset
- NERC (Nigerian Electricity Regulatory Commission) for sector reports
- The Nigerian energy sector stakeholders

---

## Support

For questions or support, please open an issue in the GitHub repository or contact [chibuezeanalyst@gmail.com]

---

**Built with ❤️ for the Nigerian Energy Sector**