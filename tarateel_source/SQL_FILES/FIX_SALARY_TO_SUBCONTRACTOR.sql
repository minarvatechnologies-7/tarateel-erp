-- Change "Salary Pending" category to "Subcontractor"
-- (Shahid, Muhammad Naeem, Praveen are sub-work pendings)

UPDATE bp_suppliers
SET category = 'Subcontractor'
WHERE category = 'Salary Pending';

-- Verify
SELECT name, category, opening_balance FROM bp_suppliers WHERE category = 'Subcontractor' ORDER BY name;
