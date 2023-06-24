-- sql-academy.org/ru/trainer
-- MySQL 8.0

-- 1 Вывести имена всех людей, которые есть в базе данных авиакомпаний
select name 
from Passenger;

-- 2 Вывести названия всеx авиакомпаний
select name
from Company;

-- 3 Вывести все рейсы, совершенные из Москвы
select *
from Trip
where town_from like 'Moscow%';

-- 4 Вывести имена людей, которые заканчиваются на "man"
select name
from Passenger
where name like '%man';

-- 5 Вывести количество рейсов, совершенных на TU-134
select count(*) as tu134_total_flights
from Trip
where plane like 'TU_134%';

-- 6 Какие компании совершали перелеты на Boeing
select distinct name
from Company as c
inner join Trip as t
	on t.company = c.id
where t.plane like 'Boeing%';

--  7 Вывести все названия самолётов, на которых можно улететь в Москву (Moscow)
select plane
from Trip
where town_to like '%Moscow%'
group by plane;

-- 8 В какие города можно улететь из Парижа (Paris) и сколько времени это займёт?
select town_to, timediff(time_in, time_out) as flight_time
from Trip
where town_from like 'Paris%';

-- 9 Какие компании организуют перелеты из Владивостока (Vladivostok)?
select name
from Company as c 
inner join Trip as t 
	on t.company = c.id 
where town_from like 'Vladivostok%';

-- 10 Вывести вылеты, совершенные с 10 ч. по 14 ч. 1 января 1900 г.
select *
from Trip
where time_out between '1900-01-01 10:00:00+5' and '1900-01-01 14:00:00+5';

-- 11 Вывести пассажиров с самым длинным именем
select name
from Passenger
where length(name) =
	(
		select max(length(name))
		from Passenger as p
	);

-- 12 Вывести id и количество пассажиров для всех прошедших полётов
select trip, count(passenger) as count
from Pass_in_trip
group by trip;

-- 13 Вывести имена людей, у которых есть полный тёзка среди пассажиров
select distinct p1.name
from Passenger as p1
inner join Passenger as p2
	on p1.name = p2.name
	and p1.id != p2.id;

-- 14 В какие города летал Bruce Willis
select town_to
from Trip as t 
inner join Pass_in_trip as pit
	on pit.trip = t.id
inner join Passenger as p
	on p.id = pit.passenger
where p.name like 'Bruce%Willis%';

-- 15 Выведите дату и время прилёта пассажира Стив Мартин (Steve Martin) в Лондон (London)
select t.time_in 
from Trip as t 
inner join Pass_in_trip as pit
	on pit.trip = t.id
inner join Passenger as p 
	on p.id = pit.passenger
where
	t.town_to like 'London%'
	and p.name like 'Steve%Martin%';

-- 16 Вывести отсортированный по количеству перелетов (по убыванию) и имени (по возрастанию)
--    список пассажиров, совершивших хотя бы 1 полет.
select name, count(trip) as count
from Passenger as p
inner join Pass_in_trip as pit
	on pit.passenger = p.id
group by name
	having count(trip) >= 1
order by count desc, name;

-- 17 Определить, сколько потратил в 2005 году каждый из членов семьи.
-- В результирующей выборке не выводите тех членов семьи, которые ничего не потратили.
select member_name, status, sum(amount*unit_price) as costs
from FamilyMembers as fm 
inner join Payments as p 
	on p.family_member = fm.member_id
where year(p.date) = '2005'
group by p.family_member
	having costs >= 1;

-- 18 Узнать, кто старше всех в семьe
select member_name
from FamilyMembers
where birthday = (select min(birthday)
                 from FamilyMembers);
					   
-- 19 Определить, кто из членов семьи покупал картошку (potato)
select distinct status
from FamilyMembers as fm 
inner join Payments as p 
	on p.family_member = fm.member_id
inner join Goods as g 
	on g.good_id = p.good
where g.good_name like '%potato%';

