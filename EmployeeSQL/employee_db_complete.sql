--Data Engineering for database

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

--List the following details of each employee: employee number, last name, first name, sex, and salary.
select * from employees
select * from salaries

select employees.emp_no as "Employee Number", employees.last_name as "Last Name", employees.first_name as "First Name", employees.sex as "Sex", salaries.salary as "Salary"
from employees, salaries
where employees.emp_no = salaries.emp_no
order by "Last Name" ASC;

--List first name, last name, and hire date for employees who were hired in 1986.z
select * from employees

select first_name as "First Name",last_name as "Last Name", hire_date as " Hire Date"
from employees
where hire_date between  '1986-01-01' and '1986-12-31'
order by hire_date ASC;

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

select * from dept_manager
select * from departments
select * from employees

select departments.dept_no as "Department Number", departments.dept_name as "Department Name", dept_manager.emp_no as "Employee Number", employees.last_name as "Last Name", employees.first_name as "First Name"
from departments
join dept_manager
on departments.dept_no = dept_manager.dept_no
join employees 
on dept_manager.emp_no = employees.emp_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.

select * from employees
select * from dept_emp
select * from departments

select employees.emp_no as "Employee Number", employees.last_name as "Last Name", employees.first_name as "First Name", departments.dept_name as "Department"
from departments 
join dept_emp
on departments.dept_no = dept_emp.dept_no 
join employees
on dept_emp.emp_no = employees.emp_no;



--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select * from employees

select first_name as "First Name", last_name as " Last Name", sex as " Sex"
from employees
where first_name = 'Hercules' and last_name like 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.

select * from departments
select * from dept_emp
select * from employees

select employees.emp_no as "Employee Number", employees.last_name as "Last Name", employees.first_name as "First Name", departments.dept_name as "Department"
from departments 
join dept_emp
on departments.dept_no = dept_emp.dept_no 
join employees
on dept_emp.emp_no = employees.emp_no
where departments.dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

select * from departments
select * from dept_emp
select * from employees

select employees.emp_no as "Employee Number", employees.last_name as "Last Name", employees.first_name as "First Name", departments.dept_name as "Department"
from departments 
join dept_emp
on departments.dept_no = dept_emp.dept_no 
join employees
on dept_emp.emp_no = employees.emp_no
where departments.dept_name = 'Sales' 
or  departments.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
	select * from employees
	
	select last_name, count(last_name) as "Frequency"
	from employees
	Group by last_name
	order by count(last_name) DESC
