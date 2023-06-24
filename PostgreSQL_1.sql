-- PostgreSQL 15.3

-- создать и использовать базу humanresources
create database humanresources;

use humanresources;

-- создать, заполнить и проверить таблицу employees
create table employees
	(
		id serial primary key,
		employee_name varchar(100) not null
	);

desc employees;

insert into employees(id, employee_name)
values (default, 'Aleksey Ivanov'),
       (default, 'Roman Petrov'),
	(default, 'Aleksandr Makushev');

select * from employees;

-- создать, заполнить и проверить таблицу salary
create table salary
	(
		id serial primary key,
		monthly_salary int not null
	);

desc salary;

insert into salary(sal_id, monthly_salary)
values (default, 1200000.00),
       (default, 300000.00),
	(default, 80000.00);

select * from salary;

-- создать, заполнить и проверить таблицу employee_salary
create table employee_salary
	(
		id serial primary key,
		employee_id int not null unique,
			foreign key (employee_id) references employees (id),
		salary_id int not null unique,
			foreign key (salary_id) references salary (id),
		insalary_date date not null
	);

desc employee_salary;

insert into employee_salary(id, employee_id, salary_id, insalary_date)
values (default, 1, 3, '2023-06-01'),
       (default, 2, 1, '2023-06-15'),
	(default, 3, 2, '2023-05-02');

select * from employee_salary;

-- создать таблицу roles
create table roles
(id serial primary key,
role_name date not null);

-- сменить тип поля role_name в таблице roles 
alter table roles
alter column role_name varchar(50) not null; 

-- добавить поле role_crew в таблицу roles
alter table roles
add column role_crew varchar(30) not null after role_name;

-- удалить поле role_crew из таблицы roles
alter table roles
drop column role_crew;

-- заполнить и проверить таблицу roles
insert into roles(id, role_name)
values (default, 'python developer'),
       (default, 'typescript developer'),
	(default, 'COO'),
	(default, 'QA engineer');
	   
select * from roles

-- создать, заполнить и проверить таблицу roles_employee
create table roles_employee
	(
		id serial primary key,
		employee_id int not null unique,
			foreign key (employee_id) references employees (id),
		role_id int not null unique,
			foreign key (role_id) references roles (id),
		inrole_date date default '2023-01-01'
	);

desc roles_employee

insert into roles_employee(id, employee_id, role_id, inrole_date)
values (default, 1, 2, '2023-02-15'),
       (default, 2, 3, default),
	(default, 3, 4, '2023-06-28');

select * from roles_employee;
