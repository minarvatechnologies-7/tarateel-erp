-- Check opening balances stored in app_settings
SELECT key, value FROM app_settings WHERE key = 'account_opening_balances';
