with credit_risk_table as (select customers.customer_id as customer_id, concat(customers.first_name, ' ' , customers.last_name) as Customer_Full_Name,
		branches.branch_name as Branch_Name, customers.annual_income as annual_income
		, customers.credit_score as credit_score, sum(account.balance) as Combined_Balance,
        case
			when customers.credit_score < 500 then 1
			else 0
			end as credit_risk_flag
from customers
inner join account on account.customer_id = customers.customer_id
inner join branches on account.branch_id = branches.branch_id
group by customer_id, customer_full_name, branch_name, annual_income, credit_score
# customers with lesser credit_score are a risk of not paying their loan on time if provided with a loan
# (risk_criteria_1) (30 points)
)
,
negative_balance_table as (select customer_id, customer_full_name, Branch_Name, credit_score, combined_balance,annual_income,credit_risk_flag,
		case
			when combined_balance  <0 then 1
            else 0
            end as negative_balance_flag
from credit_risk_table
# customers having negative balance in their accounts, signaling higher risk of not paying back a loan given 
# (risk_criteria_2) (20 points)
)
,
loan_risk_table as (select negative_balance_table.customer_id as customer_id, customer_full_name, Branch_Name, combined_balance, credit_score, annual_income,
		coalesce(sum(loans.loan_amount),0) as total_loan_amount, 
		coalesce(COUNT(DISTINCT loans.loan_id),0) as total_loans,
        coalesce(((sum(loans.loan_amount))/(annual_income)),0) as loan_income_ratio, credit_risk_flag, negative_balance_flag,
		case
			when ((sum(loans.loan_amount))/(annual_income)) > 3 then 1
            else 0
				end as loan_risk_flag
from negative_balance_table
left join loans on loans.customer_id = negative_balance_table.customer_id
group by customer_id, customer_full_name, Branch_Name, combined_balance, credit_score, annual_income,credit_risk_flag, negative_balance_flag
# loan and income compared as a ratio to determine which customer is capable of paying back a given loan given their annual_income 
# (risk_criteria_3) (25 points)
)
,
complaint_risk_table as (SELECT loan_risk_table.customer_id as customer_id, customer_full_name, Branch_Name, credit_score, combined_balance,total_loans
			, total_loan_amount, coalesce(count(distinct complaints.complaint_id),0) as total_complaints,
            credit_risk_flag, negative_balance_flag, loan_risk_flag,
		case 
			when count(complaints.complaint_id) >=3 then 1
            else 0
            end as complaint_risk_flag
FROM loan_risk_table
left join complaints on loan_risk_table.customer_id = complaints.customer_id
group by customer_id, customer_full_name, Branch_Name, credit_score,total_loans, total_loan_amount, combined_balance, credit_risk_flag, 
			negative_balance_flag, loan_risk_flag
# customers having complaints with the bank signal a higher risk of attrition leading to reduction in market capture and customer base
# (risk_criteria_4) (25 points)
)
,
risk_score_table AS (
    SELECT *,
           (credit_risk_flag * 30)
         + (negative_balance_flag * 20)
         + (loan_risk_flag * 25)
         + (complaint_risk_flag * 25)
         AS risk_score
    FROM complaint_risk_table
# calculated the risk score beforehand so that it is easier for me to reference each column in the final query
)
,

risk_band_table as (select *, case
			when risk_score >= 75 then 'Critical'
            when risk_score >= 50 then 'High'
            when risk_score >= 30 then 'Medium'
            else 'Low'
            end as risk_band
from risk_score_table
# calculates the risk_bank of customers and ranks the severity as critical, high, medium and low.
)

SELECT
    branch_name,
    COUNT(*) AS high_risk_customers
FROM customer_distress_profile
WHERE risk_band IN ('High','Critical')
GROUP BY branch_name
ORDER BY high_risk_customers DESC
LIMIT 10;

