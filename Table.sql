create table person
(
    id serial,
    name      varchar(50)  not null,
    gender    char(1)      not null,
    phone     char(10),
    date_of_birth       date         not null,
    province   varchar(50) not null,
    district   varchar(50) not null,
    ward       varchar(50) not null,
    address    varchar(100),
    constraint person_pk primary key (id),
    constraint check_person_gender check ( gender = 'M' or gender = 'F')
);
-- Xong
create table staff
(
    id      int,
    title         varchar(20),
    qualification varchar(20),
    note          text,
    site_id int,
    constraint staff_pk primary key (id),
		constraint staff_person_fk foreign key (id) references person (id)
);
-- Xong
create table site
(
    id    serial,
    name       varchar(100) not null,
    province   varchar(20) not null,
    district   varchar(20) not null,
    ward       varchar(20) not null,
    address    varchar(200),
    manager_id int,
    constraint site_pk primary key (id),
		constraint site_staff_fk foreign key (manager_id) references staff (id)
);
-- Xong
create table age
(
    id smallint,
    min_age  smallint,
    max_age  smallint,
    constraint age_pk primary key (id)
);
-- Xong
create table vaccine
(
    id        serial,
    name              varchar(30) not null,
    antigen           text,
    manufacturer      varchar(30) not null,
    storage_condition text,
    description       text,
    group_id          smallint,
    constraint vaccine_pk primary key (id),
		constraint vaccine_group_fk foreign key (group_id) references age (id)
);
-- Xong
create table batch
(
    id   serial,
    vaccine_id int      not null,
		site_id 	 int		  not null,
    dom        date,
    exp        date     not null,
		add_at	 date,
    quantity   smallint not null,
		injected 		 smallint,
    constraint batch_pk primary key (id),
		constraint batch_vaccine_fk foreign key (vaccine_id) references vaccine (id)
);
-- Xong
create table plan
(
    id    serial,
    vaccine_id int      not null,
    site_id    int      not null,
    manager_id int,
    group_id   smallint not null,
    date       date default now(),
    quantity   smallint not null,
    injected   smallint default 0,
    constraint plan_pk primary key (id),
    constraint check_plan_quantity check ( injected <= quantity ),
    constraint plan_vaccine_fk foreign key (vaccine_id) references vaccine (id),
    constraint plan_site_fk foreign key (site_id) references site (id),
    constraint plan_staff_fk foreign key (manager_id) references staff (id),
    constraint plan_group_fk foreign key (group_id) references age (id)
);
-- Xong
create table dose
(
    id    serial,
    plan_id    int not null,
    injector_id   int not null,
    screener_id   int not null,
    person_id  int not null,
    batch_id int not null,
    constraint dose_pk primary key (id),
		constraint dose_plan_fk foreign key (plan_id) references plan (id),
    constraint dose_staff_injector_fk foreign key (injector_id) references staff (id),
    constraint dose_staff_screener_fk foreign key (screener_id) references staff (id),
    constraint dose_person_fk foreign key (person_id) references person (id),
    constraint dose_batch_fk foreign key (batch_id) references batch (id)
);