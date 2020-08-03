--table schema for all the csv files to create the needed tables 

--table for employees
create table employees (
	emp_no integer, 
	emp_title_id varchar(255), 
	birth_date date, 
	first_name varchar(255), 
	last_name varchar(255), 
	sex varchar(255), 
	hire_date date,
    constraint "pk_employees" Primary Key("emp_no")
);

copy employees 
from '/tmp/employees.csv'
delimiter ','
CSV HEADER;

select * from employees

--table for salaries
create table salaries(
emp_no integer,
salary integer
);

copy salaries
from '/tmp/salaries.csv'
delimiter ','
CSV HEADER;

select * from salaries

--table for titles
create table titles(
title_id varchar(255),
title varchar(255)

);

copy titles
from '/tmp/titles.csv'
delimiter ','
CSV HEADER;

select * from titles

--table for department employees
create table dept_emp(
	emp_no integer, 
	dept_no varchar,
    constraint "pk_departments" Primary Key ("dept_no")
	);
	
copy dept_emp
from '/tmp/dept_emp.csv'
delimiter ','
CSV HEADER;

select * from dept_emp

--table for department manager
create table dept_manager(
dept_no varchar(255),
	emp_no integer

);

copy dept_manager
from '/tmp/dept_manager.csv'
delimiter ','
CSV HEADER;

select * from dept_manager

-- table for departments
create table departments(
dept_no varchar(255),
	dept_name  varchar(255)

);

copy depqrtments
from '/tmp/departments.csv'
delimiter ','
CSV HEADER;

select * from departments

-- adding and alterning tables to contain forgein keys 

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");
