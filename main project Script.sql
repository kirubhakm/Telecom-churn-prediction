create schema finalproject;
USE finalproject;
SELECT * FROM customer_churn1 LIMIT 10;
DESCRIBE customer_churn1;
SELECT * FROM customer_churn1 WHERE Gender IS NULL;
SELECT * FROM customer_churn1 WHERE Contract IS NULL;
SELECT * FROM customer_churn1 WHERE CustomerStatus IS NULL;
SELECT * FROM customer_churn1 WHERE 'Avg Monthly Long Distance Charges' IS NULL;
SELECT COUNT(*) AS total_customers
FROM customer_churn1;


 #total number of customers and the churn rate
SELECT   
    COUNT(*) AS total_customers,
    SUM(CASE WHEN CustomerStatus = 'churned' THEN 1 ELSE 0 END) AS churned_customers,
    (SUM(CASE WHEN CustomerStatus = 'churned' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS churn_rate_percentage
FROM customer_churn1;

#Average age of churned customer
SELECT 
    AVG(age) AS average_age_of_churned_customers
FROM 
    customer_churn1
WHERE 
    customerstatus = 'churned';  
    
    #Most common contract types among churned customers
SELECT 
    contract, 
    COUNT(*) AS churn_count
FROM 
    customer_churn1
WHERE 
    customerstatus = 'churned'  
GROUP BY 
    contract
ORDER BY 
    churn_count DESC;  

#distribution of monthly charges among churned customers
SELECT 
    AVG(`Monthly Charge`) AS average_monthly_charge,
    MIN(`Monthly Charge`) AS min_monthly_charge,
    MAX(`Monthly Charge`) AS max_monthly_charge,
    STDDEV(`Monthly Charge`) AS stddev_monthly_charge,
    COUNT(*) AS number_of_churned_customers
FROM 
    customer_churn1
WHERE 
    customerstatus = 'churned';  
    
  # To identify the contract types that are most prone to churn  
SELECT 
    contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN customerstatus = 'churned' THEN 1 ELSE 0 END) AS churned_customers,
    (SUM(CASE WHEN customerstatus = 'churned' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS churn_rate_percentage
FROM 
    customer_churn1
GROUP BY 
    contract
ORDER BY 
    churn_rate_percentage DESC;
    
    #Identify customers with high total charges who have churned
SELECT 
    `Customer ID`,  
    `Total Charges`,
    CustomerStatus
FROM 
    customer_churn1
WHERE 
   customerstatus = 'churned'  
ORDER BY 
    `Total Charges` DESC
 LIMIT 20;
 
 
 #total charges distribution for churned and non-churned customers
 SELECT 
    customerstatus,  -- Churned or not
    COUNT(*) AS num_customers,  -- Total number of customers in each group
    SUM(`Total Charges`) AS total_charges_sum,  -- Total charges sum for each group
    AVG(`Total Charges`) AS avg_total_charges,  -- Average total charges per customer
    MIN(`Total Charges`) AS min_total_charges,  -- Minimum total charges in each group
    MAX(`Total Charges`) AS max_total_charges   -- Maximum total charges in each group
FROM 
    customer_churn1
GROUP BY 
    customerstatus;

#the average monthly charges for different contract types among churned customers
SELECT 
    contract,  -- Group by the type of contract
    AVG(`Monthly Charge`) AS avg_monthly_charges  -- Calculate the average monthly charges
FROM 
    customer_churn1
WHERE 
    customerstatus = 'churned'  -- Filter for only churned customers
GROUP BY 
    contract;  -- Group the results by contract type

#Identify customers who have both online security and online backup services and have not churned
SELECT 
    `Customer ID`,  -- Replace with the correct column for the customer ID
    `Online Security`, 
    `Online Backup`, 
    customerstatus
FROM 
    customer_churn1
WHERE 
    `Online Security` = 'Yes'  -- Customers with online security service
    AND `Online Backup` = 'Yes'  -- Customers with online backup service
    AND customerstatus = 'Stayed';  -- Filter for customers who have not churned


 #the most common combinations of services among churned customers
SELECT 
    `Online Security`, 
    `Online Backup`, 
    `Device Protection Plan`, 
    `Streaming TV`, 
    `Streaming Movies`, 
    `Premium Tech Support`,
    `Streaming Music`,
    COUNT(*) AS count_customers  -- Count the number of customers for each combination
FROM 
    customer_churn1
WHERE 
    customerstatus = 'churned'  -- Only churned customers
GROUP BY 
     `Online Security`, 
    `Online Backup`, 
    `Device Protection Plan`, 
    `Streaming TV`, 
    `Streaming Movies`, 
    `Premium Tech Support`,
    `Streaming Music`  -- Group by all services to find combinations
ORDER BY 
    count_customers DESC  -- Sort by most common combinations first
LIMIT 20;  -- Limit the result to the top 20 combinations


# Identify the average total charges for customers grouped by gender and marital status

SELECT 
    Gender, 
    Married, 
    AVG(`Total Charges`) AS avg_total_charges  -- Calculate the average total charges
FROM 
    customer_churn1
GROUP BY 
    gender, 
    Married;  -- Group the results by gender and marital status
    
    
# the average monthly charges for different age groups among churned customers

SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        WHEN age BETWEEN 56 AND 65 THEN '56-65'
        ELSE '66 and above' 
    END AS age_group,  -- Create age groups
    AVG(`Monthly Charge`) AS avg_monthly_charges  -- Calculate the average monthly charges
FROM 
    customer_churn1
WHERE 
    customerstatus = 'churned'  -- Only churned customers
GROUP BY 
    age_group;  -- Group the results by age group


# the average age and total charges for customers with multiple lines and online backup

SELECT 
    AVG(age) AS avg_age,  -- Calculate the average age
    AVG(`Total Charges`) AS avg_total_charges  -- Calculate the average total charges
FROM 
    customer_churn1
WHERE 
    `Multiple Lines` = 'Yes'  -- Filter for customers with multiple lines
    AND `Online Backup` = 'Yes';  -- Filter for customers with online backup


# the contract types with the highest churn rate among senior citizens (age 65 and over)

SELECT 
    contract,  -- Select the contract type
    COUNT(*) AS total_customers,  -- Total customers in each contract type
    SUM(CASE WHEN customerstatus = 'churned' THEN 1 ELSE 0 END) AS churned_customers,  -- Count churned customers
    (SUM(CASE WHEN customerstatus = 'churned' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS churn_rate_percentage  -- Calculate churn rate
FROM 
    customer_churn1
WHERE 
    age >= 65  -- Filter for senior citizens
GROUP BY 
    contract -- Group by contract type
ORDER BY 
    churn_rate_percentage DESC;  -- Order by churn rate percentage in descending order


 # the average monthly charges for customers who have multiple lines and streaming TV
 
 SELECT 
    AVG(`Monthly Charge`) AS avg_monthly_charges  -- Calculate the average monthly charges
FROM 
    customer_churn1
WHERE 
    `Multiple Lines` = 'Yes'  -- Filter for customers with multiple lines
    AND `Streaming TV`= 'Yes';  -- Filter for customers with streaming TV


# the customers who have churned and used the most online services

SELECT 
    `Customer ID`,  -- Select customer ID
    `Online Security`,  -- Assume these are your online service columns
    `Online Backup`,
    `Streaming TV`,
    (CASE WHEN `Online Security` = 'Yes' THEN 1 ELSE 0 END +
     CASE WHEN `Online Backup` = 'Yes' THEN 1 ELSE 0 END +
     CASE WHEN `Streaming TV` = 'Yes' THEN 1 ELSE 0 END) AS total_online_services  -- Count total online services used
FROM 
    customer_churn1
WHERE 
    customerstatus = 'churned'  -- Filter for churned customers
ORDER BY 
    total_online_services DESC  -- Order by the total number of online services used
LIMIT 20;  -- Limit to the top 20 customers with the most online services


# average age and total charges for customers with different combinations of streaming services

SELECT 
    `Streaming TV`,  -- Group by streaming TV usage
    `Streaming Movies`,  -- Group by streaming movies usage
    AVG(age) AS avg_age,  -- Calculate average age for each combination
    AVG(`Total Charges`) AS avg_total_charges  -- Calculate average total charges for each combination
FROM 
    customer_churn1
GROUP BY 
    `Streaming TV`,  -- Group by streaming TV usage
    `Streaming Movies`  -- Group by streaming movies usage
ORDER BY 
    `Streaming TV`, `Streaming Movies`;


# Identify the gender distribution among customers who have churned and are on yearly contracts

SELECT 
    gender,  -- Select the gender of the customers
    COUNT(*) AS customer_count  -- Count the number of customers for each gender
FROM 
    customer_churn1
WHERE 
    customerstatus = 'churned'  -- Filter for customers who have churned
    AND contract = 'one year'  -- Filter for customers with yearly contracts
GROUP BY 
    gender;  -- Group the results by gender


# Calculate the average monthly charges and total charges for customers who have churned, grouped by contract type and internet service type

SELECT 
    contract,  -- Group by contract type
    `Internet Service`,  -- Group by internet service type
    AVG(`Monthly Charge`) AS avg_monthly_charges,  -- Calculate average monthly charges
    AVG(`Total Charges`) AS avg_total_charges  -- Calculate average total charges
FROM 
    customer_churn1
WHERE 
    customerstatus = 'churned'  -- Filter for churned customers
GROUP BY 
    contract,  -- Group by contract type
   `Internet Service`  -- Group by internet service type
ORDER BY 
    contract, `Internet Service`;


# to Find the customers who have churned and are not using online services, and their average total charges

SELECT 
    COUNT(*) AS churned_customers,  -- Count the number of customers who have churned and don't use online services
    AVG(`Total Charges`) AS avg_total_charges  -- Calculate the average total charges for these customers
FROM 
    customer_churn1
WHERE 
    customerstatus = 'churned'  -- Filter for customers who have churned
    AND `Online Security` = 'No'  -- Customers not using online security
    AND `Online Backup` = 'No';  -- Customers not using online backup
    
    
    # Calculate the average monthly charges and total charges for customers who have churned, grouped by the number of dependents

SELECT 
    `Number of Dependents`,  -- Group by the number of dependents
    AVG(`Monthly Charge`) AS avg_monthly_charges,  -- Calculate the average monthly charges
    AVG(`Total Charges`) AS avg_total_charges  -- Calculate the average total charges
FROM 
    customer_churn1
WHERE 
    customerstatus = 'churned'  -- Filter for customers who have churned
GROUP BY 
    `Number of Dependents` -- Group by the number of dependents
ORDER BY 
    `Number of Dependents`;

# Identify the customers who have churned, and their contract duration in months (for monthly contracts)

SELECT 
    `Customer ID`,  -- Customer identifier
    `Tenure in Months` AS contract_duration_in_months,  -- Use tenure as the contract duration in months
    `Total Charges`  -- Include total charges for reference (optional)
FROM 
    customer_churn1
WHERE 
    customerstatus = 'churned'  -- Filter for churned customers
    AND contract = 'Month to month'  -- Filter for monthly contract customers
ORDER BY 
   contract_duration_in_months DESC;  -- Order by contract duration (tenure) in descending order

# Determine the average age and total charges for customers who have churned, grouped by internet service and phone service

SELECT 
    `Internet Service`,  -- Internet service type
    `Phone Service`,     -- Phone service type
    AVG(age) AS average_age,  -- Calculate the average age
    AVG(`Total Charges`) AS average_total_charges  -- Calculate the average total charges
FROM 
    customer_churn1
WHERE 
    customerstatus = 'churned'  -- Filter for churned customers
GROUP BY 
    `Internet Service`,  -- Group by internet service type
    `Phone Service`  -- Group by phone service type
ORDER BY 
    `Internet Service`, `Phone Service`;  -- Order by internet and phone service

# Create a view to find the customers with the highest monthly charges in each contract type

CREATE VIEW HighestMonthlyChargesByContract AS
SELECT 
    `Customer ID`,   -- Customer identifier
    `Contract`,      -- Contract type
    `Monthly Charge`,  -- Monthly charges
    RANK() OVER (PARTITION BY `Contract` ORDER BY `Monthly Charge` DESC) AS 'Rank'  -- Rank customers by highest monthly charges in each contract
FROM 
    customer_churn1;

# Create a view to identify customers who have churned and the average monthly charges compared to the overall average

SET @overall_average_monthly_charges = (SELECT AVG(`Monthly Charge`) FROM customer_churn1);
CREATE VIEW ChurnedCustomersAverageCharges AS
SELECT 
    `Customer ID`,  -- Customer identifier
    AVG(`Monthly Charge`) AS average_monthly_charges,  -- Average monthly charges for churned customers
    overall_average.overall_avg AS overall_average_monthly_charges,  -- Overall average monthly charges
    CASE 
        WHEN AVG(`Monthly Charge`) > overall_average.overall_avg THEN 'Above Average' 
        WHEN AVG(`Monthly Charge`) < overall_average.overall_avg THEN 'Below Average' 
        ELSE 'Average' 
    END AS comparison_to_overall_average  -- Comparison result
FROM 
    customer_churn1,
    (SELECT AVG(`Monthly Charge`) AS overall_avg FROM customer_churn1) AS overall_average  -- Subquery for overall average
WHERE 
    customerstatus = 'churned'  -- Filter for churned customers
GROUP BY 
    `Customer ID`;  -- Group by customer ID to calculate average monthly charges per churned customer
 -- Group by customer ID to calculate average monthly charges per churned customer

#Create a view to find the customers who have churned and their cumulative total charges over time

CREATE VIEW ChurnedCustomersCumulativeCharges AS
SELECT 
    `Customer ID`,  -- Customer identifier
    `Total Charges`,  -- Total charges for each customer
    SUM(`Total Charges`) OVER (PARTITION BY `Customer ID` ORDER BY `Customer ID`) AS cumulative_total_charges  -- Cumulative total charges
FROM 
    customer_churn1
WHERE 
    customerstatus = 'churned';  -- Filter for churned customers
 -- Group by customer ID
    
    SELECT * FROM ChurnedCustomersCumulativeCharges ;
    
    #  Stored Procedure to Calculate Churn Rate
    
    DELIMITER $$

CREATE PROCEDURE CalculateChurnRate()
BEGIN
    DECLARE total_customers INT;
    DECLARE churned_customers INT;
    DECLARE churn_rate_percentage DECIMAL(5,2);

    -- Calculate the total number of customers
    SELECT COUNT(*) INTO total_customers FROM customer_churn1;

    -- Calculate the number of churned customers
    SELECT COUNT(*) INTO churned_customers FROM customer_churn1 WHERE customerstatus = 'churned';

    -- Calculate the churn rate percentage
    IF total_customers > 0 THEN
        SET churn_rate_percentage = (churned_customers / total_customers) * 100;
    ELSE
        SET churn_rate_percentage = 0;  -- Prevent division by zero
    END IF;

    -- Output the results
    SELECT 
        total_customers AS total_customers,
        churned_customers AS churned_customers,
        churn_rate_percentage AS churn_rate_percentage;
END$$

DELIMITER ;

CALL CalculateChurnRate();

#Stored Procedure to Identify High-Value Customers at Risk of Churning.

DELIMITER $$

CREATE PROCEDURE IdentifyHighValueAtRiskCustomers(IN min_total_charges DECIMAL(10, 2), IN max_churn_threshold DECIMAL(10, 2)
)
BEGIN
    -- Temporary table to store high-value customers at risk
    CREATE TEMPORARY TABLE IF NOT EXISTS AtRiskCustomers AS 
    SELECT 
        `Customer ID`,
        `Total Charges`,
        `Monthly Charge`,
        `Customer Status`, 
        `Contract`,
        `Age`, 
        `Tenure in months`,
        -- Assuming you have a risk score based on some criteria
        CASE 
            WHEN `Monthly Charge` > max_churn_threshold THEN 'At Risk' 
            ELSE 'Not At Risk' 
        END AS Risk_Status
    FROM 
        customer_churn1
    WHERE 
        `Total Charges` > min_total_charges
        AND `Customer Status` != 'churned';  -- Exclude already churned customers

    -- Output the results
    SELECT * FROM AtRiskCustomers WHERE Risk_Status = 'At Risk';
    
    -- Clean up the temporary table
    DROP TEMPORARY TABLE IF EXISTS AtRiskCustomers;
END$$

DELIMITER ;

CALL IdentifyHighValueAtRiskCustomers(1000.00, 150.00);
DROP PROCEDURE IF EXISTS IdentifyHighValueAtRiskCustomers;

DELIMITER $$

CREATE PROCEDURE IdentifyHighValueAtRiskCustomers(IN min_total_charges DECIMAL(10, 2), IN max_churn_threshold DECIMAL(10, 2))
BEGIN
    -- Temporary table to store high-value customers at risk
    CREATE TEMPORARY TABLE IF NOT EXISTS AtRiskCustomers AS 
    SELECT 
        `Customer ID`,
        `Total Charges`,
        `Monthly Charge`,
        `customerstatus`,  -- Adjusted column name
        `Contract`,
        `Age`, 
        `Tenure in months`,
        -- Assuming you have a risk score based on some criteria
        CASE 
            WHEN `Monthly Charge` > max_churn_threshold THEN 'At Risk' 
            ELSE 'Not At Risk' 
        END AS Risk_Status
    FROM 
        customer_churn1
    WHERE 
        `Total Charges` > min_total_charges
        AND `customerstatus` != 'churned';  -- Exclude already churned customers

    -- Output the results
    SELECT * FROM AtRiskCustomers WHERE Risk_Status = 'At Risk';
    
    -- Clean up the temporary table
    DROP TEMPORARY TABLE IF EXISTS AtRiskCustomers;
END$$

DELIMITER ;

CALL IdentifyHighValueAtRiskCustomers(500, 200);



