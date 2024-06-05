/*
title: Task Manager database
Author: Yawa Hallo
date: 5/17/2024
Description: Task manager database
*/
-- Drop database if exists
DROP DATABASE IF EXISTS db_task_manager;

-- Create database
CREATE DATABASE db_task_manager;

-- Drop and create user with username to access database
DROP USER IF EXISTS 'user_task_manager'@'localhost';
CREATE USER 'user_task_manager'@'localhost' IDENTIFIED BY 'task';

-- Grant privilege to database user
GRANT ALL ON task_manager.* TO 'user_task_manager'@'localhost';

-- Drop tables if exist
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS tasks;

-- Create tables
CREATE TABLE users (
    user_id             INT          NOT NULL AUTO_INCREMENT,
    user_first_name     VARCHAR(75)  NOT NULL,
    user_last_name      VARCHAR(75)  NOT NULL,
    user_email          VARCHAR(75)  NOT NULL,
    user_password       VARCHAR(75)  NOT NULL,
    user_image          VARCHAR(75)  NOT NULL,

    PRIMARY KEY (user_id)
);

-- Create task table
CREATE TABLE tasks ( 
    task_id             INT          NOT NULL AUTO_INCREMENT,
    user_id             INT          NOT NULL,
    task_title          VARCHAR(75)  NOT NULL,
    task_description    VARCHAR(75)  NOT NULL,
    task_status         VARCHAR(75)  NOT NULL,
    task_deadline       DATE         NOT NULL,
    task_priority       VARCHAR(75)  NOT NULL,
    scheduled_date      DATE         NOT NULL,   

    PRIMARY KEY (task_id),
    CONSTRAINT fk_user_id
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
);

