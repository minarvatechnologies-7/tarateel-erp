-- Multi-user RBAC system for Minarva Biz ERP
-- Run this in Supabase SQL Editor

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
CREATE POLICY "allow_all_app_users" ON app_users FOR ALL USING (true) WITH CHECK (true);

-- Insert default admin user (password: Seven@2026)
INSERT INTO app_users (username, display_name, password, role, permissions)
VALUES (
  'admin',
  'Administrator',
  'Seven@2026',
  'Admin',
  '{
    "dashboard":{"view":true,"edit":true},
    "invoices":{"view":true,"edit":true},
    "projects":{"view":true,"edit":true},
    "payroll":{"view":true,"edit":true},
    "ledger":{"view":true,"edit":true},
    "banking":{"view":true,"edit":true},
    "subcontractors":{"view":true,"edit":true},
    "creditpurchases":{"view":true,"edit":true},
    "commissions":{"view":true,"edit":true},
    "reports":{"view":true,"edit":true},
    "settings":{"view":true,"edit":true}
  }'::jsonb
) ON CONFLICT (username) DO NOTHING;
