-- Recurring expenses table (office rent, vehicle EMI, fixed monthly payments)
-- Run this in Supabase SQL Editor

CREATE TABLE IF NOT EXISTS bp_recurring (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  expense_type TEXT DEFAULT 'Rent',
  amount NUMERIC DEFAULT 0,
  frequency TEXT DEFAULT 'Monthly',
  due_day INTEGER DEFAULT 1,
  site TEXT DEFAULT '',
  notes TEXT DEFAULT '',
  is_active BOOLEAN DEFAULT true,
  start_date DATE,
  end_date DATE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Each time a recurring expense is paid, a record goes here
CREATE TABLE IF NOT EXISTS bp_recurring_payments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  recurring_id uuid REFERENCES bp_recurring(id) ON DELETE CASCADE,
  amount NUMERIC NOT NULL,
  payment_date DATE NOT NULL,
  period_month TEXT DEFAULT '',
  bank_account_id TEXT DEFAULT '',
  notes TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE bp_recurring ENABLE ROW LEVEL SECURITY;
ALTER TABLE bp_recurring_payments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "allow_all_bp_recurring" ON bp_recurring FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_bp_recurring_payments" ON bp_recurring_payments FOR ALL USING (true) WITH CHECK (true);
