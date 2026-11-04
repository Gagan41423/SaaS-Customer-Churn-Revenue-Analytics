# SaaS-Customer-Churn-Revenue-Analytics
End-to-end SaaS subscription analytics pipeline evaluating customer retention, CAC vs. LTV, and tier-based churn.
# SaaS Customer Churn & Revenue Analytics Portfolio Project

An end-to-end data analytics pipeline and relational database project evaluating customer subscription behavior, acquisition costs, lifetime revenue, and plan-level churn dynamics for a SaaS business.

---

## 🚀 Project Overview
This project simulates a real-world SaaS data analytics workflow. It demonstrates technical competency across the entire data lifecycle:
1. **Data Ingestion & Pipeline:** Using **Python (Pandas & SQLAlchemy)** to clean European date formats (`DD-MM-YYYY` to `YYYY-MM-DD`) and load 1,000 customer records into MySQL while handling complex relational constraints.
2. **Database Architecture:** Designing a normalized relational schema with primary and foreign key constraints in **MySQL**.
3. **Advanced SQL Analytics:** Writing robust queries utilizing window functions (`LAG()`, `DENSE_RANK()`), conditional aggregation, and date manipulation (`TIMESTAMPDIFF`) to extract actionable business intelligence.

---

## 🛠️ Tech Stack & Tools
* **Database & Management:** MySQL, MySQL Workbench, EER/ERD Modeling
* **Data Processing & Pipeline:** Python, Pandas, SQLAlchemy, PyMySQL
* **Version Control:** Git, GitHub

---

## 📊 Database Architecture & ERD
The database (`SAS_Analytics`) consists of three normalized relational tables linked via foreign keys:

![Database ERD](reports/erd.png) *(Note: Ensure your ERD image is saved in your reports folder)*

* **`customers`** (Primary Table): Stores demographic and lifecycle attributes including `customer_id`, `signup_date`, `plan_type`, `monthly_fee`, `acquisition_cost`, and `churn_date`.
* **`subscription`** (Relational Table): Tracks individual subscription details linked via foreign key constraint (`customer_id` referencing `customers`).
* **`revenue`** (Transactional Table): Records billing details, transaction amounts, and revenue categories tied back to each customer.

---

## ⚙️ Data Engineering & Pipeline Challenge
* **The Challenge:** Native MySQL import wizards failed due to date format discrepancies (`DD-MM-YYYY`) and foreign key protection errors (`Error 3730` & `3780`).
* **The Solution:** Developed a custom Python script leveraging **Pandas** for date string parsing and **SQLAlchemy** to safely manage transaction contexts (`SET FOREIGN_KEY_CHECKS = 0/1`) and bulk-load all 1,000 clean records without schema violations.

---

## 💡 Key Insights & Findings

By executing the analytical SQL queries on the 1,000-customer dataset (`SAS_Analytics`), the following business insights were uncovered:

1. **Plan-Level Churn Disparities:** 
   * **Basic Tier:** Experienced the highest churn rate at **17.74%** (58 churned out of 327 customers).
   * **Enterprise Tier:** Follows closely with a **17.27%** churn rate (57 churned out of 330 customers).
   * **Pro Tier:** Demonstrates the strongest retention with a lower churn rate of **15.45%** (53 churned out of 343 customers), indicating better product-market fit or satisfaction in the mid-tier.

2. **Month-over-Month (MoM) Revenue Trajectory:** 
   * Utilizing SQL window functions (`LAG()`), the analysis tracked monthly revenue streams across operational periods, revealing cash flow stability and identifying peak acquisition/expansion months.

3. **Customer Acquisition Cost (CAC) vs. Lifetime Value (LTV):** 
   * Cohort analysis segmented users by acquisition month (`DATE_FORMAT`), mapping upfront acquisition investments against cumulative subscription revenues to evaluate channel profitability.

4. **Tier-Specific Top Spenders:** 
   * Leveraging ranking window functions (`DENSE_RANK()`), top-performing customers contributing the highest lifetime revenue were isolated per plan type to help marketing teams identify high-value customer profiles.
---

## 📂 Repository Structure
```text
├── data/                    # Cleaned CSV datasets (customers, revenue, subscriptions)
├── sql_scripts/             # Database DDL schema creation and analytical query scripts
├── reports/                 # ERD diagrams and visualization exports
├── import_pipeline.py       # Python Pandas & SQLAlchemy data loading script
└── README.md                # Project portfolio documentation
