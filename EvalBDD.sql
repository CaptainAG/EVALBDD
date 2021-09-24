
--Création de la base de donnée si elle n'existe pas
CREATE DATABASE IF NOT EXISTS  EvalBDD;


--Création des tables
CREATE TABLE Admin 
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL, 
    First_name VARCHAR(50) NOT NULL
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE Infos
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Phone INT(10) NOT NULL,
    Adress VARCHAR(50) NOT NULL,
    City    VARCHAR(50) NOT NULL,
    Postal_code VARCHAR(10) NOT NULL,
    id_admin INT NOT NULL,
    FOREIGN KEY (id_admin) REFERENCES Admin(id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE CinemasComplex
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (50) NOT NULL,
    id_info INT(50) NOT NULL ,
    FOREIGN KEY (id_info) REFERENCES Infos (id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE INDEX name ON CinemasComplex(name);

CREATE TABLE Rooms
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    Type_room VARCHAR(50) NOT NULL,
    Nb_place INT (30) NOT NULL
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE Genres
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    Type_genre VARCHAR(50) NOT NULL
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;


CREATE TABLE Moovies 
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Tittle VARCHAR(60) NOT NULL,
    id_genre INT(100) NOT NULL ,
    FOREIGN KEY (id_genre) REFERENCES Genres (id),
    Duration VARCHAR(50) NOT NULL,
    Director VARCHAR(50) NOT NULL
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;
CREATE INDEX tittle_moovie ON Moovies(Tittle);

CREATE TABLE Payments
(
    Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Type_payment VARCHAR (10) NOT NULL
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;


CREATE TABLE Tariffs
(
    id INT NOT NULL PRIMARY KEY, 
    Type_tariff VARCHAR(50) NOT NULL,
    price VARCHAR(5) NOT NULL
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;
CREATE INDEX price ON Tariffs(price);


CREATE TABLE Customers
(
    id CHAR(36) NOT NULL  PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    First_name VARCHAR(50) NOT NULL,
    Age INT(10) NOT NULL,
    email VARCHAR(254) NOT NULL UNIQUE,
    password CHAR(60) NOT NULL,
    id_price INT NOT NULL,
    FOREIGN KEY (id_price) REFERENCES Tariffs(id)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE INDEX First_name ON Customers(First_name);

CREATE TABLE FilmShows
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_room INT NOT NULL,
    tittle_moovie VARCHAR(60) NOT NULL,
    FOREIGN KEY (id_room) REFERENCES Rooms(id),
    FOREIGN KEY (tittle_moovie) REFERENCES Moovies(Tittle),
    start_time DATETIME NOT NULL
)ENGINE=InnoDB  DEFAULT CHARSET=utf8;



CREATE TABLE Bookings
(
    id CHAR(36) NOT NULL PRIMARY KEY,
    First_name_customer VARCHAR(50) NOT NULL,
    FOREIGN KEY (First_name_customer) REFERENCES Customers (First_name),
    start_time DATETIME NOT NULL,
    id_filmShow INT NOT NULL,
    FOREIGN KEY (id_filmShow) REFERENCES FilmShows(id),
    id_room INT NOT NULL,
    FOREIGN KEY (id_room) REFERENCES Rooms(id),
    name_CinemasComplex VARCHAR (50) NOT NULL,
    FOREIGN KEY (name_CinemasComplex) REFERENCES CinemasComplex(name),
    Price VARCHAR(5) NOT NULL,
    FOREIGN KEY (Price) REFERENCES Tariffs(price),
    id_payment INT NOT NULL,
    FOREIGN KEY (id_payment) REFERENCES Payments(id)

)ENGINE=InnoDB  DEFAULT CHARSET=utf8;


--Injection de données factice dans les tables
insert into Admin (Name, First_name)
values ('Smorthit', 'Alli'),
('Shewsmith', 'Symon'),
('Kopec', 'Marcelle'),
('Bonney', 'Trudey'),
('Wroth', 'Joscelin'),
('Bruce', 'Jean'),
('Wayne', 'Alexis');

insert into Infos (Phone, Adress, City, Postal_code,id_admin)
values ('0604199331', '720 Prentice Lane', 'PARIS', '75000',7),
('0605006888', '56 Vermont Street', 'TOULOUSE', '31000',1),
('0606850674', '3 Ramsey Alley', 'LILLE', '59000',2),
('0604616465', '755 Stephen Plaza', 'LAROCHELLE', '17000',3),
('0692592552', '1770 Gerald Trail', 'NIMES', '30000',4),
('0614214339', '06 Lawn Trail', 'PARIS', '75000',5),
('0678691284', '38 Butterfield Plaza', 'TOULOUSE', '31000',6);

insert into CinemasComplex (name,id_info)
values
('UGC TOULOUSE',1),
('UGC LILLE',2),
('UGC LAROCHELLE',3),
('UGC NIMES',4),
('UGC PARIS',7);

insert into Rooms (Type_room, nb_place)
values ('3d', 60),
('2d', 30),
('Confort', 15),
('2d', 50),
('Confort', 20);

insert into Genres (Type_genre)
values ('Action') ,('Animé') ,('Comédies') ,('Documentaires') ,('Drames') ,('Emotions à la française') ,('Fantastique') ,('Français') ,('Horreur') ,('Indépendants') ,('International') ,('Jeunesse et famille') ,('Musique et comédies musicales') ,('Policier') , ('Romance') , ('SF') , ('Thriller');

insert into Moovies (Tittle,id_genre, Duration,Director )
values ('Baby boss',12,'1h37','Tom McGrath' ),
('star wars épisode IX',16,'2h22','J.J Abrams' ),
('FAST AND FURIOUS 9',12,'2h15','Justin Lin' ),
('Un triomphe',6,'1h40','Emmanuel Courcol' );

insert into Payments (Type_payment)
values ('En ligne'),
('Au cinéma');

insert into Tariffs(id,Type_tariff, price)
values (1,'plein tarif','9.20'),
(2,'étudiant','7.60'),
(3,'-14 ans','5.90');

insert into Customers (id, Name, First_name, Age, email, Password,id_price)
values (UUID(),'Raatz', 'Lorilee', 19, 'lraatz0@prnewswire.com', '$2y$10$fCZt.7a/mgdiMbeCUe2UdOBGtba/3qeQaEOnA2qzUBG1BtPhkgtbK',2),
(UUID(),'Egentan', 'Kinna', 25, 'kegentan1@sogou.com', '$2y$10$izqAaSQdokkEU4E7mCFOhuT80W7EiFIdzawVCc3nno7kO91AOxxhG',1),
(UUID(),'Seys', 'Sibley', 13, 'sseys2@nba.com', '$2y$10$K3RJAGwkAcLrsdxVbJbK4.Ybcx7H/Hlj7lK9g2Pmz72LNItzpGMMu',3),
(UUID(),'Paybody', 'Harlie', 54, 'hpaybody3@webmd.com', '$2y$10$wFruP0SQfSC8mL4..C7wveFPUPM0F71/4V32grPNrzGuj7xwISW9.',1),
(UUID(),'Rozalski', 'Cris', 35, 'crozalski4@surveymonkey.com', '$2y$10$ApRiH25BXhzQWexLj7qu0uRxiWRgWfiQSJM7jbSDqmRnkH5dQajs',1),
(UUID(),'Wauchope', 'Pietrek', 66, 'pwauchope5@nps.gov', '$2y$10$E2t/np8Xk1QVoHcvdti0Z.RyxCeqWHy0/vZOZzD/YDjDYbDj5Q5vC',1);

insert into FilmShows(id_room, tittle_moovie, start_time)
values (1,'star wars épisode IX', '2021-10-27 20:00'),
(2,'Baby boss', '2021-10-11 18:00'),
(5,'FAST AND FURIOUS 9', '2021-10-22 19:30'),
(4,'Un triomphe', '2021-10-04 20:00'),
(3,'star wars épisode IX', '2021-10-27 20:00');

insert into Bookings(id,First_name_customer, start_time, id_filmShow,id_room,name_CinemasComplex , Price,id_payment)
values (UUID(),'Lorilee','2021-10-27 20:00',1,1,'UGC PARIS','7.60',1),
(UUID(),'Cris','2021-10-27 20:00',5,3,'UGC PARIS','9.20',1),
(UUID(),'Sibley','2021-10-11 18:00',2,2,'UGC LAROCHELLE','5.90',2),
(UUID(),'Pietrek','2021-10-04 20:00',3,5,'UGC TOULOUSE','9.20',1),
(UUID(),'Kinna','2021-10-22 19:30',4,4,'UGC LILLE','9.20',2);


-- Requêtes sql permettant de démontrer la fiabilité de la bbd par rapport aux exigences du client


-- Montre grace au numéro de réservation qu'il y a la possibilité de réserver un film dans plusieurs cinémas
Select Bookings.id as 'Numéro de réservation',FilmShows.id as 'Numéro de seance', CinemasComplex.name as 'Nom du cinéma'
from Bookings
join FilmShows on  FilmShows.id = Bookings.id_filmShow
join CinemasComplex on CinemasComplex.name = Bookings.name_CinemasComplex
Order by CinemasComplex.name;

-- Montre le passage du même film au même horaire dans plusieurs salles différentes
SELECT *
FROM FilmShows
ORDER BY start_time;

-- Permet de calculer le nombre de places restant dans une salle pour une séance donné
SELECT CinemasComplex.name AS 'Nom du cinéma', Rooms.id AS 'Numéro de la salle', Rooms.Nb_place AS 'Nombre de place', COUNT(Bookings.id) AS 'Nombre de réservation', Rooms.Nb_place - COUNT(Bookings.id_room) AS 'Places restantes'
FROM Bookings
Join Rooms ON Bookings.id_room = Rooms.id
Join CinemasComplex ON Bookings.name_CinemasComplex = CinemasComplex.name
GROUP BY Rooms.id;

-- Montre les différents tarifs
Select *
from Payments;

-- Tableau permettant de savoir si les clients ont payé sur place ou en ligne
SELECT Bookings.id AS 'Numéro de réservation' , CONCAT(Customers.name , ' ' , Customers.first_name) AS 'Nom et Prénom du client' , Payments.type_payment 'Choix du paiement'
FROM Bookings
JOIN Customers ON Bookings.First_name_customer = Customers.First_name
JOIN Payments ON Bookings.id_payment = Payments.id ;

-- Tableau permettant de connaître l'administrateur du cinéma
SELECT CinemasComplex.name 'Nom du cinéma' ,  CONCAT(Admin.name,  ' ' , Admin.First_name) AS 'Nom Prenom'
FROM CinemasComplex
JOIN Infos ON CinemasComplex.id_info = Infos.id
JOIN Admin ON Infos.id_admin = Admin.id ;


--Création des utilisateurs
CREATE USER 'root'@'%' IDENTIFIED BY 'root',
CREATE USER 'Visitor'@'%' IDENTIFIED BY 'Visitor'

--Création des droits pour Root
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'WITH GRANT OPTION;

-- Rechargement de la table des privilèges
FLUSH PRIVILEGES,

-- Utilisation d'un utilitaire de sauvegarde de la base de données
mysqldump EvalBDD > EvalBDD.sql

--Utilisation d'un utilitaire de restauration de la base de données
mysqldump EvalBDD < EvalBDD.sql




