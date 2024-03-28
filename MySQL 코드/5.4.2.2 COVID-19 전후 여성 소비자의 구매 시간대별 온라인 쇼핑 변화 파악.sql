-- 여성 소비자의 시간대별 평균 결제건수에 대한 전년대비 증감율 파악
WITH YearlyAverages AS (
    SELECT 
        tit.time_range ,
        YEAR(dt.cri_date) AS year,
        AVG(trt.transaction_count) AS avg_transactions
    FROM 
        normalized_table nt
        INNER JOIN date_table dt ON nt.date_id = dt.date_id
        INNER JOIN gender_table gt ON nt.gender_id = gt.gender_id
        INNER JOIN time_table tit ON nt.time_id = tit.time_id
        INNER JOIN transaction_table trt ON nt.transaction_id = trt.transaction_id
	WHERE gt.gender = 0 -- 여성으로 한정
    GROUP BY 2, 1
),
GrowthRates AS (
    SELECT
        time_range,
        year,
        avg_transactions,
        LAG(avg_transactions) OVER (PARTITION BY time_range ORDER BY year) AS prev_year_transactions,
        (avg_transactions - LAG(avg_transactions) OVER (PARTITION BY time_range ORDER BY year)) / LAG(avg_transactions) OVER (PARTITION BY time_range ORDER BY year) 
        * 100 AS growth_rate
    FROM
        YearlyAverages
)
SELECT time_range, year,growth_rate
FROM GrowthRates
ORDER BY 1, 2;
