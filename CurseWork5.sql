-- Таблица "Плюшки"
create table Plushka(
	plush_id serial primary key,
	plush_name varchar(255) not null unique);
					 
-- Таблица "Предложения"
create table Predloga(
	pred_id serial primary key,
	pred_name varchar(255) not null unique,
	status boolean not null unique);
						
-- Таблица "Набор плюшек"
create table Nabor_Plushek(
	plush_id int not null,
	pred_id int not null,
	primary key (plush_id, pred_id),
	foreign key (plush_id)
		references Plushka(plush_id)
			on update cascade on delete restrict,
	foreign key (pred_id)
		rederences Predloga(pred_id)
			on update cascade on delete restrict);
			
-- Таблица "История предложения"
create table History_Predloga(
	pred_id int not null,
	open_date date not null,
	const_cost decimal not null
		check (const_cost >= 0),
	time_cost decimal not null
		check (time_cost >= 0),
	close_date date,
	primary key (pred_id, open_date)
	foreign key(pred_id)
		references Predloga(pred_id)
			on update cascade on delete restrict);
			
-- Таблица "Клиент"
create table Client(
	client_name varchar(30) not null,
	client_password varchar(30) not null,
	client_mail varchar(30) not null,
	primary key(client_name));
	
-- Таблица "Покупка"
create table Buying(
	client_name varchar(30),
	pred_id int not null,
	buy_date date not null,
	buy_type varchar(30) not null,
	primary key(client_name, pred_id, buy_date),
	foreign key(client_name)
		references Client(client_name)
			on update cascade on delete restrict);
	
-- Таблица "Техническое задания (Изменение)"
create table Tech_Change(
	pred_id int not null,
	post_date date not null,
	tech_comment text,
	const_cost decimal not null
		check (const_cost >= 0),
	primary key (pred id, post_date),
	foreign key (pred_id)
		references Predloga(pred_id)
			on update cascade on delete restrict);

-- Таблица "Техническое задание (Создание)"
create table Tech_Create(
	tech_num serial primary key,
	post_date date not null,
	pred_name varchar(255) not null unique,
	tech_comment(text));

-- Таблица "Плюшки для предложения"
create table PlushkiDlaPred(
	tech_num int not null,
	plush_id int not null,
	plush_name varchar(30),
	primary key (tech_num, plush_id),
	foreign key (tech_num)
		references Tech_Create(tech_num)
			on update cascade on delete restrict);

		
		
-- СОЗДАНИЕ ИНДЕКСОВ
		
--Таблица "Плюшки"
create index Plushka_plush_name on Plushka(plush_name);

-- Таблица "Предложения"
create index Predloga_pred_name on Predloga(pred_name);
create index Predloga_status on Predloga(status);

-- Таблица "История предложения"
create index History_Predloga_const_cost on History_Predloga(const_cost);
create index History_Predloga_time_cost on History_Predloga(time_const);
create index History_Predloga_close_date on History_Predloga(close_date);

-- Таблица "Покупка"
create index Buying_buy_type on Buying(buy_type);

-- Таблица "Техническое задание (Создание)"
create index Tech_Create_post_date on Tech_Create(post_date);



-- Заполнение таблиц тестовыми данными

-- Заполнение таблицы "Плюшки"
insert into Plushka
	values
		('1', 'Алмазный меч'),
		('2', 'Алмазная кирка'),
		('3', 'Плащ невидимка'),
		('4', 'Админка на 2 часа'),
		('5', 'Админка на 4 часа'),
		('6', 'Админка на 12 часов'),
		('7', 'Админка на 24 часа'),
		('8', 'Кошель с золотом'),
		('10', 'Кулек с золотом'),
		('11', 'Мешочек с золотом'),
		('12', 'Сумка с золотом'),
		('13', 'Сундук с золотом'),
		('14', 'Маленький изумруд'),
		('15', 'Средний изумруд'),
		('16', 'Большой изумруд'),
		('17', 'Огромный изумруд');

select * from Plushka;

-- Заполнение таблицы "Предложения"
insert into Predloga
	values
		('1', 'Алмазная кирка', true),
		('2', 'Алмазный меч', true),
		('3', 'Алмазный комплект', true);

insett into Predloga
	values
	('4', 'Плащ'),
	('4', 'Комплект изумрудов');
	
select * from Predloga;

-- Заполнение таблицы "Набор плюшек"
inser into Nabor_Plushek
	values
		('2', '1'),
		('1', '2'),
		('1', '3'),
		('2', '3'),
		('3', '4'),
		('14', '5'),
		('15', '5'),
		('16', '5');

select * from Nabor_Plushek;

-- Заполнение таблицы "История предложения"
insert into History_Predloga
	values
		('1', '11.05.2023', '59', '9'),
		('2', '11.05.2023', '59', '9'),
		('3', '11.05.2023', '99', '15');

insert into History_Predloga
	values
		('4', '01.05.2023', '199', '50', '08.05.2023'),
		('5', '01.05.2023', '499', '08.05.2023');
	
select * from History_Predloga;

-- Заполнение таблицы "Клиент"
insert into Client
	values
		('_DARK_KNIGHT_', '3i4iuh43', 'bilain_call_center@gmail.com'),
		('Electronic', 'fffff3333', 'Dmitry_Ivanov@gmail.com'),
		('MishaSniper', '12341234', 'Misha1234@gmail.com'),
		('Sasha_2003', 'qwertyuip', 'sassha2003@gmail.com'),
		('Skrilllix', '1234', 'andrusha2004@gmail.com');
	
select * from Cleint;

-- Заполнение таблицы "Покупки"
insert into Buying
	values
		('MishaSniper', '1', '10.05.2023', 'Временный'),
		('MishaSniper', '2', '10.05.2023', 'Постоянный'),
		('MishaSniper', '2', '12.05.2023', 'Временный'),
		('Skrilllix', '4', '09.05.2023', 'Временный'),
		('Skrilllix', '5', '09.05.2023', 'Постоянный');
	
select * from Buying;

-- Заполнение таблицы "Техническое задание (Изменение)"
insert into Tech_Change
	values
		('1', '09.05.2023', 'Повысь цену, очень маленькая', '80', '20'),
		('2', '09.05.2023', 'Также повысь цену', '80', '20'),
		('3', '10.05.2023', 'Останавливай раздачу', '0', '0'),
		('4', '11.05.2023', 'Верни обратно', '300', '150');
	
select * from Tech_Change;

-- Заполнение таблицы "Техническое задание (Добавление)"
insert into Tech_Create
	values
		('1', '13.05.2023', 'Новый алмазный меч'),
		('2', '13.05.2023', 'Новая алмазная кирка'),
		('3', '13.05.2023', 'Новый алмазный комплект'),
		('4', '08.05.2023', 'Золотой комплект'),
		('5', '07.05.2023', 'Мешок сапфиров');
	
select * from Tech_Create:

-- Заполнение таблицы "Плюшки для предложения"
insert into PlushkiDlaPred
	values
		('1', '20', 'Новый алмазный меч'),
		('2', '21', 'Новая алммазная кирка'),
		('3', '22', 'Новый алмазный меч'),
		('4', '23', 'Новая алмазная кирка'),
		('4', '24', 'Кошелек золота'),
		('4', '25', 'Мешочек золота');
		
select * from PlushkiDlaPred