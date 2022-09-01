-- Department retirees
SELECT ce.emp_no,
ce.first_name,
ce.last_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);
select * from dept_bkdwn;
-- create titles table
Create table titles (
	emp_no INT NOT NULL,
	title varchar NOT NULL, 
	from_date date NOt Null, 
	to_date date not null,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no, title, from_date)
);
-- DELIVERABLE 1: The Number of Retiring Employees by Title

-- Follow the instructions below to complete Deliverable 1.
drop table if exists retirement_titles;
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       t.title,
       t.from_date,
       t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by e.emp_no;
select * from retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
drop table if exists unique_titles;
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, title DESC;
select * from unique_titles;

-- Retrieve the number of employees by their most recent job title who are about to retire.
drop table if exists retiring_titles;
SELECT COUNT(ut.emp_no),
ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title 
ORDER BY COUNT(title) DESC;
select * from retiring_titles;

-- DELIVERABLE 2: The Employees Eligible for the Mentorship Program

-- Write a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.
drop table if exists mentorship_eligibilty;
SELECT DISTINCT ON(e.emp_no) e.emp_no, 
    e.first_name, 
    e.last_name, 
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibilty
FROM employees as e
Left outer Join dept_emp as de
ON (e.emp_no = de.emp_no)
Left outer Join titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;
select * from mentorship_eligibilty;