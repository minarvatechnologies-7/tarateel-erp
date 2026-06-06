-- Add "include_in_balance" flag to bank accounts
-- true = counts in company Net Cash (Company, Sandeep)
-- false = tracking-only (Deepu — personal account, transfers visible but not in Net Cash)

ALTER TABLE bank_accounts ADD COLUMN IF NOT EXISTS include_in_balance BOOLEAN DEFAULT true;

-- Set Deepu as tracking-only (NOT in net cash)
UPDATE bank_accounts SET include_in_balance = false WHERE account_name ILIKE '%deepu%';

-- Make sure Company and Sandeep ARE included
UPDATE bank_accounts SET include_in_balance = true WHERE account_name IN ('Company Account', 'Sandeep Account');

-- Verify
SELECT account_name, include_in_balance FROM bank_accounts ORDER BY account_name;
