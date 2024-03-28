-- 연도에 따른 성별 별 건수합계 파악하기
SELECT gt.gender, dt.cri_date, SUM(trt.transaction_count) AS sum_transactions
FROM normalized_table nt
INNER JOIN date_table dt ON nt.date_id = dt.date_id
INNER JOIN gender_table gt ON nt.gender_id = gt.gender_id
INNER JOIN transaction_table trt ON nt.transaction_id = trt.transaction_id
GROUP BY 2, 1
ORDER BY 1, 2;
