# Payment-Failure-Fraud-Risk-Analysis
**End-to-End Data Analytics Project using SQL, Python & Power BI**

## Overview
This project analyzes payment transaction data to identify **fraud patterns, high-risk behaviors, and data quality issues**. It combines **SQL, Python, and Power BI** to deliver actionable insights and a rule-based fraud detection approach.

## Problem Statement
Fraudulent transactions in digital payments lead to significant financial losses. Detecting fraud is challenging due to:
- Complex user behavior  
- High transaction volume  
- Missing or incomplete data signals  

This project builds a **data-driven fraud analysis system** to identify high-risk transactions and improve detection strategies.

## Objectives
- Analyze transaction data to uncover fraud patterns  
- Identify high-risk segments (payment method, geography, behavior)  
- Perform behavioral and time-based analysis  
- Build a **risk scoring model** to classify transactions  
- Generate insights for fraud prevention  

## 🛠️ Tools & Technologies
- **SQL** → Data extraction, KPI calculation, fraud segmentation  
- **Python (Pandas, NumPy, Matplotlib)** → Data cleaning, feature engineering, analysis  
- **Power BI** → Interactive dashboards & visualization  

## 📊 Dataset Summary
- Total Transactions: **200**  
- Fraud Transactions: **54**  
- Fraud Rate: **27%**  
- Missing Device Data: **37%**  


## Key Analysis Performed
### 1. SQL Analysis
- Fraud rate calculation  
- Payment method risk analysis  
- Time-based trends  
- Merchant & transaction behavior analysis  

### 2. Python Analysis
- Data cleaning & preprocessing  
- Feature engineering (hour, amount bucket, device flag)  
- Behavioral analysis (device, status, international)  
- Risk scoring model development  
- Data visualization  

### 3. Power BI Dashboard
- Overview dashboard (KPIs & trends)  
- Fraud analysis dashboard (patterns & drivers)  
- Risk & data quality dashboard  

## Key Insights
- Crypto transactions show **~95% fraud rate**, making them the highest-risk channel  
- High-value transactions (> ₹10K) have **~89% fraud probability**  
- International transactions are **~3.5x more likely** to be fraudulent  
- Fraud peaks during **early morning hours (3 AM – 6 AM)**  
- Failed transactions show **~89% fraud rate**, indicating strong fraud signals  
- **37% of transactions have missing device data**, with significantly higher fraud risk  

## Data Quality Findings
- Missing device IDs significantly impact fraud detection  
- Transactions without device data show **~5x higher fraud likelihood**  
- Fraud reason field contains missing values, limiting root cause analysis  

## Risk Scoring Model
A **rule-based risk scoring system** was developed using:
- High transaction amount  
- International transactions  
- Online entry mode  
- Failed transaction status  

### Risk Buckets:
- **High Risk** → ~100% fraud  
- **Medium Risk** → ~92% fraud  
- **Low Risk** → ~10% fraud  

The model captures **90%+ fraud cases in medium/high-risk segments**

## 💡 Business Recommendations
- Strengthen monitoring for **crypto and international transactions**  
- Flag transactions with **missing device information**  
- Implement stricter checks for **high-value payments**  
- Improve **fraud labeling system (fraud_reason field)**  
- Deploy risk scoring for **real-time fraud detection**  