-- 20 Сколько и кто из семьи потратил на развлечения (entertainment). Вывести статус в семье, имя, сумму
select status, member_name, sum(p.amount*p.unit_price) as costs
from FamilyMembers as fm 
inner join Payments as p 
	on p.family_member = fm.member_id
inner join Goods as g 
	on g.good_id = p.good 
inner join GoodTypes as gt 
	on gt.good_type_id = g.type 
where good_type_name like '%entertainment%'
group by p.family_member;

-- 21 Определить товары, которые покупали более 1 раза
select good_name
from Goods as g 
inner join Payments as p 
	on p.good = g.good_id
group by p.good
	having count(p.good) > 1;

-- 22 Найти имена всех матерей (mother)
select member_name
from FamilyMembers
where status like '%mother%';

-- 23 Найдите самый дорогой деликатес (delicacies) и выведите его цену
select g.good_name, p.unit_price
from GoodTypes as gt   
inner join Goods as g
	on g.type = gt.good_type_id 
inner join Payments as p 
	on p.good = g.good_id
where p.unit_price =
	(
		select max(p.unit_price)
		from Payments as p 
		inner join Goods as g 
			on g.good_id = p.good
		inner join GoodTypes as gt 
			on gt.good_type_id = g.type 
		where gt.good_type_name like '%delicacies%'
	);

-- 24 Определить кто и сколько потратил в июне 2005
select member_name, sum(amount*unit_price) as costs
from Payments as p
inner join FamilyMembers as fm 
	on fm.member_id = p.family_member 
where
	year(p.date) = '2005'
	and month(p.date) = '06'
group by fm.member_name;


-- 25 Определить, какие товары не покупались в 2005 году
select good_name
from Goods
where not good_id in
	(
		select good
		from Payments
		where year(date) = '2005'
	);

-- 26 Определить группы товаров, которые не приобретались в 2005 году
select good_type_name
from GoodTypes
where not good_type_id in
	(
		select g.type
		from Goods as g
		inner join Payments as p 
			on p.good = g.good_id
		where year(date) = '2005'
		group by p.good
	);

-- 27 Узнать, сколько потрачено на каждую из групп товаров в 2005 году. Вывести название группы и сумму
select gt.good_type_name, sum(p.amount*p.unit_price) as costs 
from GoodTypes as gt 
left outer join Goods as g 
	on g.type = gt.good_type_id
inner join Payments as p 
	on p.good = g.good_id
where year(date) = '2005'
group by gt.good_type_name
order by costs desc, gt.good_type_name;

-- 28 Сколько рейсов совершили авиакомпании из Ростова (Rostov) в Москву (Moscow) ?
select count(id) as count
from Trip
where
	town_from like '%Rostov%'
	and town_from not like '%Rostov_na_Donu%'
	and town_to like '%Moscow%';

-- 29 Выведите имена пассажиров улетевших в Москву (Moscow) на самолете TU-134
select p.name
from Passenger as p 
inner join Pass_in_trip as pit
	on p.id = pit.passenger 
inner join Trip as t 
	on t.id = pit.trip
where
	t.town_to like '%Moscow%'
	and t.plane like '%TU_134%'
group by p.name;

-- 30 Выведите нагруженность (число пассажиров) каждого рейса (trip). Результат вывести в отсортированном виде по убыванию нагруженности.
select trip, count(passenger) as count
from Pass_in_trip
group by trip
order by count desc;

-- 31 Вывести всех членов семьи с фамилией Quincey.
select *
from FamilyMembers
where member_name like '%Quincey%';

-- 32 Вывести средний возраст людей (в годах), хранящихся в базе данных. Результат округлите до целого в меньшую сторону.
select floor(avg(year(now()) - year(birthday))) as age
from FamilyMembers;

-- 33 Найдите среднюю стоимость икры. В базе данных хранятся данные о покупках красной (red caviar) и черной икры (black caviar).
select avg(unit_price) as cost 
from Payments as p 
inner join Goods as g 
	on g.good_id = p.good
where
	g.good_name like '%red%caviar%'
	or g.good_name like '%black%caviar%';

