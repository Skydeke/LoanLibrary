create table Automodell(
 Hersteller varchar(100) not null,
 
 Sitzplaetze integer not null,
 PreisProTag float not null,
 Typ varchar(100) not null,
 PreisProKm float not null,
 ObjectArt varchar(1),
 LadevolumenKubikMeter integer,
 Achsenzahl integer,
 LadegewichtKg integer,

 Modellbezeichnung varchar(50),
 imagefile varchar(150)
);
alter table Automodell add AutomodellNr integer primary key AUTO_INCREMENT;

create table Fuehrerscheinklassen(
 Klassenbezeichnung varchar(3) not null);
alter table Fuehrerscheinklassen add constraint pk_Fuehrerscheinklassen primary key (Klassenbezeichnung);

create table Kunde(
 EMail varchar(100),
 
 Nachname varchar(100) not null,
 Vorname varchar(100) not null,
 ZweiterVorname varchar(100),
 
 Ort varchar(100) not null,
 PLZ varchar(5) not null,
 Land varchar(100),
 Strasse varchar(100) not null,
 HausNr integer not null,
 Password varchar(100) not null);
alter table Kunde add KundenNr integer not null primary key AUTO_INCREMENT;

create table besitzt(
 KundenNr integer not null,
 Klassenbezeichnung varchar(3) not null);
 
create table Reservierung(
 geplanterStart timestamp not null DEFAULT CURRENT_TIMESTAMP,
 geplantesEnde timestamp null);
alter table Reservierung add ResNr integer not null primary key AUTO_INCREMENT;
 
create table Ausstattung(
 Bezeichnung varchar(150) not null);
alter table Ausstattung add AusstattungNr integer not null primary key AUTO_INCREMENT;
 
create table Autoexemplar(
 Kennzeichen varchar(15) not null,
 Kilometerstand integer not null,
 letzterTUEV date not null,
 Kaufdatum date not null);
alter table Autoexemplar add constraint pk_Autoexemplar primary key (Kennzeichen);

create table Ausleihvorgang(
 beginnZeit timestamp not null DEFAULT CURRENT_TIMESTAMP,
 endeZeit timestamp null,
 beginnKm float not null,
 endeKm float DEFAULT null);
alter table Ausleihvorgang add AusleihvorgangNr integer not null primary key AUTO_INCREMENT;

create table Rechnung(
 Summe float not null,
 Beglichen char not null);
alter table Rechnung add RechNr integer not null primary key AUTO_INCREMENT;

create table ist_nachgeruestet_bei(
 Kennzeichen varchar(15) not null,
 AusstattungNr integer not null);
 
create table ist_grundausstattung_bei(
 AutomodellNr integer not null,
 AusstattungNr integer not null);
 
 
 
/* -------- Fremdschluessel -------- */
alter table Automodell add Klassenbezeichnung varchar(3);
alter table Automodell add constraint fk_Automo_Fuehrers foreign key (Klassenbezeichnung) references Fuehrerscheinklassen (Klassenbezeichnung) ON DELETE SET NULL;

alter table Autoexemplar add AutomodellNr integer;
alter table Autoexemplar add constraint fk_Autoex_Automo foreign key (AutomodellNr) references Automodell (AutomodellNr) ON DELETE SET NULL;

alter table besitzt add constraint fk_besitzt_Kunde foreign key (KundenNr) references Kunde (KundenNr);
alter table besitzt add constraint fk_besitzt_Fuehrers foreign key (Klassenbezeichnung) references Fuehrerscheinklassen (Klassenbezeichnung);

alter table ist_nachgeruestet_bei add constraint fk_ist_nachgeruestet_bei_Autoexemplar foreign key (Kennzeichen) references Autoexemplar (Kennzeichen);
alter table ist_nachgeruestet_bei add constraint fk_ist_nachgeruestet_bei_Ausstattung foreign key (AusstattungNr) references Ausstattung (AusstattungNr);

alter table ist_grundausstattung_bei add constraint fk_ist_grundausstattung_bei_Automodell foreign key (AutomodellNr) references Automodell (AutomodellNr);
alter table ist_grundausstattung_bei add constraint fk_ist_grundausstattung_bei_Ausstattung foreign key (AusstattungNr) references Ausstattung (AusstattungNr);

