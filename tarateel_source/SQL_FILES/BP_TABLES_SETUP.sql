-- Bills & Payables — 3 new tables
-- Run this in Supabase SQL Editor

CREATE TABLE IF NOT EXISTS bp_suppliers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  category TEXT DEFAULT 'Material Supplier',
  phone TEXT DEFAULT '',
  cr_number TEXT DEFAULT '',
  notes TEXT DEFAULT '',
  opening_balance NUMERIC DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS bp_bills (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  supplier_id uuid REFERENCES bp_suppliers(id) ON DELETE CASCADE,
  bill_date DATE NOT NULL,
  bill_number TEXT DEFAULT '',
  site TEXT DEFAULT '',
  description TEXT DEFAULT '',
  amount_type TEXT DEFAULT 'without_vat',
  net_amount NUMERIC DEFAULT 0,
  vat_amount NUMERIC DEFAULT 0,
  total_amount NUMERIC DEFAULT 0,
  payment_type TEXT DEFAULT 'credit',
  status TEXT DEFAULT 'Pending',
  notes TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS bp_payments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  bill_id uuid REFERENCES bp_bills(id) ON DELETE CASCADE,
  supplier_id uuid REFERENCES bp_suppliers(id),
  amount NUMERIC NOT NULL,
  payment_date DATE NOT NULL,
  bank_account_id TEXT DEFAULT '',
  notes TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Allow public access (no RLS restrictions)
ALTER TABLE bp_suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE bp_bills ENABLE ROW LEVEL SECURITY;
ALTER TABLE bp_payments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "allow_all_bp_suppliers" ON bp_suppliers FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_bp_bills" ON bp_bills FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_bp_payments" ON bp_payments FOR ALL USING (true) WITH CHECK (true);
