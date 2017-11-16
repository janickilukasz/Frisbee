#Usuwanie poprzedniej wersji danych
drop trigger if exists frisbee.po_meczu;
drop trigger if exists druz_plus;
drop view if exists punktacja;
drop table if exists frisbee.zawodnicy;
drop table if exists frisbee.druzyny;
drop table if exists frisbee.mecze;
drop table if exists frisbee.parametry;
drop database if exists frisbee;

#Tworzenie bazy danych
create database frisbee;
use frisbee;

#Tworzenie tabeli parametrów (niektóre parametry będą wtórnie uzupełniane, ale są potrzebne, żeby się do nich odnosić jako zmienne)
create table parametry(parametr varchar(20) unique, wartosc smallint);
insert into parametry values ('ile_druzyn', 0); #ta wartość modyfikowana jest przez trigger
insert into parametry values ('ile_grup', 2); #tę wartość na razie trzeba wprowadzić ręcznie
insert into parametry values ('rewanze', 1);#0 - bez rewanżów, 1 - z rewanżami

#Tworzenie tabeli z drużynami
create table druzyny(id tinyint primary key auto_increment, nazwa tinytext, kolor varchar(20), grupa tinyint, mecze tinyint default 0, zwyc tinyint default 0, remis tinyint default 0, porazka tinyint default 0, punkty tinyint default 0, male_pkt_plus smallint default 0, male_pkt_minus smallint default 0, roznica_pkt smallint default 0, miejsce tinyint);

#Tworzenie triggerów do obsługi tabeli parametrów na podstawie tabeli z drużynami
create trigger druz_plus after insert on druzyny for each row update parametry set wartosc = wartosc + 1 where parametr='ile_druzyn';

#Uzupełnienie tabeli drużyn
insert into druzyny(nazwa, kolor) values ('Smoki','niebieski');
insert into druzyny(nazwa, kolor) values ('Lajkoniki','czerwony');
insert into druzyny(nazwa, kolor) values ('Maczety','żółty');
insert into druzyny(nazwa, kolor) values ('Chochoły','biały');
insert into druzyny(nazwa, kolor) values ('Hejnaliści','czarny');
insert into druzyny(nazwa, kolor) values ('Królowie','różowy');
insert into druzyny(nazwa, kolor) values ('Precle','fioletowy');
insert into druzyny(nazwa, kolor) values ('Kosynierzy','szary');

