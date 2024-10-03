use Mainproject;
SELECT * FROM customer_churn1 LIMIT 10;
SHOW TABLES;

# Handling Missing Values:

SELECT 
    SUM(CASE WHEN `Tenure in Months` IS NULL THEN 1 ELSE 0 END) AS MissingTenure,
    SUM(CASE WHEN `Monthly Charge` IS NULL THEN 1 ELSE 0 END) AS MissingMonthlyCharges,
    SUM(CASE WHEN `Total Charges`IS NULL THEN 1 ELSE 0 END) AS MissingTotalCharges
FROM Customer_churn1;

# Handling Outliers

SELECT `Monthly Charge`
FROM (
    SELECT `Monthly Charge`, 
           NTILE(100) OVER (ORDER BY `Monthly Charge`) AS percentile_rank
    FROM Customer_churn1
) AS ranked_data
WHERE percentile_rank = 1 OR percentile_rank = 99;

# Normalizing Features:

SELECT MIN(`Tenure in Months`) AS MinTenure, MAX(`Tenure in Months`) AS MaxTenure,
       MIN(`Monthly Charge`) AS MinMonthlyCharges, MAX(`Monthly Charge`) AS MaxMonthlyCharges
FROM Customer_churn1;

# Calculate Min and Max values and store in variables
SET @min_tenure = (SELECT MIN(`Tenure in Months`) FROM Customer_churn1);
SET @max_tenure = (SELECT MAX(`Tenure in Months`) FROM Customer_churn1);


# Ensure Target Variable is Binary (0 for retained, 1 for churned)

UPDATE Customer_churn1
SET CustomerStatus = CASE 
              WHEN CustomerStatus = 'churned' THEN 1
              WHEN CustomerStatus = 'stayed' THEN 0
              WHEN CustomerStatus = 'joined' THEN 2
              ELSE CustomerStatus
            END;
            
            # Verify the Changes:
 
 SELECT * 
FROM Customer_churn1;