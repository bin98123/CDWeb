DROP TABLE  IF EXISTS user;
DROP TABLE follow IF EXISTS;
DROP TABLE cart IF EXISTS;
DROP TABLE product IF EXISTS;
DROP TABLE shop IF EXISTS;
DROP TABLE img IF EXISTS;

CREATE TABLE cart (
    id VARCHAR(30) PRIMARY KEY,
    idProduct VARCHAR(30),
    idUser VARCHAR(30),
    total INTEGER CHECK (total >= 0),
    status NVARCHAR(255),
    delivered bit ,
    cancel bit,
    verify bit,
    orderDate DATE,
    deliveredDate DATE
);


CREATE TABLE product (
    id VARCHAR(30) PRIMARY KEY,
    idshop VARCHAR(30), 
    name NVARCHAR(255) NOT NULL,
    total INTEGER CHECK (total >= 0),
    description NVARCHAR(255) NOT NULL,
    type NVARCHAR(255),
    made_in VARCHAR(30),
    idimg VARCHAR(255),
    kind NVARCHAR(255),
    brand NVARCHAR(255), 
    color NVARCHAR(255), 
    size VARCHAR(5),
    male bit,
    cost bigint ,
    date_add DATE,
    views INTEGER CHECK (views >= 0)
);


CREATE TABLE user (
    id VARCHAR(30) PRIMARY KEY,
    fullname NVARCHAR(255) NOT NULL,
    email VARCHAR(150) NOT NULL,
    address NVARCHAR(255) NOT NULL,
    username VARCHAR(10) NOT NULL,
    password VARCHAR(15) NOT NULL,
    phonenumber VARCHAR(15) NOT NULL,
    actived bit,
    shop bit,
    admin bit,
    birthday DATE NOT NULL
);


CREATE TABLE follow (
    id VARCHAR(30) PRIMARY KEY,
    iduser VARCHAR(30),
    idfollower VARCHAR(30)
)

CREATE TABLE shop (
    id VARCHAR(30) PRIMARY KEY,
    iduser VARCHAR(30),
    name VARCHAR(30)
)
CREATE TABLE img (
    id VARCHAR(30) PRIMARY KEY,
    idimg VARCHAR(30),
    idproduct VARCHAR(30),
    srcimg VARCHAR(255)
)