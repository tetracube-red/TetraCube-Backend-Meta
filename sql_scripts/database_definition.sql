CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

create table if not exists houses
(
    id   uuid primary key    not null,
    name varchar(255) unique not null
);

create table if not exists authentication_tokens
(
    id          uuid primary key    not null,
    token       varchar(255) unique not null,
    valid_from  timestamp           not null,
    valid_until timestamp           not null,
    is_valid    bool                not null default true,
    in_use      boolean             not null default false
);

create table if not exists accounts
(
    id                      uuid primary key    not null,
    name                    varchar(255) unique not null,
    id_house                uuid                not null references houses (id),
    id_authentication_token uuid                not null references authentication_tokens (id)
);