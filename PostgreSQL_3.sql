/*
PostgreSQL 15.3
employees(id, employee_name)
salary(id, monthly_salary)
employee_salary(id, employee_id u FK, salary_id u FK)
roles(id, role_name)
roles_employee(id, employee_id u FK, role_id u FK)
*/

-- Вывести всех работников чьи зарплаты есть в базе, вместе с зарплатами.
select employee_name, monthly_salary
from employees e
join employee_salary es
	on es.employee_id = e.id
join salary s
	on s.id = es.salary_id
order by e.employee_name;

-- Вывести имена всех работников у которых ЗП меньше 90000.
select employee_name
from employees e
join employee_salary es
	on es.employee_id = e.id
join salary s
	on s.id = es.salary_id
where monthly_salary < 90000;

-- Вывести все зарплатные позиции, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
select employee_name, monthly_salary
from employees e
right join employee_salary es
	on es.employee_id = e.id
join salary s 
	on s.id = es.salary_id
where employee_mane is null;


-- Вывести все зарплатные позиции  меньше 2000 но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
select employee_name, monthly_salary
from employees e
right join employee_salary es
	on es.employee_id = e.id 
join salary s 
	on s.id = es.salary_id
where
	employee_name is null
	and monthly_salary < 2000; 

-- Найти всех работников кому не начислена ЗП.
select employee_name
from employees e 
left join employee_salary es
	on es.employee_id = e.id 
where es.salary_id is null;

-- Вывести всех работников с названиями их должности.
select employee_name, role_name
from employees e 
join roles_employee re
	on re.employee_id = e.id
join roles r 
	on r.id = re.role_id;

-- Вывести имена и должность только Java разработчиков.
select employee_name, role_name
from employees e 
join roles_employee re
	on re.employee_id = e.id
join roles r 
	on r.id = re.role_id
where
	role_name ilike '%Java%'
	and not role_name ilike '%JavaScript%';

-- Вывести имена и должность только Python разработчиков.
select employee_name, role_name
from employees e 
join roles_employee re
	on re.employee_id = e.id
join roles r 
	on r.id = re.role_id
where role_name ilike '%Python%';

-- Вывести имена и должность всех QA инженеров.
select employee_name, role_name
from employees e 
join roles_employee re
	on re.employee_id = e.id
join roles r 
	on r.id = re.role_id
where role_name ilike '%QA%';

-- Вывести имена и должность ручных QA инженеров.
select employee_name, role_name
from employees e 
join roles_employee re
	on re.employee_id = e.id
join roles r 
	on r.id = re.role_id
where role_name ilike '%Manual%QA%';

-- Вывести имена и должность автоматизаторов QA.
select employee_name, role_name
from employees e 
join roles_employee re
	on re.employee_id = e.id
join roles r 
	on r.id = re.role_id
where role_name ilike '%Auto%QA%';

-- Вывести имена и зарплаты Junior специалистов.
select employee_name, role_name, monthly_salary
from employees e 
join roles_employee re
	on re.employee_id = e.id 
join roles r 
	on r.id = re.role_id 
join employee_salary es
	on es.employee_id = e.id 
join salary s 
	on s.id = es.salary_id
where role_name ilike '%Junior%';

-- Вывести имена и зарплаты Middle специалистов.
select employee_name, role_name, monthly_salary
from employees e 
join roles_employee re
	on re.employee_id = e.id 
join roles r 
	on r.id = re.role_id 
join employee_salary es
	on es.employee_id = e.id 
join salary s 
	on s.id = es.salary_id
where role_name ilike '%Midle%';

-- Вывести имена и зарплаты Senior специалистов.
select employee_name, role_name, monthly_salary
from employees e 
join roles_employee re
	on re.employee_id = e.id 
join roles r 
	on r.id = re.role_id 
join employee_salary es
	on es.employee_id = e.id 
join salary s 
	on s.id = es.salary_id
where role_name ilike '%Senior%';

-- Вывести зарплаты Java разработчиков.
select role_name, monthly_salary
from roles r 
join roles_employee re
	on re.employee_id = r.id 
join employee_salary es
	on es.employee_id = re.employee_id
join salary s
	on s.id = es.salary_id
where
	role_name ilike '%Java%'
	and not role_name ilike '%JavaScript%';

-- Вывести зарплаты Python разработчиков.
select role_name, monthly_salary
from roles r 
join roles_employee re
	on re.employee_id = r.id 
join employee_salary es
	on es.employee_id = re.employee_id
join salary s
	on s.id = es.salary_id
where role_name ilike '%Python%';

-- Вывести имена и зарплаты Junior Python разработчиков.
select employee_name, role_name, monthly_salary
from employees e
join roles_employee re
	on re.employee_id = e.id
join roles r  
	on r.id = re.role_id 
join employee_salary es
	on es.employee_id = e.id 
join salary s 
	on s.id = es.salary_id
where role_name ilike 'Junior%Python%';

