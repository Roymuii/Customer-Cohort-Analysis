-- 536350 records 
SELECT * FROM [dbo].[Sales_Transaction_revised ] 

-- cleaning data 
-- null values = 55 
-- and not null values = 536295 
;WITH cte1 AS (
    SELECT * 
    FROM [dbo].[Sales_Transaction_revised ]
    WHERE CustomerNo IS NOT NULL 
    ) 

-- check data Price and Quantity that it's not negative values 
-- negative values = 8531 
-- and TransactionNo that start with letter 'C' have negative Quantity   
   
   /*
    SELECT * FROM cte1 
    WHERE Price < 0 OR Quantity < 0  */

-- 527764
 
    SELECT * 
    INTO #cleaned_ecm
    FROM cte1 
    WHERE Quantity > 0 
    
-- CLEANED -- 

SELECT * FROM #cleaned_ecm
-- step 1 create 'First purchase' from Date in each customerNo
;WITH cte4 AS (
    SELECT *,
            MIN(Date)  OVER (PARTITION BY CustomerNo) AS First_Purchase
    FROM #cleaned_ecm
    )


-- step 2 create 'cohort month' from First purchase and set day = 1 
SELECT *,
        cohort_month = CAST(DATEADD(Day,1 - day(First_Purchase),First_Purchase) AS DATE), 


-- step 3 create 'Cohort index'
        cohort_index = DATEDIFF(MONTH,DATEADD(Day,1 - day(First_Purchase),First_Purchase),Date)
INTO #vised        
FROM cte4 

SELECT * FROM #vised 

-- create cohort table and pivot 
;WITH cte5 AS (
    SELECT 
        count(distinct CustomerNo) AS num_customer,
        cohort_month,
        cohort_index 
    FROM #vised   
    GROUP BY cohort_month,cohort_index 
    ) 

, cte6 AS (

    SELECT *,
            FIRST_VALUE(num_customer) OVER (PARTITION BY cohort_month ORDER BY cohort_index) AS index_0
    FROM cte5 
    ) 

SELECT
    cohort_month,
    num_customer,
    cohort_index,
    rentention_rate = cast((num_customer*100) AS decimal(10,2))/index_0 
FROM cte6    

-- Create pivot 
SELECT * 
INTO #pivot
FROM (
    SELECT 
            distinct CustomerNo,
            cohort_month,
            cohort_index
    FROM #vised
) d
PIVOT (
    COUNT(CustomerNo) FOR cohort_index IN ([0],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) pvt


SELECT 
        cohort_month,
        num_customers = [0],
        [0] = Round(cast([0]*100/[0] as decimal(10,2)),2)
                                        ,[1] = Round(cast([1]*100.0/[0] as decimal(10,2)),2)
                                        ,[2] = Round(cast([2]*100.0/[0] as decimal(10,2)),2)
                                        ,[3] = Round(cast([3]*100.0/[0] as decimal(10,2)),2)
                                        ,[4] = Round(cast([4]*100.0/[0] as decimal(10,2)),2)
                                        ,[5] = Round(cast([5]*100.0/[0] as decimal(10,2)),2)
                                        ,[6] = Round(cast([6]*100.0/[0] as decimal(10,2)),2)
                                        ,[7] = Round(cast([7]*100.0/[0] as decimal(10,2)),2)
                                        ,[8] = Round(cast([8]*100.0/[0] as decimal(10,2)),2)
                                        ,[9] = Round(cast([9]*100.0/[0] as decimal(10,2)),2)
                                        ,[10] = Round(cast([10]*100.0/[0] as decimal(10,2)),2)
                                        ,[11] = Round(cast([11]*100.0/[0] as decimal(10,2)),2)
                                        ,[12] = Round(cast([12]*100.0/[0] as decimal(10,2)),2)   

FROM #pivot
ORDER BY cohort_month

