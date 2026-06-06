-- FIX DUPLICATE BANK ACCOUNTS
-- Run this in Supabase SQL Editor

-- Step 1: Keep only the OLDEST row per account_name, delete the rest
DELETE FROM bank_accounts
WHERE id NOT IN (
  SELECT DISTINCT ON (account_name) id
  FROM bank_accounts
  ORDER BY account_name, created_at ASC
);

-- Step 2: Verify result
SELECT id, account_name, account_number, opening_balance FROM bank_accounts ORDER BY account_name;
