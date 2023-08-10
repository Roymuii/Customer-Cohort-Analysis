# Introduction
This project was created to look at the behavior of customers who come to buy products for the first time using comparisons from the same month that customers come to buy products again each month. It will use SQL to analyze customer behavior and clean up the data before doing it. Visualization in Tableau to make data easier to understand

# What is Cohort Analysis ? 
Cohort Analysis is the analysis of customer behavior. From some characteristics that are the same, such as customers who buy products in the same month, customers who buy the same product, users login to the website on the same day, etc.

# Dataset
This dataset comes from Kaggle : E-commerce Business Transaction that a sales transaction data set of UK-based E-commerce (online retail) for one year. The dataset contains 500K and 8 columns of sales about gifts and gifts. homewares for adults and children through the website since 2007, there are customers from all over the world come to buy and sell.

# Data Cleaning 
After examining all 536,350 data, it was found that there were 55 Null Values and Quantity was Negative Values. with a prefix 'C' Quantity will also have a negative value. The negative value may be from some products being affected, but the Price has no negative value. Remove these values.

<img width="468" alt="image" src="https://github.com/Roymuii/Customer-Cohort-Analysis/assets/124777938/9df2228c-3e7a-4ee7-a7c2-684e64224bc8">

<img width="469" alt="image" src="https://github.com/Roymuii/Customer-Cohort-Analysis/assets/124777938/46adb186-4d1b-49f2-bdf9-ac6e6e12f6e7">

# Conducting Cohort
Step 1 Find the first month that each customer buys for the first time by finding the minimum in the Date column named “First_Purchase” and subquery it with Common Table Expression (CTE). First_Purchase to calculate cohort_month and cohort_index

<img width="469" alt="image" src="https://github.com/Roymuii/Customer-Cohort-Analysis/assets/124777938/0d3923f3-7e6e-419e-989b-e51bc4bbb173">

Step 2 Bring First_Purchase to Cohort_month by setting day to day 1.

<img width="473" alt="image" src="https://github.com/Roymuii/Customer-Cohort-Analysis/assets/124777938/08dc3c4a-3129-41ab-a96a-d7dbdbb35057">

Step 3 cohort_index is the difference between Date and Cohort_month. For example, a customer bought the first month on 2018-12-01 and returned on 2019-02-01. The resulting cohort_index is 2. This means that the same customers come in again after 2 months and finally create a temporary table so they can be called out easily.

<img width="473" alt="image" src="https://github.com/Roymuii/Customer-Cohort-Analysis/assets/124777938/9576273f-8d1d-43aa-8629-140699f18fc7">

# Bonus Stage 
From step 3, you can export the data and continue calculating in Tableau, but the calculation can still be done in SQL, showing both table and pivot.
Use the information in the table #vised and select some of the required data. There are 3 main elements needed for the calculation.
1) CustomerNo
2) Cohort_month 
3) cohort_index

then perform a subquery with Common Table Expression (CTE) because it will take the sum of CustomerNo in each cohort_index, cohort_month to calculate the retention rate.

<img width="437" alt="image" src="https://github.com/Roymuii/Customer-Cohort-Analysis/assets/124777938/891319a4-b1ac-49ed-ac43-541d003ed7cc">

For formula to find retention rate = num_customer*100/index_0
Therefore, the next thing to look for is The total sum of customers who come to buy for the first time, or is index = 0 because it must be taken as a divider by using First_value Function to get only cohort_index = 0 in each group of customers only

<img width="469" alt="image" src="https://github.com/Roymuii/Customer-Cohort-Analysis/assets/124777938/cbbe968f-b3a6-41a6-b2cd-82222b6dfdb4">

Take the formula mentioned above to calculate the result as follows.

<img width="469" alt="image" src="https://github.com/Roymuii/Customer-Cohort-Analysis/assets/124777938/11bbd9a1-681f-4b7d-8ffe-294f2c4e7324">

Pivot
In the next part, we will create a pivot. First, we will create a table in the form of The number of customers in each cohort_index then make a temporary table because the table will be used to calculate the retention rate.

<img width="469" alt="image" src="https://github.com/Roymuii/Customer-Cohort-Analysis/assets/124777938/27814ca7-ad80-4151-a06d-ee1b80f9cc91">

Later, we will take all customer segments for each month. Set the value to [0] and name it Num_customer because you want to know how many new customers come in each month. then calculate the retention rate in each cohort_index

<img width="469" alt="image" src="https://github.com/Roymuii/Customer-Cohort-Analysis/assets/124777938/e3bd09e4-dcd7-4a79-a7bd-bca21e43bf20">

# Result
<img width="628" alt="image" src="https://github.com/Roymuii/Customer-Cohort-Analysis/assets/124777938/3480f861-cf1f-45b7-a008-e97140ac3e54">













