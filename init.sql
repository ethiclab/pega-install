drop database if exists pegadb;
drop user if exists baseuser;
create user baseuser password 'password';
create database pegadb owner baseuser lc_collate 'it_IT.UTF-8' lc_ctype 'it_IT.UTF-8' encoding UTF8;
