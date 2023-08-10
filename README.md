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

