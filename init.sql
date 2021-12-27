drop database if exists pegadb;
drop user if exists baseuser;
create user baseuser password 'password';
create database pegadb owner baseuser;
