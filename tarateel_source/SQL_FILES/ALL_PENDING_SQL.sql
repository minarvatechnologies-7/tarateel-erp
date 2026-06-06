-- ═══════════════════════════════════════════════
-- MINARVA BIZ — ALL PENDING SQL UPDATES
-- Run this in Supabase SQL Editor (one-time)
-- ═══════════════════════════════════════════════

-- 1. APP USERS TABLE (RBAC Login System)
CREATE TABLE IF NOT EXISTS app_users (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  username TEXT UNIQUE NOT NULL,
  display_name TEXT NOT NULL,
  password TEXT NOT NULL,
  role TEXT DEFAULT 'Viewer',
  permissions JSONB DEFAULT '{}',
  is_active BOOLEAN DEFAULT true,
  last_login TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE app_users ENABLE ROW LEVEL SECURITY;
DO $$ BEGIN
  CREATE POLICY "allow_all_app_users" ON app_users FOR ALL USING (true) WITH CHECK (true);
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- Default admin user
INSERT INTO app_users (username, display_name, password, role, permissions)
VALUES ('admin', 'Administrator', 'Seven@2026', 'Admin',
  '{"dashboard":{"view":true,"edit":true},"invoices":{"view":true,"edit":true},"projects":{"view":true,"edit":true},"payroll":{"view":true,"edit":true},"ledger":{"view":true,"edit":true},"banking":{"view":true,"edit":true},"subcontractors":{"view":true,"edit":true},"creditpurchases":{"view":true,"edit":true},"commissions":{"view":true,"edit":true},"reports":{"view":true,"edit":true},"settings":{"view":true,"edit":true}}'::jsonb
) ON CONFLICT (username) DO NOTHING;

-- 2. RECURRING EXPENSES TABLES
CREATE TABLE IF NOT EXISTS bp_recurring (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL, expense_type TEXT DEFAULT 'Rent',
  amount NUMERIC DEFAULT 0, frequency TEXT DEFAULT 'Monthly',
  due_day INTEGER DEFAULT 1, site TEXT DEFAULT '', notes TEXT DEFAULT '',
  is_active BOOLEAN DEFAULT true, start_date DATE, end_date DATE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS bp_recurring_payments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  recurring_id uuid REFERENCES bp_recurring(id) ON DELETE CASCADE,
  amount NUMERIC NOT NULL, payment_date DATE NOT NULL,
  period_month TEXT DEFAULT '', bank_account_id TEXT DEFAULT '',
  notes TEXT DEFAULT '', created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE bp_recurring ENABLE ROW LEVEL SECURITY;
ALTER TABLE bp_recurring_payments ENABLE ROW LEVEL SECURITY;
DO $$ BEGIN CREATE POLICY "allow_all_bp_recurring" ON bp_recurring FOR ALL USING (true) WITH CHECK (true); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE POLICY "allow_all_bp_recurring_payments" ON bp_recurring_payments FOR ALL USING (true) WITH CHECK (true); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- 3. BILL DUE DATE
ALTER TABLE bp_bills ADD COLUMN IF NOT EXISTS due_date DATE;

-- 4. EMPLOYEE WORK TIMING
ALTER TABLE employees ADD COLUMN IF NOT EXISTS work_start TEXT DEFAULT '07:00';
ALTER TABLE employees ADD COLUMN IF NOT EXISTS work_end TEXT DEFAULT '18:00';
ALTER TABLE employees ADD COLUMN IF NOT EXISTS break_start TEXT DEFAULT '13:00';
ALTER TABLE employees ADD COLUMN IF NOT EXISTS break_end TEXT DEFAULT '14:00';

-- Update Office group timing
UPDATE employees SET work_start='09:00', work_end='21:00', break_start='13:00', break_end='16:00'
WHERE emp_group ILIKE '%office%';

-- 5. FIX: Salary Pending → Subcontractor category
UPDATE bp_suppliers SET category = 'Subcontractor' WHERE category = 'Salary Pending';

SELECT 'All SQL updates applied successfully!' AS result;
