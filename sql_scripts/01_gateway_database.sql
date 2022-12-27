CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

create schema if not exists gateway;

create table if not exists gateway.houses
(
    id   uuid primary key    not null,
    name varchar(255) unique not null
);

create table if not exists gateway.authentication_tokens
(
    id          uuid primary key    not null,
    token       varchar(255) unique not null,
    valid_from  timestamp           not null,
    valid_until timestamp           not null,
    is_valid    bool                not null default true,
    in_use      boolean             not null default false,
    id_house    uuid                not null references gateway.houses (id)
);

create table if not exists gateway.users
(
    id                      uuid primary key    not null,
    name                    varchar(255) unique not null,
    id_house                uuid                not null references gateway.houses (id),
    id_authentication_token uuid                not null references gateway.authentication_tokens (id)
);

create table if not exists gateway.authorizations
(
    id   uuid primary key    not null,
    name varchar(255) unique not null
);

create table if not exists gateway.users_authorizations
(
    user_id          uuid not null references gateway.users (id),
    authorization_id uuid not null references gateway.authorizations (id),
    PRIMARY KEY (user_id, authorization_id)
);

insert into gateway.authorizations values
                                       ('cdedb6b9-b818-4643-8ae8-e66e3d5f0825', 'CAN_SMART_HOME'),
                                       ('479a54d6-21a1-485e-bd6d-95ad326efcfe', 'CAN_TO_DO');