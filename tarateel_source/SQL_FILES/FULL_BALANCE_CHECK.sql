-- Full balance analysis
SELECT 
  payment_mode,
  type,
  COUNT(*) as entries,
  SUM(amount) as total
FROM ledger
GROUP BY payment_mode, type
ORDER BY payment_mode, type;
