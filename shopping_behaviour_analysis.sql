SELECT *
 FROM shopping_behavior;
 
CREATE TABLE customer_shopping_behavior_analysis
LIKE shopping_behavior;
 
SELECT *
 FROM customer_shopping_behavior_analysis;
 
INSERT INTO customer_shopping_behavior_analysis
SELECT *
FROM shopping_behavior;





SELECT *
 FROM customer_shopping_behavior_analysis;
 
-- Q1. what is the total revenu generaterd by male and female ;

ALTER TABLE customer_shopping_behavior_analysis
RENAME COLUMN purchasae_amount TO purchase_amount;

	SELECT gender, SUM(purchase_amount) AS revenue
    FROM customer_shopping_behavior_analysis
    GROUP by gender;
 
 
-- Q2. whch customer used discount but still spent more than average purchase amount

SELECT customer_id,purchase_amount
FROM  customer_shopping_behavior_analysiS
WHERE discount_applied ='Yes' AND purchase_amount >=(SELECT AVG(purchase_amount) FROM customer_shopping_behavior_analysis);


-- Q3. WHICH ARE THE TOP 5 PRODUCTS WITH THE HIGHEST AVERAGE REVENUE RATE;

SELECT item_purchased, ROUND(AVG(review_rating),1) AS 'avg product rating'
FROM customer_shopping_behavior_analysis
GROUP BY item_purchased
ORDER BY AVG(review_rating) DESC
LIMIT 5;


-- Q4. COMPARE THE AVERAGE PURCHASE AMOUNT BETWEEN STANDARD AND EXPRSS SHIPPING;

SELECT shipping_type,
ROUND(AVG(purchase_amount),2) AS 'avg purchase amount'
	FROM customer_shopping_behavior_analysiS
    WHERE shipping_type IN ('Standard','Express')
    GROUP BY shipping_type;


-- Q5. Do subscribed customer spend more? Compare average spend and total revanue between subscribed and unsubscribed customer

SELECT 
    subscription_status, 
    COUNT(customer_id) AS total_customers, 
    ROUND(AVG(purchase_amount), 2) AS avg_spend, 
    ROUND(SUM(purchase_amount), 2) AS total_revenue 
FROM 
    customer_shopping_behavior_analysis 
GROUP BY 
    subscription_status 
ORDER BY 
    total_revenue , avg_spend DESC;
    

-- Q6. Which 5 products have the highest percentage of purchases with discount applied:

SELECT item_purchased,
ROUND(100 * SUM(CASE WHEN discount_applied ='Yes' THEN 1 ELSE 0 END)/ COUNT(*),2) AS discount_rate
FROM customer_shopping_behavior_analysis
GROUP BY item_purchased
ORDER BY discount_rate DESC
LIMIT 5;


-- Q7. Segment customer into new, returning and loyal based on their total number of  previous purchases, and show the countn of each segment :

WITH customer_type AS (
SELECT
 customer_id,
previous_purchases,
CASE
    WHEN previous_purchases= 1 THEN 'New'
    WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
    ELSE 'Loyal'
    END AS customer_segment
FROM customer_shopping_behavior_analysis
)

SELECT customer_segment, COUNT(*) AS 'Number_of_customer'
FROM customer_type
GROUP BY customer_segment
ORDER BY Number_of_customer DESC;


-- Q8. Are customers who repeat buyers (more than 5 previous purchases) as likely to subscribed ?

SELECT subscription_status,
COUNT(customer_id) AS repeat_buyers
FROM customer_shopping_behavior_analysis
WHERE previous_purchases > 5
GROUP BY subscription_status;


-- Q9.what is the revenue contribution each  age group:

SELECT age_group, SUM(purchase_amount) AS total_revenue
FROM customer_shopping_behavior_analysis
GROUP BY age_group
ORDER BY total_revenue DESC;






SELECT *
 FROM customer_shopping_behavior_analysis;
 