alter table Reservierung add AutomodellNr integer;
alter table Reservierung add constraint fk_Reserv_Automo foreign key (AutomodellNr) references Automodell (AutomodellNr);
alter table Reservierung add KundenNr integer not null;
alter table Reservierung add constraint fk_Reserv_Kunde foreign key (KundenNr) references Kunde (KundenNr);
alter table Reservierung add AusleihvorgangNr integer;
alter table Reservierung add constraint fk_Reserv_Ausl foreign key (AusleihvorgangNr) references Ausleihvorgang (AusleihvorgangNr);

alter table Ausleihvorgang add Kennzeichen varchar(15);
alter table Ausleihvorgang add constraint fk_Ausl_Autoex foreign key (Kennzeichen) references Autoexemplar (Kennzeichen);

alter table Rechnung add AusleihvorgangNr integer;
alter table Rechnung add constraint fk_Rechn_Ausl foreign key (AusleihvorgangNr) references Ausleihvorgang (AusleihvorgangNr);

 
/* -------- Datensaetze -------- */
insert into Fuehrerscheinklassen (Klassenbezeichnung) values ('B');
insert into Fuehrerscheinklassen (Klassenbezeichnung) values ('C');
insert into Fuehrerscheinklassen (Klassenbezeichnung) values ('A');
insert into Fuehrerscheinklassen (Klassenbezeichnung) values ('D');
insert into Fuehrerscheinklassen (Klassenbezeichnung) values ('L');
insert into Fuehrerscheinklassen (Klassenbezeichnung) values ('AM');
commit;

insert into Ausstattung (AusstattungNr, Bezeichnung) values (1, 'Ledersitze');
insert into Ausstattung (AusstattungNr, Bezeichnung) values (2, 'Fellsitze');
insert into Ausstattung (AusstattungNr, Bezeichnung) values (3, 'UKW-Radio');
insert into Ausstattung (AusstattungNr, Bezeichnung) values (4, 'Klimaanlage');
commit;

insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, ObjectArt, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile, Modellbezeichnung)
values (1, 'B', 'VW', 5, 150, 'Kleinwagen', 0.4, 'P', null, null, null, 'vwgolf.jpg', 'Golf');
insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, ObjectArt, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile, Modellbezeichnung)
values (2, 'B', 'VW', 5, 120, 'Sportwagen', 0.6, 'P', null, null, null, 'vwarteonr.jpg', 'Arteon R');
insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, ObjectArt, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile, Modellbezeichnung)
values (3, 'B', 'VW', 5, 150, 'Dienstwagen', 0.4, 'P', null, null, null, 'vwpassat.jpg', 'Passat');
insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, ObjectArt, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile, Modellbezeichnung)
values (4, 'B', 'VW', 5, 170, 'SUV', 0.3, 'P', null, null, null, 'vwtiguan.jpg', 'Tiguan');
insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, ObjectArt, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile, Modellbezeichnung)
values (5, 'B', 'VW', 5, 160, 'BUS', 0.4, 'P', null, null, null, 'vwbus.jpeg', 'BUS');

insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, ObjectArt, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile, Modellbezeichnung)
values (6, 'B', 'Audi', 5, 180, 'Kleinwagen', 0.5, 'P', null, null, null, 'audia8.jpeg', 'A8');
insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, ObjectArt, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile, Modellbezeichnung)
values (7, 'B', 'Audi', 5, 180, 'SUV', 0.6, 'P', null, null, null, 'audietrongt.jpg', 'e-tron GT');
insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, ObjectArt, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile, Modellbezeichnung)
values (8, 'B', 'Audi', 5, 140, 'Sportwagen', 0.3, 'P', null, null, null, 'auditt.jpeg', 'TT');
insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, ObjectArt, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile, Modellbezeichnung)
values (9, 'B', 'Audi', 5, 140, 'SUV', 0.3, 'P', null, null, null, 'audisq8.jpeg', 'SQ8');

insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, ObjectArt, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile, Modellbezeichnung)
values (10, 'B', 'Mercedes-Benz', 5, 130, 'Kompaktwagen', 0.4, 'P', null, null, null, 'mercbaklasse.jpeg', 'A-Klasse');
insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, ObjectArt, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile, Modellbezeichnung)
values (11, 'B', 'Mercedes-Benz', 5, 130, 'Kompaktwagen', 0.4, 'P', null, null, null, 'mercbbklasse.jpeg', 'B-Klasse');
insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, ObjectArt, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile, Modellbezeichnung)
values (12, 'B', 'Mercedes-Benz', 5, 150, 'Vito', 0.3, 'P', null, null, null, 'mercbvito.jpg', 'V-Klasse');
insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, ObjectArt, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile, Modellbezeichnung)
values (13, 'C', 'Mercedes-Benz', 3, 350, 'Klein-LKW', 0.2, 'L', 10, 2, 1500, 'mercbunimog.jpg', 'Unimog');
insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, ObjectArt, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile, Modellbezeichnung)
values (14, 'C', 'Mercedes-Benz', 3, 350, 'Klein-LKW', 0.2, 'L', 17, 2, 2700, 'mercbsprinter.jpeg', 'Sprinter');


commit;

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (1, 1);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (1, 3);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (1, 4);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (2, 3);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (2, 4);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (3, 3);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (3, 4);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (4, 3);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (4, 4);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (5, 3);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (5, 4);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (6, 3);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (6, 4);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (7, 3);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (7, 4);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (8, 3);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (8, 4);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (9, 3);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (9, 4);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (10, 3);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (10, 4);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (11, 3);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (11, 4);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (12, 3);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (12, 4);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (13, 3);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (13, 4);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (14, 3);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (14, 4);
commit;

insert into Autoexemplar (Kennzeichen, Kilometerstand, LetzterTUEV, Kaufdatum, AutomodellNr) values ('RV-KA-789', 80342, STR_TO_DATE('2022-06-19', '%Y-%m-%d'), STR_TO_DATE('2018-12-15', '%Y-%m-%d'), 1);
insert into Autoexemplar (Kennzeichen, Kilometerstand, LetzterTUEV, Kaufdatum, AutomodellNr) values ('RW-PA-2893', 160342, STR_TO_DATE('2022-06-17', '%Y-%m-%d'), STR_TO_DATE('2017-04-15', '%Y-%m-%d'), 2);
insert into Autoexemplar (Kennzeichen, Kilometerstand, LetzterTUEV, Kaufdatum, AutomodellNr) values ('RV-JW-729', 68393, STR_TO_DATE('2022-06-14','%Y-%m-%d'), STR_TO_DATE('2019-04-15', '%Y-%m-%d'), 3);
insert into Autoexemplar (Kennzeichen, Kilometerstand, LetzterTUEV, Kaufdatum, AutomodellNr) values ('RV-FS-1234', 4232, STR_TO_DATE('2022-06-15','%Y-%m-%d'), STR_TO_DATE('2022-04-04', '%Y-%m-%d'), 4);
insert into Autoexemplar (Kennzeichen, Kilometerstand, LetzterTUEV, Kaufdatum, AutomodellNr) values ('RV-SW-7223', 168393, STR_TO_DATE('2022-06-14','%Y-%m-%d'), STR_TO_DATE('2016-03-15', '%Y-%m-%d'), 5);
insert into Autoexemplar (Kennzeichen, Kilometerstand, LetzterTUEV, Kaufdatum, AutomodellNr) values ('RV-FS-1225', 42328, STR_TO_DATE('2022-06-15','%Y-%m-%d'), STR_TO_DATE('2021-02-04', '%Y-%m-%d'), 6);
commit;

insert into Kunde (Vorname, Nachname, ZweiterVorname, Ort, PLZ, Land, Strasse, HausNr, EMail, KundenNr, Password) values ('Niklas', 'Kleiser', 'Elias', 'Dortmund', 44339, 'Deutschland', 'Kappenberger Straße', 12, 'kleiser@rwu.de', 1, '$2b$10$ep2M23jH4At5ilLlDhuhUuGP27/T19QeeQt04L1hoBP.qo1kgitYy');
insert into Kunde (Vorname, Nachname, ZweiterVorname, Ort, PLZ, Land, Strasse, HausNr, EMail, KundenNr, Password) values ('Jonathan', 'Wekesser', null, 'Dortmund', 44339, 'Deutschland', 'Lothringer Straße', 4, 'j.wekesser@rwu.de', 2, '$2b$10$ep2M23jH4At5ilLlDhuhUuGP27/T19QeeQt04L1hoBP.qo1kgitYy');
insert into Kunde (Vorname, Nachname, ZweiterVorname, Ort, PLZ, Land, Strasse, HausNr, EMail, KundenNr, Password) values ('Anakin', 'Skywalker', 'Vader', 'Vaders castle', 35152, 'Deutschland', 'Mustafar Straße', 1, 'vader@imperium.org', 3, '$2b$10$ep2M23jH4At5ilLlDhuhUuGP27/T19QeeQt04L1hoBP.qo1kgitYy');
commit;

