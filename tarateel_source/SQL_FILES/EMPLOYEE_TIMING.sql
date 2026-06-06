-- Add work timing + break columns to employees
ALTER TABLE employees ADD COLUMN IF NOT EXISTS work_start TEXT DEFAULT '07:00';
ALTER TABLE employees ADD COLUMN IF NOT EXISTS work_end TEXT DEFAULT '18:00';
ALTER TABLE employees ADD COLUMN IF NOT EXISTS break_start TEXT DEFAULT '13:00';
ALTER TABLE employees ADD COLUMN IF NOT EXISTS break_end TEXT DEFAULT '14:00';

-- Update existing OFFICE group employees to 9am-9pm, break 1-4pm
UPDATE employees
SET work_start='09:00', work_end='21:00', break_start='13:00', break_end='16:00'
WHERE emp_group ILIKE '%office%';

-- All other groups: 7am-6pm, break 1-2pm (this is the default, but set explicitly)
UPDATE employees
SET work_start='07:00', work_end='18:00', break_start='13:00', break_end='14:00'
WHERE emp_group NOT ILIKE '%office%' OR emp_group IS NULL;

-- Verify
SELECT name, emp_group, work_start, work_end, break_start, break_end FROM employees ORDER BY emp_group, name;
