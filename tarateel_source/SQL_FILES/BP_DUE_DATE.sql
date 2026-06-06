-- Add due_date to bills for overdue tracking
ALTER TABLE bp_bills ADD COLUMN IF NOT EXISTS due_date DATE;
