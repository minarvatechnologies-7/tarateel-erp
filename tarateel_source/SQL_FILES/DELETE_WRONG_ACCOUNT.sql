-- Delete the wrongly created account (if you can't delete from UI yet)
-- First see all accounts:
SELECT id, account_name, opening_balance FROM bank_accounts ORDER BY account_name;

-- Uncomment and edit the line below to delete the wrong account:
-- DELETE FROM bank_accounts WHERE account_name = 'YOUR_WRONG_ACCOUNT_NAME';
