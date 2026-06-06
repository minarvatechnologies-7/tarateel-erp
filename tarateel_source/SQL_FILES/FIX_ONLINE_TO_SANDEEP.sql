-- Move all "Online" ledger entries to "Sandeep Account"
-- This fixes the balance calculation

UPDATE ledger
SET payment_mode = 'Sandeep Account'
WHERE payment_mode = 'Online';

-- Verify
SELECT payment_mode, COUNT(*) as entries, SUM(amount) as total
FROM ledger
GROUP BY payment_mode
ORDER BY payment_mode;