-- 34 Сколько всего 10-ых классов
select count(name) as count
from Class
where name like '%10%';

-- 35 Сколько различных кабинетов школы использовались 2.09.2019 в образовательных целях ?
select count(classroom) as count
from Schedule
where date = '2019-09-02';

-- 36 Выведите информацию об обучающихся живущих на улице Пушкина (ul. Pushkina)?
select *
from Student
where address like '%ul.%Pushkina%';

-- 37 Сколько лет самому молодому обучающемуся ?
select min(timestampdiff(year, birthday, now())) as year
from Student;

-- 38 Сколько Анн (Anna) учится в школе ?
select count(first_name) as count
from Student
where first_name = 'Anna';

-- 39 Сколько обучающихся в 10 B классе ?
select count(student) as count
from Student_in_class as sc 
inner join Class as c 
	on c.id = sc.class 
where c.name = '10 B';

-- 40 Выведите название предметов, которые преподает Ромашкин П.П. (Romashkin P.P.) ?
select sj.name as subjects
from Schedule as sd 
inner join Subject as sj 
	on sj.id = sd.subject 
inner join Teacher as t 
	on t.id = sd.teacher 
where
	left(t.first_name, 1) = 'P'
	and left(t.middle_name, 1) = 'P'
	and t.last_name = 'Romashkin';

-- 41 Во сколько начинается 4-ый учебный предмет по расписанию ?
select start_pair
from Timepair as t 
inner join Schedule as s 
	on t.id = s.number_pair
where s.number_pair = 4
group by s.number_pair;

-- 42 Сколько времени обучающийся будет находиться в школе, учась со 2-го по 4-ый уч. предмет ?
select distinct timediff
	(
		(select end_pair from Timepair where id=4),
		(select start_pair from Timepair where id=2)
	) as time
from Timepair;

-- 43 Выведите фамилии преподавателей, которые ведут физическую культуру (Physical Culture). Отcортируйте преподавателей по фамилии.
select last_name
from Teacher as t 
inner join Schedule as sd 
	on t.id = sd.teacher 
inner join Subject as sj 
	on sj.id = sd.subject 
where sj.name = 'Physical Culture'
order by last_name;

-- 44 Найдите максимальный возраст (колич. лет) среди обучающихся 10 классов ?
select max(timestampdiff(year,birthday,now())) as max_year
from Class as c 
inner join Student_in_class as sc 
	on c.id = sc.class 
inner join Student as s 
	on s.id = sc.student 
where c.name like '%10%';

-- 45 Какие кабинеты чаще всего использовались для проведения занятий? Выведите те, которые использовались максимальное количество раз.
select classroom
from Schedule
group by classroom 
having count(classroom) =
	(
		select count(classroom)
		from Schedule
		group by classroom
		order by count(classroom) desc
		limit 1
	);

-- 46 В каких классах введет занятия преподаватель "Krauze" ?
select distinct name 
from Class as c 
inner join Schedule as s 
	on s.class = c.id  
inner join Teacher as t 
	on t.id = s.teacher
where t.last_name = 'Krauze';

-- 47 Сколько занятий провел Krauze 30 августа 2019 г.?
select count(s.id) as count
from Schedule as s 
inner join Teacher as t 
	on t.id = s.teacher 
where
	t.last_name = 'Krauze'
	and s.date = '2019-08-30';

-- 48 Выведите заполненность классов в порядке убывания
select name, count(student) as count
from Class as c 
inner join Student_in_class as s 
	on c.id = s.class 
group by name 
order by count desc;

-- 49 Какой процент обучающихся учится в 10 A классе ?
select count(student)*100/
	(
		select count(student)
		from Student_in_class
	) as percent
from Class as c 
inner join Student_in_class as s 
	on s.class = c.id 
where c.name = '10 A';

-- 50 Какой процент обучающихся родился в 2000 году? Результат округлить до целого в меньшую сторону.
select floor
	(
		count(id)*100/
			(
				select count(id)
				from Student
			)
	) as percent 
