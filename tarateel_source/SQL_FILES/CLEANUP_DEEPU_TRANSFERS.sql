-- Step 1: SEE the transfer entries involving Deepu (run first to verify)
SELECT id, entry_date, description, payment_mode, type, amount, category
FROM ledger
WHERE category = 'Account Transfer'
   OR payment_mode = 'Deepu A/c'
   OR description ILIKE '%deepu%'
ORDER BY entry_date;

-- Step 2: After verifying above, DELETE all Deepu-related transfer entries
-- (Uncomment the lines below and run)

-- DELETE FROM ledger
-- WHERE category = 'Account Transfer'
--   AND (payment_mode = 'Deepu A/c' OR description ILIKE '%deepu%' OR payee ILIKE '%deepu%');

-- Also delete the matching Sandeep/Company credit side of those Deepu transfers:
-- DELETE FROM ledger
-- WHERE category = 'Account Transfer'
--   AND description ILIKE '%from deepu%';
