create database argosdb;

create table if not exists argosdb.people (
    id varchar(36) not null,
    name varchar(20) not null,
    email varchar(50) not null unique,
    cpf varchar(11) not null unique,
    birthdate date,
    primary key (id)
);

create table if not exists argosdb.phones (
    id varchar(36) not null,
    region_code varchar(2) not null,
    value varchar(15) not null,
    person_id varchar(36) not null,
    foreign key (person_id) references people(id),
    primary key (id)
);

create table if not exists argosdb.admins (
    id varchar(36) not null,
    username varchar(50) not null,
    password varchar(100) not null,
    created_at datetime not null,
    updated_at datetime,
    role int not null,
    person_id varchar(36) not null,
    foreign key (person_id) references people(id),
    primary key (id)
);

create table if not exists argosdb.advertisers (
    id varchar(36) not null,
    created_at datetime not null,
    updated_at datetime,
    person_id varchar(36) not null,
    foreign key (person_id) references people(id),
    primary key (id)
);

create table if not exists argosdb.customers (
    id varchar(36) not null,
    created_at datetime not null,
    updated_at datetime,
    person_id varchar(36) not null,
    foreign key (person_id) references people(id),
    primary key (id)
);

create table if not exists argosdb.addresses (
    id varchar(36) not null,
    country_code varchar(2) not null,
    state_code varchar(2) not null,
    street_name varchar(50) not null,
    number int not null,
    zipcode varchar(15) not null,
    complement varchar(50),
    person_id varchar(36) not null,
    foreign key (person_id) references people(id),
    primary key (id)
);

create table if not exists argosdb.products_classification (
    id varchar(36) not null,
    value varchar(50)
);

create table if not exists argosdb.products (
    id varchar(36) not null,
    name varchar(50) not null,
    price decimal(7,2) not null check (price > 0.00),
    created_at datetime not null,
    updated_at datetime,
    advertiser_id varchar(36) not null,
    products_classification_id varchar(36) not null,
    primary key (id),
    foreign key (advertiser_id) references advertisers(id),
    foreign key (products_classification_id) references advertisers(id)
);

create table if not exists argosdb.inventory_items (
    id varchar(36) not null,
    status int not null,
    amount int not null check (amount >= 0),
    updated_at datetime,
    product_id varchar(36) not null,
    foreign key (product_id) references products(id)
);

create table if not exists argosdb.sales (
    id varchar(36) not null,
    created_at datetime not null,
    total_value decimal(7,2) not null check (total_value > 0.00),
    customer_id varchar(36) not null,
    primary key (id),
    foreign key (customer_id) references customers(id)
);

create table if not exists argosdb.sales_items (
    id varchar(36) not null,
    product_id varchar(36) not null,
    sale_id varchar(36) not null,
    amount int not null check (amount > 0),
    foreign key (product_id) references products(id),
    foreign key (sale_id) references sales(id)
);