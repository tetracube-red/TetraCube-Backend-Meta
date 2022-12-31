create extension if not exists "uuid-ossp";

create schema if not exists gateway;

create table if not exists gateway.tetracubes
(
    id uuid primary key not null,
    name varchar(255) unique not null
);

create table if not exists gateway.guests
(
    id uuid primary key not null,
    nickname varchar(255) unique not null,
    password varchar(255) not null,
    tetracube_id uuid not null references gateway.tetracubes (id)
);

create table if not exists gateway.permissions
(
    id uuid primary key not null,
    name varchar(255) unique not null
);

create table if not exists gateway.guests_permissions
(
    guest_id uuid not null references gateway.guests (id),
    permission_id uuid not null references gateway.permissions (id),
    primary key (guest_id, permission_id)
);

insert into gateway.permissions
values
    ('cdedb6b9-b818-4643-8ae8-e66e3d5f0825', 'CAN_SMART_HOME'),
    ('479a54d6-21a1-485e-bd6d-95ad326efcfe', 'CAN_TO_DO');