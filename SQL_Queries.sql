-- Title: Payment Failure & Fraud Risk Analysis

#SECTION 1: Business Overview (Basics – MUST HAVE)

#Q1. What is the total number of transactions and fraud cases?
select count(*) as total_txn, sum(fraud_label) as fraud_txn 
from payment_fraud;

#Q2. What is the overall fraud rate?
select round(100 * sum(fraud_label)/count(*),2) as fraud_rate 
from payment_fraud;

#Q3. How are transactions distributed across payment methods?
select payment_method, count(*) as total_txn
from payment_fraud 
group by payment_method;

#Q4. Which payment methods have the highest fraud rate?
select payment_method, 
       round(100 * sum(fraud_label)/count(*),2) as fraud_rate
from payment_fraud 
group by payment_method 
order by fraud_rate desc;

#SECTION 2: Time & Behavior Analysis
#Q5. What is the daily transaction trend?
select date(transaction_datetime) as txn_date, count(*) as total_txn
from payment_fraud 
group by txn_date 
order by txn_date;

#Q6. At what hours does fraud occur the most?
select hour(transaction_datetime) as txn_hour, 
       round(100 * sum(fraud_label)/count(*),2) as fraud_rate
from payment_fraud 
group by txn_hour 
order by fraud_rate desc;

#Q7. Does international transaction increase fraud risk?
select is_international, 
       round(100 * sum(fraud_label)/count(*),2) as fraud_rate
from payment_fraud 
group by is_international;

#SECTION 3: Fraud Drivers
#Q8. What are the top fraud reasons?
select fraud_reason, count(*) as total_cases 
from payment_fraud 
where fraud_label = 1
group by fraud_reason 
order by total_cases desc;

#Q9. Which merchant categories have high fraud risk?
select merchant_category_code, 
       count(*) as total_txn, 
       round(100 * sum(fraud_label)/count(*),2) as fraud_rate
from payment_fraud 
group by merchant_category_code
having count(*) >= 5
order by fraud_rate desc;

#Q10. Are high-value transactions more prone to fraud?
select transaction_id, transaction_datetime, amount
from payment_fraud
where amount > (select avg(amount) from payment_fraud);

#SECTION 4: Behavioral Fraud Detection (ADVANCED)
#Q11. Does missing device info increase fraud risk?
select 
    case 
        when device_id is null or device_id = '' then 'missing_device'
        else 'known_device'
    end as device_status,
    count(*) as total_txn,
    sum(fraud_label) as fraud_txn,
    round(100 * sum(fraud_label)/count(*),2) as fraud_rate
from payment_fraud
group by device_status;


#Q12. Do high-value transactions contribute more to fraud?
select 
    case 
        when amount < 1000 then 'low'
        when amount between 1000 and 10000 then 'medium'
        else 'high'
    end as amount_bucket,
    count(*) as total_txn,
    sum(fraud_label) as fraud_txn,
    round(100 * sum(fraud_label)/count(*),2) as fraud_rate
from payment_fraud
group by amount_bucket
order by fraud_rate desc;


#SECTION 5: Risk Modeling
#Q13. How can we assign a risk score to each transaction?
select transaction_id, amount, is_international, entry_mode,
(
    case when amount > 50000 then 2 else 0 end +
    case when is_international then 2 else 0 end +
    case when entry_mode = 'online' then 1 else 0 end +
    case when transaction_status = 'failed' then 1 else 0 end
) as risk_score
from payment_fraud;

#Q14. How effective is the risk model in identifying fraud?
with risk_calc as (
    select *,
    (
        case when amount > 50000 then 2 else 0 end +
        case when is_international then 2 else 0 end +
        case when entry_mode = 'online' then 1 else 0 end +
        case when transaction_status = 'failed' then 1 else 0 end
    ) as risk_score
    from payment_fraud
)

select 
    case 
        when risk_score >= 4 then 'high_risk'
        when risk_score >= 2 then 'medium_risk'
        else 'low_risk'
    end as risk_bucket,
    count(*) as total_txn,
    sum(fraud_label) as fraud_txn,
    round(100 * sum(fraud_label)/count(*),2) as fraud_rate
from risk_calc
group by risk_bucket
order by fraud_rate desc;

#SECTION 6: Data Quality & Failure Analysis
#Q15. What % of transactions have missing device info?
select 
    count(*) as total_txn,
    sum(case when device_id is null or device_id = '' then 1 else 0 end) as missing_device,
    round(100 * sum(case when device_id is null or device_id = '' then 1 else 0 end)/count(*),2) as missing_pct
from payment_fraud;

#Q16. Do failed transactions indicate higher fraud risk?
select 
    transaction_status,
    count(*) as total_txn,
    sum(fraud_label) as fraud_txn,
    round(100 * sum(fraud_label)/count(*),2) as fraud_rate
from payment_fraud
group by transaction_status;