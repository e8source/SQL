-- PostgreSQL 15.3

-- Вывести всех студентов в таблице.
select *
from students;

-- Вывести только Id пользователей в обратном порядке.
select id
from students
order by id desc;

-- Вывести только имя пользователей по порядку создания аккаунта.
select name
from students
order by created_on, id;

-- Вывести уникальные email пользователей.
select distinct email
from students;

-- Вывести имя и email пользователей.
select name, email
from students;

-- Вывести id, имя, email и дату создания пользователей для всех зарегистированных с 5 февраля 2023.
select id, name, email, created_on
from students
where created_on >= '2023-02-05 00:00:00'
order by created_on;

-- Вывести пользователей где password f5HNd8aaKW2.
select *
from students
where password = 'f5HNd8aaKW2';

-- Вывести пользователей которые были созданы 2021-10-01 10:00:20.
select *
from students
where created_on = '2021-10-01 10:00:20';

-- Вывести пользователей с именем Aleksandr.
select *
from students
where name ilike '%Aleksandr%'
order by name;

-- Вывести пользователей с именами заканчивающимися на "l".
select *
from students
where name like '%l'
order by name;

-- Вывести id и имя пользователей где в имени в есть буква а.
select id, name
from students
where name ilike '%a%'
order by name;

-- Вывести пользователей которые были созданы c 2021-10-01 10:00:32 по 2021-10-01 11:20:57, по убыванию времени.
select *
from students
where created_on between '2021-10-01 10:00:32' and '2021-10-01 11:20:57'
order by created_on desc;

-- Вывести id и имя пользователей которые были созданы 2021-10-01 11:05:34 с емейлом gmail.
select id, name
from students
where
	created_on = '2021-10-01 11:05:34'
	and email ilike '%@gmail.com'
order by email;

-- Вывести id и имя пользователей которые были созданы 2021-10-01 10:01:17 и у которых в имени есть слово pavel или Pavel.
select id, name
from students
where
	created_on = '2021-10-01 10:01:17'
	and name ilike (%Pavel%)
order by name;

-- Вывести id и имя пользователей которые были созданы 2021-10-01 10:01:42 и у которых в имени есть s.
select id, name
from students
where
	created_on = '2021-10-01 10:01:42'
	and name ilike (%s%)
order by name;

-- Вывести пользователей у которых id равен 110.
select *
from students
where id = 110;

-- Вывести имена пользователей у которых id не равен значению от 153 до 2500.
select name
from students
where not id between 153 and 2500
order by name;

-- Вывести пользователей у которых id меньше 127 или больше 188.
select *
from students
where
	id < 127
	or id > 188;

-- Вывести id и имя пользователей у которых id меньше либо равно 137 и фамилия Ivanov.
select id, name
from students
where
	id <= 137
	and name ilike '%Ivanov%';

-- Вывести пользователя у которых id больше либо равно 137 и емейлы @gmail.
select *
from students
where
	id >= 137
	and email ilike '%@gmail.com';

-- Вывести пользователя у которых id больше 180 но меньше 190.
select *
from students
where
	id > 180
	and id < 190;

-- Вывести пользователя у которых id между 180 и 190.
select *
from students
where id between 180 and 190;

-- Вывести пользователей где password равен Pse5Ng8bD7, vDOZ2QNXL1, G77S1sVjt2.
select *
from students
where password in('Pse5Ng8bD7', 'vDOZ2QNXL1', 'G77S1sVjt2');

-- Вывести пользователей где created_on равен 2021-10-01 10:00:39, 2021-10-01 10:00:44, 2021-10-01 10:00:49.
select *
from students
where created_on in('2021-10-01 10:00:39', '2021-10-01 10:00:44', '2021-10-01 10:00:49');

-- Вывести минимальный id.
select min(id)
from students;

-- Вывести максимальный.
select max(id)
from students;

-- Вывести количество пользователей.
select count(id) as student_population
from students;

-- Вывести id пользователя, имя, дату создания пользователя. Отсортировать по порядку возрастания даты добавления пользоватлеля.
select id, name, created_on
from students
order by created_on asc;

-- Вывести id пользователя, имя, дату создания пользователя. Отсортировать по порядку убывания даты добавления пользоватлеля.
select id, name, created_on
from students
order by created_on desc;

-- Вывести отсортированное количество уникальных емейлов @gmail пользователей
select count(email) as total_emails
from students
where email ilike '%@gmail.com'
group by email
order by email;
