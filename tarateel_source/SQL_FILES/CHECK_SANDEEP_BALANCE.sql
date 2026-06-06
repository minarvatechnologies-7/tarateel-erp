-- Run this to see exactly what's going into Sandeep balance
-- (Everything that is NOT "Company Account" in payment_mode)

SELECT 
  payment_mode,
  type,
  COUNT(*) as entries,
  SUM(amount) as total_amount
FROM ledger
WHERE payment_mode != 'Company Account'
GROUP BY payment_mode, type
ORDER BY payment_mode, type;
