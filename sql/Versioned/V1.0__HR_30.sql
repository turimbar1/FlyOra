-- Generated by Oracle SQL Developer Data Modeler 3.0.0.660.660
--   at:        2011-01-07 13:00:10 GMT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g


CREATE TABLE COUNTRIES 
    ( 
     COUNTRY_ID CHAR (2 BYTE)  NOT NULL , 
     COUNTRY_NAME VARCHAR2 (40 BYTE) , 
     REGION_ID NUMBER 
    ) LOGGING 
;



COMMENT ON COLUMN COUNTRIES.COUNTRY_ID IS 'Primary key of countries table.' 
;

COMMENT ON COLUMN COUNTRIES.COUNTRY_NAME IS 'Country name' 
;

COMMENT ON COLUMN COUNTRIES.REGION_ID IS 'Region ID for the country. Foreign key to region_id column in the departments table.' 
;

CREATE UNIQUE INDEX COUNTRY_C_ID_PKX ON COUNTRIES 
    ( 
     COUNTRY_ID ASC 
    ) 
;

ALTER TABLE COUNTRIES 
    ADD CONSTRAINT COUNTRY_C_ID_PK PRIMARY KEY ( COUNTRY_ID ) ;



CREATE TABLE DEPARTMENTS 
    ( 
     DEPARTMENT_ID NUMBER (4)  NOT NULL , 
     DEPARTMENT_NAME VARCHAR2 (30 BYTE)  NOT NULL , 
     MANAGER_ID NUMBER (6) , 
     LOCATION_ID NUMBER (4) 
    ) LOGGING 
;



COMMENT ON COLUMN DEPARTMENTS.DEPARTMENT_ID IS 'Primary key column of departments table.' 
;

COMMENT ON COLUMN DEPARTMENTS.DEPARTMENT_NAME IS 'A not null column that shows name of a department. Administration,
Marketing, Purchasing, Human Resources, Shipping, IT, Executive, Public
Relations, Sales, Finance, and Accounting. ' 
;

COMMENT ON COLUMN DEPARTMENTS.MANAGER_ID IS 'Manager_id of a department. Foreign key to employee_id column of employees table. The manager_id column of the employee table references this column.' 
;

COMMENT ON COLUMN DEPARTMENTS.LOCATION_ID IS 'Location id where a department is located. Foreign key to location_id column of locations table.' 
;

