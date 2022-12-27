CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

create schema if not exists smart_home_guru;

create table if not exists smart_home_guru.environments
(
    id       uuid primary key not null,
    name     varchar(255)     not null,
    house_id uuid             not null
);

create table if not exists smart_home_guru.devices
(
    id             uuid primary key not null,
    color_code     varchar(255),
    feedback_topic varchar(255)     not null,
    is_online      boolean          not null,
    lwt_topic      varchar(255)     not null,
    name           varchar(255)     not null,
    device_type    varchar(100)     not null,
    environment_id uuid             not null,
    house_id       uuid             not null
);

create table if not exists smart_home_guru.switchers
(
    id            uuid primary key not null,
    command_topic varchar(255)     not null unique,
    device_id     uuid references smart_home_guru.devices (id)
);

create table if not exists smart_home_guru.switchers_actions
(
    id           uuid primary key not null,
    logic_state  varchar(255)     not null,
    mqtt_command varchar(255)     not null,
    name         varchar(255)     not null,
    switcher_id  uuid             not null
);

create table if not exists smart_home_guru.switchers_history
(
    id          uuid primary key not null,
    logic_state varchar(255)     not null,
    stored_at   timestamp        not null,
    switcher_id uuid             not null
);