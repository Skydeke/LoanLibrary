create table Automodell(
 Hersteller varchar(100) not null,
 
 Sitzplaetze integer not null,
 PreisProTag float not null,
 Typ varchar(100) not null,
 PreisProKm float not null,
 Art varchar(1),
 LadevolumenKubikMeter integer,
 Achsenzahl integer,
 LadegewichtKg integer,
 
 imagefile varchar(150)
);
alter table Automodell add AutomodellNr integer not null;
alter table Automodell add constraint pk_Automodell primary key (AutomodellNr);

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
 HausNr integer not null);
alter table Kunde add KundenNr integer not null;
alter table Kunde add constraint pk_Kunde primary key (KundenNr);

create table besitzt(
 KundenNr integer not null,
 Klassenbezeichnung varchar(3) not null);
 
create table Reservierung(
 geplanterStart timestamp not null DEFAULT CURRENT_TIMESTAMP,
 geplantesEnde timestamp not null DEFAULT CURRENT_TIMESTAMP);
alter table Reservierung add ResNr integer not null;
alter table Reservierung add constraint pk_Reservierung primary key (ResNr);
 
create table Ausstattung(
 Bezeichnung varchar(150) not null);
alter table Ausstattung add AusstattungNr integer not null;
alter table Ausstattung add constraint pk_Ausstattung primary key (AusstattungNr);
 
create table Autoexemplar(
 Kennzeichen varchar(15) not null,
 Kilometerstand integer not null,
 letzterTUEV date not null,
 Kaufdatum date not null);
alter table Autoexemplar add constraint pk_Autoexemplar primary key (Kennzeichen);

create table Ausleihvorgang(
 beginnZeit timestamp not null DEFAULT CURRENT_TIMESTAMP,
 endeZeit timestamp not null DEFAULT CURRENT_TIMESTAMP,
 beginnKm float not null,
 endeKm float not null);
alter table Ausleihvorgang add AusleihvorgangNr integer not null;
alter table Ausleihvorgang add constraint pk_Ausleihvorgang primary key (AusleihvorgangNr);

create table Rechnung(
 Summe float not null,
 Beglichen char not null);
alter table Rechnung add RechNr integer not null;
alter table Rechnung add constraint pk_Rechnung primary key (RechNr);

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

alter table Ausleihvorgang add Kennzeichen varchar(8);
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

insert into Ausstattung (AusstattungNr, Bezeichnung) values (0, 'Ledersitze');
insert into Ausstattung (AusstattungNr, Bezeichnung) values (1, 'Fellsitze');
insert into Ausstattung (AusstattungNr, Bezeichnung) values (2, 'UKW-Radio');
insert into Ausstattung (AusstattungNr, Bezeichnung) values (3, 'Klimaanlage');
commit;

insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, Art, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile) values (0, 'B', 'Audi', 5, 150, 'Cabrio', 0.4, 'P', null, null, null, '/assets/car.jpg');
insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, Art, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile) values (1, 'B', 'Mercedes', 5, 120, 'SUV', 0.6, 'P', null, null, null, '/assets/car.jpg');
insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, Art, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile) values (2, 'B', 'VW', 5, 150, 'Cabrio', 0.4, 'P', null, null, null, '/assets/car.jpg');

insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, Art, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile) values (3, 'C', 'MAN', 3, 350, 'Muldenkipper', 0.2, 'L', 24, 3, 15000, '/assets/car2.jpg');
insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, Art, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile) values (4, 'D', 'MAN', 3, 250, 'BUS', 0.3, 'L', 24, 3, 15000, '/assets/car2.jpg');
insert into Automodell (AutomodellNr, Klassenbezeichnung, Hersteller, Sitzplaetze, PreisProTag, Typ, PreisProKm, Art, LadevolumenkubikMeter, Achsenzahl, LadegewichtKg, imagefile) values (5, 'C', 'MAN', 3, 550, 'Schwanenhals', 0.2, 'L', 98, 3, 24000, '/assets/car2.jpg');
commit;

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (0, 0);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (0, 2);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (0, 3);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (1, 2);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (1, 3);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (2, 2);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (2, 3);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (3, 2);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (3, 3);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (4, 2);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (4, 3);

insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (5, 2);
insert into ist_grundausstattung_bei (AutomodellNr, AusstattungNr) values (5, 3);
commit;

insert into Autoexemplar (Kennzeichen, Kilometerstand, LetzterTUEV, Kaufdatum, AutomodellNr) values ('RV-KA-789', 80342, STR_TO_DATE('2022-06-19', '%Y-%m-%d'), STR_TO_DATE('2018-12-15', '%Y-%m-%d'), 0);
insert into Autoexemplar (Kennzeichen, Kilometerstand, LetzterTUEV, Kaufdatum, AutomodellNr) values ('RW-PA-2893', 160342, STR_TO_DATE('2022-06-17', '%Y-%m-%d'), STR_TO_DATE('2017-04-15', '%Y-%m-%d'), 1);
insert into Autoexemplar (Kennzeichen, Kilometerstand, LetzterTUEV, Kaufdatum, AutomodellNr) values ('RV-JW-729', 68393, STR_TO_DATE('2022-06-14','%Y-%m-%d'), STR_TO_DATE('2019-04-15', '%Y-%m-%d'), 2);
insert into Autoexemplar (Kennzeichen, Kilometerstand, LetzterTUEV, Kaufdatum, AutomodellNr) values ('RV-FS-1234', 4232, STR_TO_DATE('2022-06-15','%Y-%m-%d'), STR_TO_DATE('2022-04-04', '%Y-%m-%d'), 3);
insert into Autoexemplar (Kennzeichen, Kilometerstand, LetzterTUEV, Kaufdatum, AutomodellNr) values ('RV-SW-7223', 168393, STR_TO_DATE('2022-06-14','%Y-%m-%d'), STR_TO_DATE('2016-03-15', '%Y-%m-%d'), 4);
insert into Autoexemplar (Kennzeichen, Kilometerstand, LetzterTUEV, Kaufdatum, AutomodellNr) values ('RV-FS-1225', 42328, STR_TO_DATE('2022-06-15','%Y-%m-%d'), STR_TO_DATE('2021-02-04', '%Y-%m-%d'), 5);
commit;

