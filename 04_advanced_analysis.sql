# BUSINESS AND ANALYTICS QUERIES - PHASE 2 

# TOTAL MONTHLY REVENUE 

SELECT 
   month,
   sum(amount) AS total_revenue
FROM revenue
GROUP BY month
ORDER BY month ASC;


# CUSTOMER CHURN COUNT BY PLAN TYPE 

SELECT 
      plan_type,
      COUNT(customer_id) AS total_churned_customers
FROM customers
WHERE churn_date IS NOT NULL
GROUP BY plan_type;
      
# AVERAGE CUSTOMER ACQUISITION_COST BY PLAN_TYPE

SELECT
     plan_type,
     COUNT(customer_id) AS total_customers,
     AVG(acquisition_cost) AS avg_customer_acquisition_cost
FROM customers
GROUP BY plan_type;


# CUSTOMER LIFETIME REVENUE SUMMARY 

SELECT
     c.customer_id,
     c.plan_type,
     SUM(r.amount) AS total_lifetime_revenue
FROM customers AS c inner join 
    revenue AS  r 
 ON c.customer_id = r.customer_id
 GROUP BY c.customer_id, c.plan_type
 ORDER BY total_lifetime_revenue DESC;
 
 
 
#  MONTH OVER MONTH REVENUE GROWTH RATE 

WITH monthly_revenue AS (
SELECT 
      month,
      SUM(amount) AS total_revenue_curr
FROM revenue 
GROUP BY month 
)

SELECT 
      month,
      total_revenue_curr,
      LAG(total_revenue_curr,1) OVER(ORDER BY month) AS previous_year_revenue,
      ROUND(
      (total_revenue_curr - LAG(total_revenue_curr,1) OVER (ORDER BY month))
	   / LAG(total_revenue_curr,1) OVER (ORDER BY month) *100,2)  AS percentage_mom_growth
FROM monthly_revenue
ORDER BY month;


# CUSTOMER COHORT ANALYSIS BY SIGNUP MONTH

SELECT 
     DATE_FORMAT(c.signup_date, '%Y-%m') AS signup_cohort,
     COUNT(DISTINCT c.customer_id) AS total_acquired_customers,
     SUM(c.acquisition_cost) AS total_cohort_acquisition_cost,
     ROUND(SUM(r.amount),2) AS total_cohort_revenue
FROM customers c 
LEFT JOIN revenue r
ON c.customer_id = r.customer_id
GROUP BY signup_cohort
ORDER BY signup_cohort ASC;


# TOP RANKING CUSTOMERS FROM EACH PLAN TYPE

WITH customer_revenue AS( 
 SELECT
       c.customer_id,
       c.plan_type,
       SUM(r.amount) AS total_spent
FROM customers c INNER JOIN revenue r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.plan_type
),
RANKED_CUSTOMERS AS (
SELECT  
       customer_id,
       plan_type,
	   total_spent,
       DENSE_RANK() OVER( PARTITION BY plan_type ORDER BY total_spent DESC) AS revenue_rank
FROM customer_revenue
)

SELECT * 
FROM ranked_customers
WHERE revenue_rank <=5;


# CHURN RATE BY PLAN TYPE 

SELECT 
       plan_type,
       COUNT(customer_id) AS total_customers,
       SUM(CASE WHEN churn_date IS NOT NULL THEN 1 ELSE 0 END) AS total_churned_customers,
       ROUND(
             SUM(CASE WHEN churn_date IS NOT NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(customer_id), 
             2
       ) AS churn_percentage
FROM customers
GROUP BY plan_type;


# IDENTIFYING ACTIVE VS CHURN CUSTOMERS LIFETIME 

SELECT 
      customer_id,
      plan_type,
      signup_date,
      churn_date,
       CASE 
         WHEN churn_date IS NOT NULL THEN TIMESTAMPDIFF(month, signup_date, churn_date)
         ELSE TIMESTAMPDIFF(MONTH, signup_date, curdate())
	END AS active_duration_months
FROM customers
ORDER BY active_duration_months
LIMIT 20;