-- Вывести имена и зарплаты Middle JS разработчиков.
select employee_name, role_name, monthly_salary
from employees e
join roles_employee re
	on re.employee_id = e.id
join roles r  
	on r.id = re.role_id 
join employee_salary es
	on es.employee_id = e.id 
join salary s 
	on s.id = es.salary_id
where role_name ilike 'Middle%JavaScript%';

-- Вывести имена и зарплаты Senior Java разработчиков.
select employee_name, role_name, monthly_salary
from employees e
join roles_employee re
	on re.employee_id = e.id
join roles r  
	on r.id = re.role_id 
join employee_salary es
	on es.employee_id = e.id 
join salary s 
	on s.id = es.salary_id
where
	role_name ilike 'Senior%Java%developer%'
	and not role_name ilike 'Senior%JavaScript%';

-- Вывести зарплаты Junior QA инженеров.
select employee_name, role_name, monthly_salary
from employees e
join roles_employee re
	on re.employee_id = e.id
join roles r  
	on r.id = re.role_id 
join employee_salary es
	on es.employee_id = e.id 
join salary s 
	on s.id = es.salary_id
where role_name ilike '%Junior%QA%';

-- Вывести среднюю зарплату всех Junior специалистов.
select avg(monthly_salary) as average_junior_salary
from roles r 
join roles_employee re  
	on re.role_id = r.id
join employee_salary es  
	on es.employee_id = re.employee_id
join salary s
	on s.id = es_salary_id
where role_name ilike '%Junior%';

-- Вывести сумму зарплат JS разработчиков.
select sum(monthly_salary) as JS_salary_amount
from roles r 
join roles_employee re  
	on re.role_id = r.id
join employee_salary es  
	on es.employee_id = re.employee_id
join salary s
	on s.id = es_salary_id
where role_name ilike '%JavaScript%';

-- Вывести минимальную ЗП QA инженеров.
select min(monthly_salary) as minimal_QA_salary
from roles r 
join roles_employee re  
	on re.role_id = r.id
join employee_salary es  
	on es.employee_id = re.employee_id
join salary s
	on s.id = es_salary_id
where role_name ilike '%QA%';

-- Вывести максимальную ЗП QA инженеров.
select max(monthly_salary) as maximal_QA_salary
from roles r 
join roles_employee re  
	on re.role_id = r.id
join employee_salary es  
	on es.employee_id = re.employee_id
join salary s
	on s.id = es_salary_id
where role_name ilike '%QA%';

-- Вывести количество QA инженеров.
select count(id) as QA_population
from employees e 
join roles_employee re
	on re.employee_id = e.id
join roles r  
	on r.id = re.role_id
where role_name ilike '%QA%';

-- Вывести количество Middle специалистов.
select count(id) as midle_employee_population
from employees e 
join roles_employee re
	on re.employee_id = e.id
join roles r
	on r.id = re.role_id
where role_name ilike '%Midle%';

-- Вывести количество разработчиков.
select count(id) as developer_population
from employees e 
join roles_employee re
	on re.employee_id = e.id 
join roles r
	on r.id = re.role_id
where role_name ilike '%developer%';

-- Вывести фонд (сумму) зарплаты разработчиков.
select sum(monthly_salary) as developers_salary_amount
from roles r 
join roles_employee re
	on re.role_id = r.id
join employee_salary es
	on es.emloyee_id = re.employee_id
join salary s
	on s.id = es.salary_id
where role_name ilike '%developer%';

-- Вывести имена, должности и ЗП всех специалистов по возрастанию.
select employee_name, role_name, monthly_salary
from employees e 
join roles_employee re 
	on re.employee_id = e.id 
join roles r 
	on r.id = re.role_id
join employee_salary es 
	on es_employee_id = e.id 
join salary s 
	on s.id = es.salary_id
order by monthly_salary;

-- Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 170 000 до 230 000.
select employee_name, role_name, monthly_salary
from employees e 
join roles_employee re 
	on re.employee_id = e.id 
join roles r 
	on r.id = re.role_id
join employee_salary es 
	on es_employee_id = e.id 
join salary s 
	on s.id = es.salary_id 
where monthly_salary between 170000 and 230000
order by monthly_salary;

-- Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 230 000.
select employee_name, role_name, monthly_salary
from employees e 
join roles_employee re 
	on re.employee_id = e.id 
join roles r 
	on r.id = re.role_id
join employee_salary es 
	on es_employee_id = e.id 
join salary s 
	on s.id = es.salary_id
where monthly_salary < 230000
order by monthly_salary;

-- Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 110 000, 150 000, 200 000.
select employee_name, role_name, monthly_salary
from employees e 
join roles_employee re 
	on re.employee_id = e.id 
join roles r 
	on r.id = re.role_id
join employee_salary es 
	on es_employee_id = e.id 
join salary s 
	on s.id = es.salary_id
where monthly_salary in(110000, 150000, 200000)
order by monthly_salary;