insert into ist_nachgeruestet_bei (Kennzeichen, AusstattungNr) values ('RV-FS-1225', 1);
commit;

insert into Kunde (Vorname, Nachname, ZweiterVorname, Ort, PLZ, Land, Strasse, HausNr, EMail, KundenNr) values ('Niklas', 'Kleiser', 'Elias', 'Dortmund', 44339, 'Deutschland', 'Kappenberger Straße', 12, 'kleiser@rwu.de', 0);
insert into Kunde (Vorname, Nachname, ZweiterVorname, Ort, PLZ, Land, Strasse, HausNr, EMail, KundenNr) values ('Jonathan', 'Wekesser', null, 'Dortmund', 44339, 'Deutschland', 'Lothringer Straße', 4, 'j.wekesser@rwu.de', 1);
insert into Kunde (Vorname, Nachname, ZweiterVorname, Ort, PLZ, Land, Strasse, HausNr, EMail, KundenNr) values ('Anakin', 'Skywalker', 'Vader', 'Vaders castle', 35152, 'Deutschland', 'Mustafar Straße', 1, 'vader@imperium.org', 2);
commit;

insert into besitzt (KundenNr, Klassenbezeichnung) values (0, 'D');
insert into besitzt (KundenNr, Klassenbezeichnung) values (2, 'B');
insert into besitzt (KundenNr, Klassenbezeichnung) values (2, 'C');
insert into besitzt (KundenNr, Klassenbezeichnung) values (1, 'B');
commit;

insert into Ausleihvorgang(beginnZeit, endeZeit, beginnKm, endeKm, AusleihvorgangNr) values (STR_TO_DATE('2022-10-12 12:00:30','%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2022-10-19 11:50:00','%Y-%m-%d %H:%i:%s'), 168393, 168792, 0);
insert into Ausleihvorgang(beginnZeit, endeZeit, beginnKm, endeKm, AusleihvorgangNr) values (STR_TO_DATE('2022-09-26 09:01:00','%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2022-09-26 10:03:00','%Y-%m-%d %H:%i:%s'), 160342, 160382, 1);
insert into Ausleihvorgang(beginnZeit, endeZeit, beginnKm, endeKm, AusleihvorgangNr) values (STR_TO_DATE('2022-08-15 12:07:13','%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2022-08-15 18:05:43','%Y-%m-%d %H:%i:%s'), 80342, 80412, 2);
insert into Ausleihvorgang(beginnZeit, endeZeit, beginnKm, endeKm, AusleihvorgangNr) values (STR_TO_DATE('2022-10-12 15:13:20','%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2022-10-19 15:11:23','%Y-%m-%d %H:%i:%s'), 4232, 5121, 3); 
commit;

insert into Rechnung (Summe, Beglichen, RechNr, AusleihvorgangNr) values (1849.7 , 't', 0, 0);
insert into Rechnung (Summe, Beglichen, RechNr, AusleihvorgangNr) values (144 , 'f', 1, 1);
insert into Rechnung (Summe, Beglichen, RechNr, AusleihvorgangNr) values (178 , 't', 2, 2);
insert into Rechnung (Summe, Beglichen, RechNr, AusleihvorgangNr) values (2627.8 , 't', 3, 3);
commit;

insert into Reservierung(geplanterStart, geplantesEnde, KundenNr, AutomodellNr, AusleihvorgangNr, ResNr) values (STR_TO_DATE('2022-10-12 12:00:00','%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2022-10-19 12:00:00','%Y-%m-%d %H:%i:%s'), 0, 4, 0, 0);
insert into Reservierung(geplanterStart, geplantesEnde, KundenNr, AutomodellNr, AusleihvorgangNr, ResNr) values (STR_TO_DATE('2022-09-26 09:00:00','%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2022-09-26 10:00:00','%Y-%m-%d %H:%i:%s'), 2, 1, 1, 1);
insert into Reservierung(geplanterStart, geplantesEnde, KundenNr, AutomodellNr, AusleihvorgangNr, ResNr) values (STR_TO_DATE('2022-08-15 12:10:00','%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2022-08-15 18:10:00','%Y-%m-%d %H:%i:%s'), 1, 0, 2, 2);
insert into Reservierung(geplanterStart, geplantesEnde, KundenNr, AutomodellNr, AusleihvorgangNr, ResNr) values (STR_TO_DATE('2022-10-12 15:10:00','%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2022-10-19 15:10:00','%Y-%m-%d %H:%i:%s'), 2, 3, 3, 3);
commit;