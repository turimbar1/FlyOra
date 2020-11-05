ALTER TABLE hr.employees ADD (RG_ID VARCHAR2(50 BYTE));

COMMENT ON COLUMN hr.employees.RG_ID IS 'Redgate ID';