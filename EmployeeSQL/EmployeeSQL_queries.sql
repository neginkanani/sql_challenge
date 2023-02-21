
select * from department;

--List the employee number, last name, first name, sex, and salary of each employee.
select employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary 
from employees
join salaries
on employees.emp_no=salaries.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986.
-- first need to change the type of hire_date column to date
ALTER TABLE employees ALTER COLUMN hire_date TYPE date using (hire_date::date);

select first_name, last_name, hire_date
from employees
where EXTRACT(YEAR from hire_date)=1986;


--List the manager of each department along with their department number, department name, employee number, last name, and first name.

select dept_manager.dept_no, dept_manager.emp_no, employees.first_name, employees.last_name, department.dept_name
from dept_manager
join employees
on dept_manager.emp_no=employees.emp_no
join department
on dept_manager.dept_no=department.dept_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

select employees.emp_no, employees.first_name, employees.last_name,department.dept_name
from employees
join dept_emp
on employees.emp_no=dept_emp.emp_no
join department
on dept_emp.dept_no=department.dept_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

select first_name, last_name, sex
from employees
where first_name='Hercules' and last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.
select emp_no,first_name, last_name
from employees
where emp_no IN
(
	select emp_no
	from dept_emp
	where dept_no IN
	(
	select dept_no
		from department
		where dept_name='Sales'
	)
);


--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
select employees.emp_no, employees.first_name, employees.last_name, department.dept_name
from employees
join dept_emp
on employees.emp_no= dept_emp.emp_no
join department
on dept_emp.dept_no=department.dept_no
where department.dept_name='Sales' OR department.dept_name='Development';

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
select last_name, count(last_name) as "count_employees"
from employees
group by last_name
order by count_employees desc;