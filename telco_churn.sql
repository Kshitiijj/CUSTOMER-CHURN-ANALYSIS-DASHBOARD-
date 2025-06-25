CREATE DATABASE telco_project;
USE telco_project;

#step 1:Create Database & Table 
CREATE TABLE telco_churn (
    customerID VARCHAR(50),
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges VARCHAR(20),
    Churn VARCHAR(5)
);
SELECT COUNT(*) FROM telco_churn;

#STEP 2: Clean the Data in SQL

SET SQL_SAFE_UPDATES = 0;

DELETE FROM telco_churn
WHERE TRIM(TotalCharges) = '';

ALTER TABLE telco_churn ADD total_charges_num DECIMAL(10,2);

UPDATE telco_churn
SET total_charges_num = CAST(TotalCharges AS DECIMAL(10,2));

ALTER TABLE telco_churn ADD tenure_group VARCHAR(20);

UPDATE telco_churn   #adding tenure for analysis
SET tenure_group = CASE
    WHEN tenure BETWEEN 0 AND 12 THEN 'New'
    WHEN tenure BETWEEN 13 AND 48 THEN 'Loyal'
    ELSE 'Long-Term'
END;

SELECT COUNT(*) AS total_customers FROM telco_churn;

SELECT 
  ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate   #churnrate
FROM telco_churn;

SELECT 
  Contract,
  COUNT(*) AS total_customers,         #churn contract
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_churn
GROUP BY Contract;

SELECT * FROM telco_churn;
