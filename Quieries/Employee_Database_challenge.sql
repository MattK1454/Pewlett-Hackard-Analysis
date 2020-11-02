--Retirement Title table
SELECT DISTINCT e.emp_no,
				e.first_name,
				e.last_name,
				ti.title,
				ti.from_date,
				ti.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS ti
	ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

--Create a retiring titles count table
SELECT COUNT(title) AS "count",
	   title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY "count" DESC;

--Create mentorship eligibility table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	   e.first_name,
	   e.last_name,
	   e.birth_date,
	   de.from_date,
	   de.to_date,
	   ti.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_employees AS de
	ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti
	ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY emp_no;

--Sorting for mentors to develop training programs
SELECT ri.emp_no,
	   ri.first_name,
	   ri.last_name,
	   ti.title
INTO manager_key_points
FROM retirement_info AS ri
INNER JOIN titles AS ti
	ON (ri.emp_no = ti.emp_no)
WHERE (ti.title = 'Manager');

--Council to develop material
SELECT COUNT(title) as "count",
	   me.title
INTO title_panels
FROM mentorship_eligibility as me
GROUP BY me.title
ORDER BY "count" DESC;