CREATE INDEX DEPT_LOCATION_IX ON DEPARTMENTS 
    ( 
     LOCATION_ID ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE UNIQUE INDEX DEPT_ID_PKX ON DEPARTMENTS 
    ( 
     DEPARTMENT_ID ASC 
    ) 
;

ALTER TABLE DEPARTMENTS 
    ADD CONSTRAINT DEPT_ID_PK PRIMARY KEY ( DEPARTMENT_ID ) ;



CREATE TABLE EMPLOYEES 
    ( 
     EMPLOYEE_ID NUMBER (6)  NOT NULL , 
     FIRST_NAME VARCHAR2 (20 BYTE) , 
     LAST_NAME VARCHAR2 (25 BYTE)  NOT NULL , 
     EMAIL VARCHAR2 (25 BYTE)  NOT NULL , 
     PHONE_NUMBER VARCHAR2 (20 BYTE) , 
     HIRE_DATE DATE  NOT NULL , 
     JOB_ID VARCHAR2 (10 BYTE)  NOT NULL , 
     SALARY NUMBER (8,2) , 
     COMMISSION_PCT NUMBER (2,2) , 
     MANAGER_ID NUMBER (6) , 
     DEPARTMENT_ID NUMBER (4) 
    ) LOGGING 
;



ALTER TABLE EMPLOYEES 
    ADD CONSTRAINT EMP_SALARY_MIN 
    CHECK ( salary > 0) 
;


COMMENT ON COLUMN EMPLOYEES.EMPLOYEE_ID IS 'Primary key of employees table.' 
;

COMMENT ON COLUMN EMPLOYEES.FIRST_NAME IS 'First name of the employee. A not null column.' 
;

COMMENT ON COLUMN EMPLOYEES.LAST_NAME IS 'Last name of the employee. A not null column.' 
;

COMMENT ON COLUMN EMPLOYEES.EMAIL IS 'Email id of the employee' 
;

COMMENT ON COLUMN EMPLOYEES.PHONE_NUMBER IS 'Phone number of the employee; includes country code and area code' 
;

COMMENT ON COLUMN EMPLOYEES.HIRE_DATE IS 'Date when the employee started on this job. A not null column.' 
;

COMMENT ON COLUMN EMPLOYEES.JOB_ID IS 'Current job of the employee; foreign key to job_id column of the
jobs table. A not null column.' 
;

COMMENT ON COLUMN EMPLOYEES.SALARY IS 'Monthly salary of the employee. Must be greater
than zero (enforced by constraint emp_salary_min)' 
;

COMMENT ON COLUMN EMPLOYEES.COMMISSION_PCT IS 'Commission percentage of the employee; Only employees in sales
department elgible for commission percentage' 
;

COMMENT ON COLUMN EMPLOYEES.MANAGER_ID IS 'Manager id of the employee; has same domain as manager_id in
departments table. Foreign key to employee_id column of employees table.
(useful for reflexive joins and CONNECT BY query)' 
;

COMMENT ON COLUMN EMPLOYEES.DEPARTMENT_ID IS 'Department id where employee works; foreign key to department_id
column of the departments table' 
;

CREATE INDEX EMP_DEPARTMENT_IX ON EMPLOYEES 
    ( 
     DEPARTMENT_ID ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE INDEX EMP_JOB_IX ON EMPLOYEES 
    ( 
     JOB_ID ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE INDEX EMP_MANAGER_IX ON EMPLOYEES 
    ( 
     MANAGER_ID ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE INDEX EMP_NAME_IX ON EMPLOYEES 
    ( 
     LAST_NAME ASC , 
     FIRST_NAME ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE UNIQUE INDEX EMP_EMP_ID_PKX ON EMPLOYEES 
    ( 
     EMPLOYEE_ID ASC 
    ) 
;

ALTER TABLE EMPLOYEES 
    ADD CONSTRAINT EMP_EMP_ID_PK PRIMARY KEY ( EMPLOYEE_ID ) ;

ALTER TABLE EMPLOYEES 
    ADD CONSTRAINT EMP_EMAIL_UK UNIQUE ( EMAIL ) ;



CREATE TABLE JOBS 
    ( 
     JOB_ID VARCHAR2 (10 BYTE)  NOT NULL , 
     JOB_TITLE VARCHAR2 (35 BYTE)  NOT NULL , 
     MIN_SALARY NUMBER (6) , 
     MAX_SALARY NUMBER (6) 
    ) LOGGING 
;



COMMENT ON COLUMN JOBS.JOB_ID IS 'Primary key of jobs table.' 
;

COMMENT ON COLUMN JOBS.JOB_TITLE IS 'A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT' 
;

COMMENT ON COLUMN JOBS.MIN_SALARY IS 'Minimum salary for a job title.' 
;

COMMENT ON COLUMN JOBS.MAX_SALARY IS 'Maximum salary for a job title' 
;

CREATE UNIQUE INDEX JOB_ID_PKX ON JOBS 
    ( 
     JOB_ID ASC 
    ) 
;

ALTER TABLE JOBS 
    ADD CONSTRAINT JOB_ID_PK PRIMARY KEY ( JOB_ID ) ;



CREATE TABLE JOB_HISTORY 
    ( 
     EMPLOYEE_ID NUMBER (6)  NOT NULL , 
     START_DATE DATE  NOT NULL , 
     END_DATE DATE  NOT NULL , 
     JOB_ID VARCHAR2 (10 BYTE)  NOT NULL , 
     DEPARTMENT_ID NUMBER (4) 
    ) LOGGING 
;



ALTER TABLE JOB_HISTORY 
    ADD CONSTRAINT JHIST_DATE_CHECK 
    CHECK (end_date > start_date)
        INITIALLY IMMEDIATE 
        ENABLE 
        VALIDATE 
;


COMMENT ON COLUMN JOB_HISTORY.EMPLOYEE_ID IS 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table' 
;

COMMENT ON COLUMN JOB_HISTORY.START_DATE IS 'A not null column in the complex primary key employee_id+start_date.
Must be less than the end_date of the job_history table. (enforced by
constraint jhist_date_interval)' 
;

COMMENT ON COLUMN JOB_HISTORY.END_DATE IS 'Last day of the employee in this job role. A not null column. Must be
greater than the start_date of the job_history table.
(enforced by constraint jhist_date_interval)' 
;

COMMENT ON COLUMN JOB_HISTORY.JOB_ID IS 'Job role in which the employee worked in the past; foreign key to
job_id column in the jobs table. A not null column.' 
;

COMMENT ON COLUMN JOB_HISTORY.DEPARTMENT_ID IS 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table' 
;

CREATE INDEX JHIST_JOB_IX ON JOB_HISTORY 
    ( 
     JOB_ID ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE INDEX JHIST_EMP_IX ON JOB_HISTORY 
    ( 
     EMPLOYEE_ID ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE INDEX JHIST_DEPT_IX ON JOB_HISTORY 
    ( 
     DEPARTMENT_ID ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE UNIQUE INDEX JHIST_ID_DATE_PKX ON JOB_HISTORY 
    ( 
     EMPLOYEE_ID ASC , 
     START_DATE ASC 
    ) 
;

ALTER TABLE JOB_HISTORY 
    ADD CONSTRAINT JHIST_ID_DATE_PK PRIMARY KEY ( EMPLOYEE_ID, START_DATE ) ;



CREATE TABLE LOCATIONS 
    ( 
     LOCATION_ID NUMBER (4)  NOT NULL , 
     STREET_ADDRESS VARCHAR2 (40 BYTE) , 
     POSTAL_CODE VARCHAR2 (12 BYTE) , 
     CITY VARCHAR2 (30 BYTE)  NOT NULL , 
     STATE_PROVINCE VARCHAR2 (25 BYTE) , 
     COUNTRY_ID CHAR (2 BYTE) 
    ) LOGGING 
;



COMMENT ON COLUMN LOCATIONS.LOCATION_ID IS 'Primary key of locations table' 
;

COMMENT ON COLUMN LOCATIONS.STREET_ADDRESS IS 'Street address of an office, warehouse, or production site of a company.
Contains building number and street name' 
;

COMMENT ON COLUMN LOCATIONS.POSTAL_CODE IS 'Postal code of the location of an office, warehouse, or production site
of a company. ' 
;

COMMENT ON COLUMN LOCATIONS.CITY IS 'A not null column that shows city where an office, warehouse, or
production site of a company is located. ' 
;

COMMENT ON COLUMN LOCATIONS.STATE_PROVINCE IS 'State or Province where an office, warehouse, or production site of a
company is located.' 
;

COMMENT ON COLUMN LOCATIONS.COUNTRY_ID IS 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.' 
;

CREATE INDEX LOC_CITY_IX ON LOCATIONS 
    ( 
     CITY ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE INDEX LOC_STATE_PROV_IX ON LOCATIONS 
    ( 
     STATE_PROVINCE ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE INDEX LOC_COUNTRY_IX ON LOCATIONS 
    ( 
     COUNTRY_ID ASC 
    ) 
    LOGGING 
    NOCOMPRESS 
    NOPARALLEL 
;

CREATE UNIQUE INDEX LOC_ID_PKX ON LOCATIONS 
    ( 
     LOCATION_ID ASC 
    ) 
;

ALTER TABLE LOCATIONS 
    ADD CONSTRAINT LOC_ID_PK PRIMARY KEY ( LOCATION_ID ) ;



CREATE TABLE REGIONS 
    ( 
     REGION_ID NUMBER  NOT NULL , 
     REGION_NAME VARCHAR2 (25 BYTE) 
    ) LOGGING 
;



CREATE UNIQUE INDEX REG_ID_PKX ON REGIONS 
    ( 
     REGION_ID ASC 
    ) 
;

ALTER TABLE REGIONS 
    ADD CONSTRAINT REG_ID_PK PRIMARY KEY ( REGION_ID ) ;




ALTER TABLE COUNTRIES 
    ADD CONSTRAINT COUNTR_REG_FK FOREIGN KEY 
    ( 
     REGION_ID
    ) 
    REFERENCES REGIONS 
    ( 
     REGION_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE DEPARTMENTS 
    ADD CONSTRAINT DEPT_LOC_FK FOREIGN KEY 
    ( 
     LOCATION_ID
    ) 
    REFERENCES LOCATIONS 
    ( 
     LOCATION_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE DEPARTMENTS 
    ADD CONSTRAINT DEPT_MGR_FK FOREIGN KEY 
    ( 
     MANAGER_ID
    ) 
    REFERENCES EMPLOYEES 
    ( 
     EMPLOYEE_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE EMPLOYEES 
    ADD CONSTRAINT EMP_DEPT_FK FOREIGN KEY 
    ( 
     DEPARTMENT_ID
    ) 
    REFERENCES DEPARTMENTS 
    ( 
     DEPARTMENT_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE EMPLOYEES 
    ADD CONSTRAINT EMP_JOB_FK FOREIGN KEY 
    ( 
     JOB_ID
    ) 
    REFERENCES JOBS 
    ( 
     JOB_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE EMPLOYEES 
    ADD CONSTRAINT EMP_MANAGER_FK FOREIGN KEY 
    ( 
     MANAGER_ID
    ) 
    REFERENCES EMPLOYEES 
    ( 
     EMPLOYEE_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE JOB_HISTORY 
    ADD CONSTRAINT JHIST_DEPT_FK FOREIGN KEY 
    ( 
     DEPARTMENT_ID
    ) 
    REFERENCES DEPARTMENTS 
    ( 
     DEPARTMENT_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE JOB_HISTORY 
    ADD CONSTRAINT JHIST_EMP_FK FOREIGN KEY 
    ( 
     EMPLOYEE_ID
    ) 
    REFERENCES EMPLOYEES 
    ( 
     EMPLOYEE_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE JOB_HISTORY 
    ADD CONSTRAINT JHIST_JOB_FK FOREIGN KEY 
    ( 
     JOB_ID
    ) 
    REFERENCES JOBS 
    ( 
     JOB_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE LOCATIONS 
    ADD CONSTRAINT LOC_C_ID_FK FOREIGN KEY 
    ( 
     COUNTRY_ID
    ) 
    REFERENCES COUNTRIES 
    ( 
     COUNTRY_ID
    ) 
    NOT DEFERRABLE 
;


CREATE OR REPLACE VIEW EMP_DETAILS_VIEW AS 
SELECT
  e.employee_id,
  e.job_id,
  e.manager_id,
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  employees e,
  departments d,
  jobs j,
  locations l,
  countries c,
  regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id
WITH READ ONLY ;




CREATE SEQUENCE DEPARTMENTS_SEQ 
    INCREMENT BY 10 
    MAXVALUE 9990 
    MINVALUE 1 
    NOCACHE 
;


CREATE SEQUENCE EMPLOYEES_SEQ 
    INCREMENT BY 1 
    MAXVALUE 9999999999999999999999999999 
    MINVALUE 1 
    NOCACHE 
;


CREATE SEQUENCE LOCATIONS_SEQ 
    INCREMENT BY 100 
    MAXVALUE 9900 
    MINVALUE 1 
    NOCACHE 
;

/
CREATE OR REPLACE PROCEDURE add_job_history
  (  p_emp_id          job_history.employee_id%type
   , p_start_date      job_history.start_date%type
   , p_end_date        job_history.end_date%type
   , p_job_id          job_history.job_id%type
   , p_department_id   job_history.department_id%type
   )
IS
BEGIN
  INSERT INTO job_history (employee_id, start_date, end_date,
                           job_id, department_id)
    VALUES(p_emp_id, p_start_date, p_end_date, p_job_id, p_department_id);
END add_job_history;
/
CREATE OR REPLACE TRIGGER UPDATE_JOB_HISTORY 
    AFTER UPDATE OF JOB_ID, DEPARTMENT_ID ON EMPLOYEES 
    FOR EACH ROW 
BEGIN
  add_job_history(:old.employee_id, :old.hire_date, sysdate,
                  :old.job_id, :old.department_id);
END; 
/


CREATE OR REPLACE PROCEDURE secure_dml
IS
BEGIN
  IF TO_CHAR (SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '18:00'
        OR TO_CHAR (SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
	RAISE_APPLICATION_ERROR (-20205,
		'You may only make changes during normal office hours');
  END IF;
END secure_dml;
/








