CREATE
    EXTENSION IF NOT EXISTS "uuid-ossp";

create table houses
(
    id   uuid primary key    not null,
    name varchar(255) unique not null
);

create table authentication_tokens
(
    id          uuid primary key    not null,
    token       varchar(255) unique not null,
    valid_from  timestamp           not null,
    valid_until timestamp           not null,
    is_valid    bool                not null default true,
    in_use      boolean             not null default false,
    id_house    uuid                not null references houses (id)
);

create table accounts
(
    id                      uuid primary key    not null,
    name                    varchar(255) unique not null,
    id_house                uuid                not null references houses (id),
    id_authentication_token uuid                not null references authentication_tokens (id)
);

create table environments
(
    id       uuid primary key not null,
    name     varchar(255)     not null,
    house_id uuid             not null references houses (id)
);

create table devices
(
    id             uuid primary key not null,
    color_code     varchar(255),
    feedback_topic varchar(255)     not null,
    is_online      boolean          not null,
    lwt_topic      varchar(255)     not null,
    name           varchar(255)     not null,
    device_type    varchar(100)     not null,
    environment_id uuid             not null,
    house_id       uuid             not null references houses (id)
);

create table switchers
(
    id            uuid primary key not null,
    command_topic varchar(255)     not null unique,
    device_id     uuid references devices (id)
);

create table switchers_actions
(
    id           uuid primary key not null,
    logic_state  varchar(255)     not null,
    mqtt_command varchar(255)     not null,
    name         varchar(255)     not null,
    switcher_id  uuid             not null
);

create table switchers_history
(
    id          uuid primary key not null,
    logic_state varchar(255)     not null,
    stored_at   timestamp        not null,
    switcher_id uuid             not null
);