-- IMPORTANT: Migrate ALL legacy payment_modes to "Sandeep Account"
-- This fixes balance calculation for the new exact-match system
-- "Online", "Cash", "Bank Transfer" etc. were all Sandeep's entries

-- First check what exists
SELECT payment_mode, COUNT(*) as entries FROM ledger GROUP BY payment_mode ORDER BY payment_mode;

-- Migrate everything that is NOT "Company Account" and NOT "Sandeep Account"
-- to "Sandeep Account"
UPDATE ledger
SET payment_mode = 'Sandeep Account'
WHERE payment_mode NOT IN ('Company Account', 'Sandeep Account')
  AND (payment_mode IS NOT NULL AND payment_mode != '');

-- Verify: should only show "Company Account" and "Sandeep Account"
SELECT payment_mode, COUNT(*) as entries, SUM(amount) as total
FROM ledger GROUP BY payment_mode ORDER BY payment_mode;