from Student
where year(birthday) = 2000;

-- 51 Добавьте товар с именем "Cheese" и типом "food" в список товаров (Goods).
insert into Goods
set
	good_id = (select 1+count(*) from Goods as g),
	good_name = 'Cheese',
	type = (select good_type_id from GoodTypes where good_type_name = 'food');

-- 52 Добавьте в список типов товаров (GoodTypes) новый тип "auto".
insert into GoodTypes 
set good_type_id = (select 1+count(*) from GoodTypes as a),
	good_type_name = 'auto';

-- 53 Измените имя "Andie Quincey" на новое "Andie Anthony".
update FamilyMembers
set member_name = 'Andie Anthony'
where member_name = 'Andie Quincey';

-- 54 Удалить всех членов семьи с фамилией "Quincey".
delete from FamilyMembers
where member_name like '%Quincey%';

-- 55 Удалить компании, совершившие наименьшее количество рейсов.
delete from Company 
where Company.id in
	(
		select company
		from Trip 
		group by company 
			having count(Trip.id) =
				(
					select min(count)
					from
						(
							select count(Trip.id) as count
							from Trip 
							group by company
						) as min_count
				)
	);

-- 56 Удалить все перелеты, совершенные из Москвы (Moscow).
delete from Trip 
where town_from like '%Moscow%';
								
-- 57 Перенести расписание всех занятий на 30 мин. вперед.
update Timepair
set
	start_pair = start_pair + interval 30 minute,
	end_pair = end_pair + interval 30 minute;

-- 58 Добавить отзыв с рейтингом 5 на жилье, находящиеся по адресу "11218, Friel Place, New York", от имени "George Clooney"
insert into Reviews
set
	id = (select 1+count(*) from Reviews as r),
	reservation_id =
		(
			select rs.id
			from Reservations as rs 
			inner join Rooms as rm
				on rm.id = rs.room_id
			inner join Users as u 
				on u.id = rs.user_id 
			where
				rm.address = '11218, Friel Place, New York'
				and u.name = 'George Clooney'
		),
	rating = 5;

-- 59 Вывести пользователей,указавших Белорусский номер телефона ? Телефонный код Белоруссии +375.
select distinct *
from Users 
where phone_number like '%+375%';

-- 60 Выведите идентификаторы преподавателей, которые хотя бы один раз за всё время преподавали в каждом из одиннадцатых классов.
select teacher
from Schedule as s 
inner join Class as c
	on c.id = s.class 
where c.name like '%11%'
group by s.teacher
	having count(distinct c.name) = 2;

-- 61 Выведите список комнат, которые были зарезервированы в течение 12 недели 2020 года.
select distinct Rooms.*
from Rooms 
inner join Reservations
	on Reservations.room_id = Rooms.id
where 
	weekofyear(start_date) = 12
	and year(start_date) = 2020;

-- 62 Вывести в порядке убывания популярности доменные имена 2-го уровня, используемые пользователями для электронной почты.
--    Полученный результат необходимо дополнительно отсортировать по возрастанию названий доменных имён.
select
	substring_index(email, '@', -1) as domain,
	count(substring_index(email, '@', -1)) as count
from Users
group by domain
order by count desc, domain;

-- 63 Выведите отсортированный список (по возрастанию) фамилий и имен студентов в виде Фамилия.И.
select concat(last_name, '.', left(first_name,1), '.') as name
from Student
order by name;

-- 64 Вывести количество бронирований по каждому месяцу каждого года, в которых было хотя бы 1 бронирование.
--    Результат отсортируйте в порядке возрастания даты бронирования.
select
	year(start_date) as year,
	month(start_date) as month,
	count(*) as amount
from Reservations 
group by year, month
order by year;

-- 65 Необходимо вывести рейтинг для комнат, которые хоть раз арендовали, как среднее значение рейтинга отзывов округленное до целого вниз.
select room_id, floor(avg(rating)) as rating
from Reservations as r 
inner join Reviews as rv
	on rv.reservation_id = r.id
group by room_id;

