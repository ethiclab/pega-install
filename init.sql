drop database if exists pegadb;
drop user if exists baseuser;
create user baseuser password '!m!JSF8a';
create database pegadb owner baseuser;