#Tworzenie tabeli zawodników
create table zawodnicy(id smallint primary key auto_increment, imie tinytext not null, nazwisko tinytext not null, plec char(1) not null, poziom tinyint unsigned, pozycja varchar(7), menu varchar(5), rozmiar varchar(2) not null, druzyna tinyint, foreign key(druzyna) references druzyny(id));
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Janek','Kowalski','M',6,'cutter','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Agata','Nowak','K',3,'cutter','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Robert','Bebech','M',8,'handler','wege','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Karolina','Perchuć-Starzyńska','K',6,'handler','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Edek','Kredkowski','M',9,'handler','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Eliza','Kabanos','K',1,'','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Paweł','Szuja','M',5,'cutter','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Beata','Baranowska','K',5,'cutter','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Anna','Nowak','K',6,'cutter','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Stanisława','Wilk','K',8,'handler','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Karolina','Andrzejewska','K',9,'handler','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Krystyna','Kowalska','K',7,'handler','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Stefania','Adamska','K',3,'handler','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Kazimiera','Wysocka','K',4,'cutter','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Grażyna','Marciniak','K',8,'handler','wege','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Izabela','Mazurek','K',2,'handler','wege','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Zofia','Duda','K',9,'cutter','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Aleksandra','Walczak','K',9,'cutter','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Magdalena','Sikorska','K',8,'cutter','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Dorota','Tomaszewska','K',6,'cutter','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Barbara','Majewska','K',6,'handler','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Natalia','Czarnecka','K',8,'cutter','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Urszula','Andrzejewska','K',2,'handler','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Joanna','Górska','K',4,'cutter','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Alicja','Sikorska','K',7,'cutter','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Natalia','Cieślak','K',10,'cutter','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Barbara','Mazurek','K',1,'handler','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Renata','Nowakowska','K',1,'handler','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Teresa','Sikora','K',8,'cutter','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Beata','Kowalczyk','K',4,'handler','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Elżbieta','Wasilewska','K',2,'cutter','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Teresa','Kwiatkowska','K',5,'handler','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Halina','Nowak','K',2,'cutter','wege','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Barbara','Baran','K',8,'cutter','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Stanisława','Sadowska','K',1,'handler','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Zofia','Wojciechowska','K',6,'handler','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Alicja','Baranowska','K',10,'handler','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Stanisława','Borkowska','K',7,'handler','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Stefania','Zając','K',9,'cutter','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Ewelina','Jabłońska','K',8,'handler','wege','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Elżbieta','Majewska','K',5,'cutter','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Bożena','Wasilewska','K',5,'cutter','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Marzena','Lis','K',6,'handler','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Agata','Bąk','K',3,'handler','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Agnieszka','Szczepańska','K',3,'cutter','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Maria','Pawłowska','K',2,'handler','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Iwona','Pawlak','K',3,'handler','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Jadwiga','Piotrowska','K',1,'cutter','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Renata','Pietrzak','K',8,'handler','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Wiesława','Szulc','K',5,'cutter','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Natalia','Tomaszewska','K',1,'cutter','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Magdalena','Przybylska','K',6,'cutter','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Ewa','Olszewska','K',10,'cutter','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Agata','Dudek','K',7,'cutter','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Janina','Kalinowska','K',6,'handler','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Urszula','Przybylska','K',10,'handler','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Sylwia','Wieczorek','K',4,'cutter','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Zdzisław','Kowalczyk','M',8,'cutter','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Czesław','Duda','M',2,'cutter','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Jacek','Pawłowski','M',3,'cutter','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Roman','Krajewski','M',6,'handler','wege','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Mariusz','Sikora','M',4,'cutter','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Jacek','Mazur','M',9,'handler','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Maciej','Kalinowski','M',7,'cutter','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Sebastian','Krajewski','M',7,'handler','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Leszek','Bąk','M',8,'cutter','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Marek','Walczak','M',2,'cutter','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Jan','Jankowski','M',4,'handler','wege','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Stanisław','Piotrowski','M',9,'handler','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Czesław','Dąbrowski','M',2,'cutter','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Roman','Czarnecki','M',5,'handler','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Jakub','Sobczak','M',9,'cutter','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Mateusz','Czerwiński','M',1,'handler','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Jacek','Szczepański','M',7,'handler','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Krzysztof','Baranowski','M',2,'cutter','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Ryszard','Kwiatkowski','M',2,'cutter','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Ryszard','Wiśniewski','M',5,'cutter','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Paweł','Baran','M',1,'cutter','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Maciej','Wójcik','M',10,'cutter','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Waldemar','Tomaszewski','M',2,'cutter','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Artur','Wilk','M',9,'handler','wege','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Adam','Kwiatkowski','M',2,'handler','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Jerzy','Szymański','M',1,'cutter','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Mateusz','Król','M',6,'handler','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Paweł','Nowicki','M',5,'handler','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Sebastian','Zając','M',4,'cutter','wege','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Władysław','Andrzejewski','M',6,'cutter','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Dawid','Wójcik','M',4,'cutter','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Jakub','Walczak','M',6,'handler','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Mirosław','Szczepański','M',8,'handler','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Marian','Sadowski','M',1,'cutter','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Rafał','Ostrowski','M',3,'cutter','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Dariusz','Szczepański','M',9,'handler','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Andrzej','Kalinowski','M',6,'handler','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Marek','Malinowski','M',6,'handler','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Łukasz','Sawicki','M',5,'cutter','wege','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Marian','Bąk','M',1,'handler','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Jarosław','Jasiński','M',10,'cutter','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Marcin','Ostrowski','M',8,'handler','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Rafał','Sawicki','M',6,'cutter','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Stanisław','Stępień','M',5,'handler','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Władysław','Zakrzewski','M',6,'handler','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Stanisław','Ziółkowski','M',10,'cutter','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Mirosław','Mazurek','M',9,'handler','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Piotr','Baran','M',4,'cutter','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Łukasz','Ostrowski','M',8,'handler','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Damian','Zając','M',10,'handler','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Roman','Jaworski','M',10,'handler','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Jakub','Wasilewski','M',4,'handler','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Robert','Kalinowski','M',6,'handler','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Wojciech','Wieczorek','M',6,'cutter','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Łukasz','Rutkowski','M',8,'cutter','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Roman','Kaczmarek','M',8,'handler','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Sebastian','Nowakowski','M',7,'handler','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Rafał','Michalak','M',6,'handler','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Czesław','Jakubowski','M',1,'cutter','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Wiesław','Nowicki','M',2,'handler','wege','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Daniel','Sokołowski','M',2,'cutter','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Sławomir','Mazurek','M',3,'handler','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Marek','Zając','M',2,'handler','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Ryszard','Laskowski','M',2,'handler','wege','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Jarosław','Kalinowski','M',9,'cutter','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Zbigniew','Kowalski','M',5,'cutter','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Czesław','Jasiński','M',3,'handler','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Damian','Zalewski','M',3,'cutter','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Andrzej','Głowacki','M',9,'handler','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Sławomir','Szulc','M',4,'handler','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Piotr','Andrzejewski','M',4,'cutter','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Władysław','Pawlak','M',10,'cutter','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Waldemar','Laskowski','M',3,'handler','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Jan','Makowski','M',10,'cutter','mięso','M');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Waldemar','Mazurek','M',1,'handler','mięso','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Jarosław','Sadowski','M',1,'handler','mięso','XL');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Marian','Jankowski','M',7,'cutter','mięso','L');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Jan','Woźniak','M',2,'cutter','wege','XS');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Łukasz','Walczak','M',9,'handler','mięso','S');
insert into zawodnicy(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('Jan','Wróbel','M',7,'handler','mięso','L');

#Przypisanie zawodników do drużyny (na razie losowo)
update zawodnicy set druzyna = ceil((select count(*) from druzyny)*rand());

#Ile będzie potrzebne obiadów
select menu, count(*) As ile from zawodnicy group by menu;

#Ile i jakich zamówić koszulek
select kolor, rozmiar, count(*) As ile from druzyny join zawodnicy on druzyny.id = zawodnicy.druzyna group by kolor, rozmiar order by kolor;

#Przydzielenie drużyn do grup (działa dla dowolnej ilości grup na podstawie ilości grup w parametrach, przydziela drużyny po kolei bez losowania)
update druzyny set grupa = ceil((id/(select wartosc from parametry where parametr='ile_druzyn'))*(select wartosc from parametry where parametr='ile_grup'));

#Utworzenie tabeli meczów
create table mecze(id tinyint primary key auto_increment, faza varchar(12), kto_id tinyint, z_kim_id tinyint, kto_pkt tinyint, z_kim_pkt tinyint);

#Generator zestawu Mecz + rewanż
#select a.nazwa As Druzyna1, b.nazwa As Druzyna2 from druzyny as a join druzyny as b where a.id!=b.id and a.grupa=b.grupa;

#Generator zestawu Mecz bez rewanżu
#select a.nazwa As Druzyna1, b.nazwa As Druzyna2 from druzyny as a join druzyny as b where a.id>b.id and a.grupa=b.grupa;

#Wypełnienie tabeli meczów o mecze grupowe (generuje rewanże w zależności od wartości parametru rewanże
insert into mecze(faza, kto_id, z_kim_id) select 'Faza grupowa', a.id, b.id from druzyny as a join druzyny as b where case when (select wartosc from parametry where parametr='rewanze') then a.id!=b.id else a.id>b.id end and a.grupa=b.grupa;

#Prezentacja meczów
select faza, d1.nazwa As Drużyna1, d2.nazwa As Drużyna2, coalesce(concat(kto_pkt,':',z_kim_pkt),'- : -') as Wynik from mecze join druzyny as d1 on kto_id=d1.id join druzyny as d2 on z_kim_id=d2.id;

#Utworzenie widoku "punktacja" w którym zbierana jest liczba zwycięstw i małe punkty TYLKO Z FAZY GRUPOWEJ
create view punktacja as
select kto_id as Drużyna, 1 as Zwycięstwa, kto_pkt As Punkty_plus, z_kim_pkt As Punkty_minus from mecze where kto_pkt>z_kim_pkt and faza='Faza grupowa'
union all
select z_kim_id as Drużyna, 1 as Zwycięstwa, z_kim_pkt As Punkty_plus, kto_pkt As Punkty_minus from mecze where kto_pkt<z_kim_pkt and faza='Faza grupowa'
union all
select kto_id as Drużyna, 0 as Zwycięstwa, kto_pkt As Punkty_plus, z_kim_pkt As Punkty_minus from mecze where kto_pkt<z_kim_pkt and faza='Faza grupowa'
union all
select z_kim_id as Drużyna, 0 as Zwycięstwa, z_kim_pkt As Punkty_plus, kto_pkt As Punkty_minus from mecze where kto_pkt>z_kim_pkt and faza='Faza grupowa';

#Stworzenie triggerów do aktualizacji liczby rozegranych meczów, zdobyczy punktowych itp.
create trigger po_meczu after update on mecze for each row update druzyny set mecze = (select count(*) from punktacja where Drużyna = id), zwyc = coalesce((select sum(Zwycięstwa) from punktacja where Drużyna = id),0), porazka = (select count(*) from punktacja where Zwycięstwa=0 and Drużyna = id), punkty = zwyc, male_pkt_plus = coalesce((select sum(Punkty_plus) from punktacja where Drużyna = id),0), male_pkt_minus = coalesce((select sum(Punkty_minus) from punktacja where Drużyna = id),0), roznica_pkt = male_pkt_plus - male_pkt_minus;

#Wprowadzenie kilku wyników meczów:
update mecze set kto_pkt = 14, z_kim_pkt = 15 where id = 1;
update mecze set kto_pkt = 15, z_kim_pkt = 13 where id = 2;
update mecze set kto_pkt = 15, z_kim_pkt = 4 where id = 3;
update mecze set kto_pkt = 11, z_kim_pkt = 15 where id = 4;
update mecze set kto_pkt = 1, z_kim_pkt = 15 where id = 5;
update mecze set kto_pkt = 7, z_kim_pkt = 15 where id = 6;
update mecze set kto_pkt = 12, z_kim_pkt = 15 where id = 7;
update mecze set kto_pkt = 15, z_kim_pkt = 5 where id = 8;
update mecze set kto_pkt = 15, z_kim_pkt = 0 where id = 9;
update mecze set kto_pkt = 2, z_kim_pkt = 15 where id = 10;
update mecze set kto_pkt = 8, z_kim_pkt = 15 where id = 11;
update mecze set kto_pkt = 11, z_kim_pkt = 15 where id = 12;
update mecze set kto_pkt = 15, z_kim_pkt = 14 where id = 13;
update mecze set kto_pkt = 6, z_kim_pkt = 15 where id = 14;
update mecze set kto_pkt = 8, z_kim_pkt = 15 where id = 15;
update mecze set kto_pkt = 15, z_kim_pkt = 14 where id = 16;
update mecze set kto_pkt = 15, z_kim_pkt = 9 where id = 17;
update mecze set kto_pkt = 15, z_kim_pkt = 13 where id = 18;
update mecze set kto_pkt = 15, z_kim_pkt = 9 where id = 19;
update mecze set kto_pkt = 6, z_kim_pkt = 15 where id = 20;
update mecze set kto_pkt = 12, z_kim_pkt = 15 where id = 21;
update mecze set kto_pkt = 12, z_kim_pkt = 15 where id = 22;
update mecze set kto_pkt = 6, z_kim_pkt = 15 where id = 23;
update mecze set kto_pkt = 13, z_kim_pkt = 15 where id = 24;

#TUTAJ
#próbne wstawienie meczu spoza fazy grupowej CZEMU ID MA NUMER 32 ?!?!?!?!
insert into mecze(faza, kto_id, z_kim_id) values ('Final', 5, 7);
#insert into mecze(faza, kto_id, z_kim_id) values ('Ćwierćfinał', 1, 2);
#update mecze set kto_pkt = 6, z_kim_pkt = 15 where id = 25;

#Prezentacja wyników w jednej grupie
select nazwa as Drużyna, mecze as Mecze, zwyc As Zwycięstwa, porazka As Porażki, male_pkt_plus As 'Punkty zdobyte', male_pkt_minus As 'Punkty stracone', roznica_pkt As 'Różnica punktowa' from druzyny where grupa=1 order by zwyc desc, roznica_pkt desc;
select nazwa as Drużyna, mecze as Mecze, zwyc As Zwycięstwa, porazka As Porażki, male_pkt_plus As 'Punkty zdobyte', male_pkt_minus As 'Punkty stracone', roznica_pkt As 'Różnica punktowa' from druzyny where grupa=2 order by zwyc desc, roznica_pkt desc;


select * from zawodnicy;
select * from druzyny;
select * from mecze;
select * from parametry;
select * from punktacja;