-- 66 Вывести список комнат со всеми удобствами (наличие ТВ, интернета, кухни и кондиционера),
--    а также общее количество дней и сумму за все дни аренды каждой из таких комнат.
select
	home_type,
	address,
	ifnull(sum(timestampdiff(day, start_date, end_date)), 0) as days,
	ifnull(sum(total), 0) as total_fee
from Rooms as r 
left outer join Reservations as rv 
	on rv.room_id = r.id
where
	has_tv = true 
	and has_internet = true 
	and has_kitchen = true 
	and has_air_con = true
group by r.id;

-- 67 Вывести время отлета и время прилета для каждого перелета в формате "ЧЧ:ММ, ДД.ММ - ЧЧ:ММ, ДД.ММ",
--    где часы и минуты с ведущим нулем, а день и месяц без.
select concat
	(
		date_format(time_out, '%H:%i, %e.%c'),
		' - ',
		date_format(time_in, '%H:%i, %e.%c')
	) as flight_time
from Trip;

-- 68 Для каждой комнаты, которую снимали как минимум 1 раз, найдите имя человека, снимавшего ее последний раз, и дату, когда он выехал
select room_id, name, end_date
from Reservations as r 
inner join Users as u 
	on u.id = r.user_id
where end_date in
	(
		select max(end_date)
		from Reservations as rv
		group by room_id
	);

-- 69 Вывести идентификаторы всех владельцев комнат, что размещены на сервисе бронирования жилья и сумму, которую они заработали
select owner_id, ifnull(sum(total),0) as total_earn
from Rooms as r 
left outer join Reservations as rv 
	on rv.room_id = r.id
group by r.owner_id;

-- 70 Необходимо категоризовать жилье на economy, comfort, premium по цене соответственно <= 100, 100 < цена < 200, >= 200.
--    В качестве результата вывести таблицу с названием категории и количеством жилья, попадающего в данную категорию
select
	case
		when price <= 100 then 'economy'
		when price > 100 and price < 200 then 'comfort'
		when price >= 200 then 'premium'
	end as category,
	count(id) as count
from Rooms
group by category;

-- 71 Найдите какой процент пользователей, зарегистрированных на сервисе бронирования, хоть раз арендовали или сдавали в аренду жилье.
--    Результат округлите до сотых.
select round
	(
		(
			select count(*) from
				(
					select distinct owner_id
					from Rooms as r 
					inner join Reservations as rv 
						on rv.room_id = r.id
				union 
					select distinct user_id
					from Reservations as rvt
				) as uo
		)*100/(select count(id) from Users), 2
	) as percent;
		
-- 72 Выведите среднюю стоимость бронирования для комнат, которых бронировали хотя бы один раз.
--    Среднюю стоимость необходимо округлить до целого значения вверх.
select room_id, ceiling(avg(price)) as avg_price
from Reservations
group by room_id;

-- 73 Выведите id тех комнат, которые арендовали нечетное количество раз
select room_id, count(room_id) as count
from Reservations
group by room_id
	having mod(count, 2) != 0;

-- 74 Выведите идентификатор и признак наличия интернета в помещении.
--    Если интернет в сдаваемом жилье присутствует, то выведите «YES», иначе «NO».
select
	id,
	case
		when has_internet = true then 'YES'
		when has_internet = false then 'NO'
	end as has_internet
from Rooms;

-- 75 Выведите фамилию, имя и дату рождения студентов, кто был рожден в мае.
select last_name, first_name, birthday
from Student
where month(birthday) = 5;

-- 76 Вывести имена всех пользователей сервиса бронирования жилья, а также два признака:
--    является ли пользователь собственником какого-либо жилья (is_owner) и является ли пользователь арендатором (is_tenant).
--    В случае наличия у пользователя признака необходимо вывести в соответствующее поле 1, иначе 0.
select
	name,
	if(id in (select distinct owner_id from Rooms), 1, 0) as is_owner,
	if(id in (select user_id from Reservations), 1, 0) as is_tenant
from Users;
