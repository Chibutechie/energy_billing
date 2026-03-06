# Nigerian Energy & Utilities Billing Pipeline

> An end-to-end ETL pipeline for ingesting, transforming, and loading Nigerian energy billing and payment data into PostgreSQL for analytics and reporting.

![Python](https://img.shields.io/badge/Python-3.8+-3776AB?style=flat&logo=python&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-336791?style=flat&logo=postgresql&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-2.2.3-150458?style=flat&logo=pandas&logoColor=white)
![SQLAlchemy](https://img.shields.io/badge/SQLAlchemy-2.0-red?style=flat)
![License](https://img.shields.io/badge/License-MIT-green?style=flat)

---

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Dataset](#dataset)
- [Technologies](#technologies)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Configuration](#configuration)
- [Project Structure](#project-structure)
- [Pipeline Implementation](#pipeline-implementation)
- [Usage](#usage)
- [Roadmap](#roadmap)
- [Acknowledgments](#acknowledgments)
- [Support](#support)

---

## Overview

The Nigerian electricity and utilities sector faces significant challenges around revenue collection and billing transparency. Distribution Companies (DisCos) collected only ₦210 billion out of ₦303 billion billed to customers in Q4 2021 — a collection efficiency gap driven by estimated billing, non-metered customers, and limited data visibility ([source](https://nairametrics.com/2022/09/25/discos-collected-n210-billion-out-of-n303-billion-billed-to-customers-in-q4-2021)).

This pipeline addresses those challenges by providing stakeholders — utilities companies, regulators, and analysts — with a reliable, automated data foundation for decision-making.

### Key Capabilities

- Automated batch ingestion from Hugging Face (Parquet format)
- Data cleaning, validation, and transformation
- Centralized PostgreSQL data warehouse optimized for analytics
- Insights into billing efficiency, revenue leakage, and customer payment behavior

---

## Architecture

![Architecture](assests\image.png)

---

| Stage         | Description                                                          |
| ------------- | -------------------------------------------------------------------- |
| **Extract**   | Fetches raw `.parquet` data from the Hugging Face dataset repository |
| **Transform** | Cleans, validates, and structures data for analytics consumption     |
| **Load**      | Writes transformed records into the `energydb` PostgreSQL database   |

---

## Dataset

**Source**: [electricsheepafrica/nigerian_energy_and_utilities_billing_payments](https://huggingface.co/datasets/electricsheepafrica/nigerian_energy_and_utilities_billing_payments)

### Schema

| Column              | Type    | Description                         |
| ------------------- | ------- | ----------------------------------- |
| `customer_id`       | String  | Unique identifier for each customer |
| `disco`             | String  | Distribution Company name           |
| `billing_month`     | String  | Month and year of the billing cycle |
| `tariff_band`       | String  | Customer tariff classification      |
| `kwh`               | Float   | Kilowatt-hours consumed             |
| `price_ngn_kwh`     | Float   | Price per kWh in Nigerian Naira     |
| `amount_billed_ngn` | Float   | Total amount billed                 |
| `amount_paid_ngn`   | Float   | Total amount paid by customer       |
| `paid_on_time`      | Boolean | Whether payment was made on time    |
| `arrears_ngn`       | Float   | Outstanding arrears amount          |

---

## Technologies

| Technology                                                   | Version | Purpose                                |
| ------------------------------------------------------------ | ------- | -------------------------------------- |
| [Python](https://www.python.org/downloads/)                  | 3.8+    | Core programming language              |
| [Pandas](https://pandas.pydata.org/)                         | 2.2.3   | Data manipulation and transformation   |
| [SQLAlchemy](https://www.sqlalchemy.org/)                    | 2.0.36  | Database ORM and connection management |
| [PostgreSQL](https://www.postgresql.org/)                    | 18      | Data warehouse and analytics database  |
| [python-dotenv](https://pypi.org/project/python-dotenv/)     | 1.0.1   | Environment variable management        |
| [Datasets](https://huggingface.co/docs/datasets/)            | 2.19.0  | Hugging Face dataset library           |
| [psycopg2-binary](https://pypi.org/project/psycopg2-binary/) | 2.9.9   | PostgreSQL adapter for Python          |

---

## Getting Started

### Prerequisites

Ensure the following are installed on your system before proceeding:

- Python 3.8 or higher
- PostgreSQL 18
- Git
- pip

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/your-username/energy_billing.git
cd energy_billing
```

**2. Create and activate a virtual environment**

```bash
python3 -m venv .venv

# Linux / macOS
source .venv/bin/activate

# Windows
.venv\Scripts\activate
```

**3. Install dependencies**

```bash
pip install -r requirements.txt
```

`requirements.txt`:

```
pandas==2.2.3
datasets==2.19.0
sqlalchemy==2.0.36
python-dotenv==1.0.1
psycopg2-binary==2.9.9
```

### Configuration

**4. Set up environment variables**

Create a `.env` file in the project root:

```ini
# PostgreSQL Connection
PG_USER=postgres
PG_PASSWORD=yourpassword
PG_HOST=localhost
PG_PORT=5432
PG_DATABASE=energydb

# Dataset Source
API_URL=https://huggingface.co/datasets/electricsheepafrica/nigerian_energy_and_utilities_billing_payments/resolve/main/nigerian_energy_and_utilities_billing_payments.parquet
```

> ⚠️ **Security**: Add `.env` to your `.gitignore` to prevent credentials from being committed to version control.

**5. Scaffold the project directories**

```bash
mkdir -p etl_pipeline
touch etl_pipeline/extract.py
touch etl_pipeline/transform.py
touch etl_pipeline/load.py
```

---

## Project Structure

```
energy_billing/
│
├── etl_pipeline/
│   ├── extract.py          # Stage 1: Fetch raw data from Hugging Face
│   ├── transform.py        # Stage 2: Clean and validate data
│   └── load.py             # Stage 3: Load data into PostgreSQL
│
├── assets/
│   └── architecture.png    # Pipeline architecture diagram
│
├── requirements.txt        # Python dependencies
├── .env                    # Environment variables (not committed)
├── .gitignore
└── README.md
```

---

## Pipeline Implementation

### Stage 1 — Extract (`etl_pipeline/extract.py`)

Connects to the Hugging Face dataset repository and downloads the source `.parquet` file for local processing. Handles connection errors and saves raw data to the working directory.

### Stage 2 — Transform (`etl_pipeline/transform.py`)

Applies the following transformations to the raw dataset:

- Removes duplicate and null records
- Validates data types and enforces schema constraints
- Derives calculated fields (e.g., collection efficiency ratio)
- Standardizes column formats for warehouse compatibility

### Stage 3 — Load (`etl_pipeline/load.py`)

Establishes a connection to the `energydb` PostgreSQL database via SQLAlchemy and writes the cleaned DataFrame to the target table. Handles upserts and connection lifecycle management.

---

## Usage

Run each pipeline stage individually for development and debugging, or chain them sequentially for a full pipeline execution.

```bash
# Stage 1: Extract raw data
python etl_pipeline/extract.py

# Stage 2: Transform and clean data
python etl_pipeline/transform.py

# Stage 3: Load data into PostgreSQL
python etl_pipeline/load.py
```

---

## Roadmap

Planned enhancements for future releases:

- [ ] Data validation tests
- [ ] Incremental loading support
- [ ] Interactive dashboard with Plotly / Streamlit
- [ ] Automated scheduling with Apache Airflow
- [ ] Data quality monitoring and alerting
- [ ] REST API endpoint for real-time queries
- [ ] Docker containerization for easy deployment
- [ ] Unit and integration test coverage

---

## Acknowledgments

- **[Electric Sheep Africa](https://huggingface.co/electricsheepafrica)** — for providing the comprehensive billing dataset
- **[NERC](https://nerc.gov.ng/)** — Nigerian Electricity Regulatory Commission, for sector reports and guidance
- Nigerian energy sector stakeholders working to improve data transparency

---

## Additional Resources

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Pandas User Guide](https://pandas.pydata.org/docs/user_guide/index.html)
- [SQLAlchemy Tutorial](https://docs.sqlalchemy.org/en/20/tutorial/)
- [python-dotenv Docs](https://pypi.org/project/python-dotenv/)
- [NERC Sector Reports](https://nerc.gov.ng/)

---

## Support

For questions, issues, or contributions, reach out via:

- 📧 Email: [chibuezeanalyst@gmail.com](mailto:chibuezeanalyst@gmail.com)
- 🐛 Issues: Open a [GitHub Issue](https://github.com/your-username/energy_billing/issues)

---

_Built with ❤️ for the Nigerian Energy Sector_
