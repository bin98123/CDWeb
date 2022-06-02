DROP TABLE student IF EXISTS;

create table student (studentid char(8) primary key, name nvarchar(255), male bit, birthday date, placeofbirth nvarchar(255), address nvarchar(255), depname nvarchar(255));
