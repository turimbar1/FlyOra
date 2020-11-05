ALTER TABLE hr.employees DROP (RG_ID);
ALTER TRIGGER hr.update_job_history COMPILE;