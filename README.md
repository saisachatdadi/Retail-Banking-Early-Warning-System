# Retail Banking Customer Distress & Early Warning System

## Project Overview

This project was developed to identify customers showing early signs of financial distress using a SQL-based risk scoring framework and Power BI reporting solution.

The objective was to build an Early Warning System that helps retail banking teams proactively identify customers at elevated risk before issues such as loan delinquency, default, or customer attrition occur.

The solution combines data quality validation, risk modelling, customer segmentation and dashboard reporting to support data-driven decision making.

---

## Business Problem

Retail banks often react to customer risk after a problem has already occurred.

This project was designed to answer the following questions:

* Which customers show signs of financial distress?
* Which customers require immediate review?
* Which branches contain the highest concentrations of risky customers?
* How can management proactively monitor customer risk across the portfolio?

---

## Dataset

The project uses a retail banking dataset containing approximately 50,000 customer records across multiple business domains:

* Customers
* Accounts
* Loans
* Complaints
* Branches
* Products
* Customer Interactions

The data was modelled and analysed using SQL before being visualised in Power BI.

---

## Data Quality Investigation

Before building the risk model, several data quality checks were performed.

### Duplicate Identity Investigation

Customer email addresses were analysed to identify potential duplicate customer records.

### Negative Balance Investigation

4,752 accounts were identified with negative balances and further analysed as part of the customer risk assessment process.

### Relationship Validation

Relationships between customers, accounts, loans, complaints and branches were validated to ensure reporting accuracy and consistency.

---

## Risk Scoring Methodology

A customer risk score was developed using four risk indicators.

| Risk Factor              | Weight |
| ------------------------ | -----: |
| Credit Score Below 500   |     30 |
| Negative Account Balance |     20 |
| Loan Burden Ratio > 3    |     25 |
| Three Or More Complaints |     25 |

### Risk Score Formula

Risk Score = Credit Risk + Negative Balance Risk + Loan Burden Risk + Complaint Risk

Maximum Risk Score = 100

---

## Risk Classification

| Risk Score | Risk Band |
| ---------- | --------- |
| 75+        | Critical  |
| 50-74      | High      |
| 30-49      | Medium    |
| 0-29       | Low       |

---

## Results

| Risk Band | Customers |
| --------- | --------: |
| Low       |    40,706 |
| Medium    |     8,857 |
| High      |       436 |
| Critical  |         1 |

### Portfolio Summary

* Total Customers: 50,000
* High Risk Customers: 436
* Critical Customers: 1
* High Risk + Critical Population: 437 Customers
* Less than 1% of the customer portfolio was classified as High Risk or Critical Risk.

---

## Key Findings

### Branch Risk Concentration

Customer risk was not evenly distributed across the branch network.

The highest concentrations of high-risk customers were identified in:

* Mullingar Business
* Castlebar Quay
* Longford Quay

### Negative Balance Accounts

4,752 accounts were operating with negative balances, representing a key distress indicator within the portfolio.

### Critical Customer Identification

The model successfully identified a single Critical Risk customer requiring immediate review.

### Portfolio Health

The majority of customers were classified as Low Risk, indicating an overall healthy customer portfolio.

---

## Dashboard Pages

### Page 1 – Executive Overview

Provides portfolio-level visibility into:

* Total Customers
* Average Risk Score
* High Risk Customers
* Critical Customers
* Customer Risk Distribution
* Risk Score Distribution
* Top 10 Branches by High-Risk Customers

### Page 2 – Customer Investigation

Allows analysts to:

* Filter by Risk Band
* Filter by Branch
* Filter by Risk Score
* Investigate individual customers
* Identify drivers behind customer risk scores

---

## Dashboard Screenshots

### Executive Overview

![Executive Overview](Images/Executive_Overview.png)

### Customer Investigation

![Customer Investigation](Images/Customer_Investigation.png)

---

## Technologies Used

* SQL
* MySQL
* Power BI
* Data Modelling
* Data Quality Validation
* Risk Analytics

---

## Repository Structure

```text
Retail-Banking-Early-Warning-System

├── SQL
├── PowerBI
├── Images
├── Documentation
└── README.md
```

---

## Future Improvements

Potential enhancements for future versions include:

* Machine Learning based risk prediction
* Time-series customer behaviour monitoring
* Automated alert generation
* Customer churn prediction integration
* Branch-level risk trend analysis

---

## Author

Sai Sachat Dadi

Portfolio Project developed using SQL, MySQL and Power BI.