insert into besitzt (KundenNr, Klassenbezeichnung) values (1, 'D');
insert into besitzt (KundenNr, Klassenbezeichnung) values (3, 'B');
insert into besitzt (KundenNr, Klassenbezeichnung) values (3, 'C');
insert into besitzt (KundenNr, Klassenbezeichnung) values (2, 'B');
commit;

insert into Ausleihvorgang(beginnZeit, endeZeit, beginnKm, endeKm, AusleihvorgangNr, Kennzeichen) values (STR_TO_DATE('2022-10-12 12:00:30','%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2022-10-19 11:50:00','%Y-%m-%d %H:%i:%s'), 168393, 168792, 1, 'RV-SW-7223');
insert into Ausleihvorgang(beginnZeit, endeZeit, beginnKm, endeKm, AusleihvorgangNr, Kennzeichen) values (STR_TO_DATE('2022-09-26 09:01:00','%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2022-09-26 10:03:00','%Y-%m-%d %H:%i:%s'), 160342, 160382, 2, 'RW-PA-2893');
insert into Ausleihvorgang(beginnZeit, endeZeit, beginnKm, endeKm, AusleihvorgangNr, Kennzeichen) values (STR_TO_DATE('2022-08-15 12:07:13','%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2022-08-15 18:05:43','%Y-%m-%d %H:%i:%s'), 80342, 80412, 3, 'RV-KA-789');
insert into Ausleihvorgang(beginnZeit, endeZeit, beginnKm, endeKm, AusleihvorgangNr, Kennzeichen) values (STR_TO_DATE('2022-10-12 15:13:20','%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2022-10-19 15:11:23','%Y-%m-%d %H:%i:%s'), 4232, 5121, 4, 'RV-FS-1225');
commit;

insert into Rechnung (Summe, Beglichen, RechNr, AusleihvorgangNr) values (1849.7 , 't', 1, 1);
insert into Rechnung (Summe, Beglichen, RechNr, AusleihvorgangNr) values (144 , 'f', 2, 2);
insert into Rechnung (Summe, Beglichen, RechNr, AusleihvorgangNr) values (178 , 't', 3, 3);
insert into Rechnung (Summe, Beglichen, RechNr, AusleihvorgangNr) values (2627.8 , 't', 4, 4);
commit;

insert into Reservierung(geplanterStart, geplantesEnde, KundenNr, AutomodellNr, AusleihvorgangNr, ResNr) values (STR_TO_DATE('2022-10-12 12:00:00','%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2022-10-19 12:00:00','%Y-%m-%d %H:%i:%s'), 1, 5, 1, 1);
insert into Reservierung(geplanterStart, geplantesEnde, KundenNr, AutomodellNr, AusleihvorgangNr, ResNr) values (STR_TO_DATE('2022-09-26 09:00:00','%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2022-09-26 10:00:00','%Y-%m-%d %H:%i:%s'), 3, 2, 2, 2);
insert into Reservierung(geplanterStart, geplantesEnde, KundenNr, AutomodellNr, AusleihvorgangNr, ResNr) values (STR_TO_DATE('2022-08-15 12:10:00','%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2022-08-15 18:10:00','%Y-%m-%d %H:%i:%s'), 2, 1, 3, 3);
insert into Reservierung(geplanterStart, geplantesEnde, KundenNr, AutomodellNr, AusleihvorgangNr, ResNr) values (STR_TO_DATE('2022-10-12 15:10:00','%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2022-10-19 15:10:00','%Y-%m-%d %H:%i:%s'), 3, 4, 4, 4);
commit;