#Usuwanie poprzedniej wersji danych
drop trigger if exists frisbee.po_meczu;
drop trigger if exists frisbee.playoff1;
drop trigger if exists frisbee.playoff2;
drop view if exists frisbee.punktacja;
drop table if exists frisbee.zawodnicy;
drop table if exists frisbee.mecze;
drop table if exists frisbee.druzyny;
drop table if exists frisbee.systemy;
drop database if exists frisbee;

#Tworzenie bazy danych
create database frisbee DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
use frisbee;

#Tworzenie tabeli systemów (lista jest stała, można potem dodać jakieś możliwość modyfikacji)
#kolumna rewanże = 1 - są rewanże, 0 - nie ma rewanżów
create table systemy(id tinyint primary key auto_increment, ilosc_druz tinyint, ilosc_gr tinyint, cwierc boolean, pol boolean, rewanze boolean);

#Uzupełnianie tabeli systemów
insert into systemy(ilosc_druz, ilosc_gr, cwierc, pol, rewanze) values(4,1,false,false,true);
insert into systemy(ilosc_druz, ilosc_gr, cwierc, pol, rewanze) values(5,1,false,false,true);
insert into systemy(ilosc_druz, ilosc_gr, cwierc, pol, rewanze) values(6,1,false,false,false);
insert into systemy(ilosc_druz, ilosc_gr, cwierc, pol, rewanze) values(6,2,false,false,true);
insert into systemy(ilosc_druz, ilosc_gr, cwierc, pol, rewanze) values(8,2,false,true,true);
insert into systemy(ilosc_druz, ilosc_gr, cwierc, pol, rewanze) values(9,3,false,true,true);
insert into systemy(ilosc_druz, ilosc_gr, cwierc, pol, rewanze) values(10,2,false,true,true);
insert into systemy(ilosc_druz, ilosc_gr, cwierc, pol, rewanze) values(12,2,false,true,false);
insert into systemy(ilosc_druz, ilosc_gr, cwierc, pol, rewanze) values(12,3,true,true,true);
insert into systemy(ilosc_druz, ilosc_gr, cwierc, pol, rewanze) values(12,4,true,true,true);
insert into systemy(ilosc_druz, ilosc_gr, cwierc, pol, rewanze) values(15,3,true,true,false);
insert into systemy(ilosc_druz, ilosc_gr, cwierc, pol, rewanze) values(16,4,true,true,true);
insert into systemy(ilosc_druz, ilosc_gr, cwierc, pol, rewanze) values(18,6,true,true,true);
insert into systemy(ilosc_druz, ilosc_gr, cwierc, pol, rewanze) values(20,4,true,true,false);
insert into systemy(ilosc_druz, ilosc_gr, cwierc, pol, rewanze) values(20,5,true,true,true);
insert into systemy(ilosc_druz, ilosc_gr, cwierc, pol, rewanze) values(21,7,true,true,true);

#Tworzenie tabeli z drużynami (awans = 1 to awans do ćwierćfinału, awans = 2 do półfinału, awans = 3 do finału)
create table druzyny(id tinyint primary key auto_increment, nazwa tinytext, kolor varchar(20), grupa tinyint, mecze tinyint default 0, zwyc tinyint default 0, porazka tinyint default 0, punkty float default 0, male_pkt_plus smallint default 0, male_pkt_minus smallint default 0, roznica_pkt smallint default 0, awans tinyint default 0, miejsce tinyint);

#Tworzenie tabeli zawodników
create table zawodnicy(id smallint primary key auto_increment, login varchar(50) unique, pass varchar(50), uprawnienia boolean default false, imie tinytext, nazwisko tinytext, plec char(1), poziom tinyint unsigned, pozycja varchar(7), menu varchar(5), rozmiar varchar(2), druzyna tinyint, foreign key(druzyna) references druzyny(id));
insert into zawodnicy(login, pass, uprawnienia, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('admin','123', true, 'Jan','Kowalski','M',9,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('bbaranowska','b33ska2','Beata','Baranowska','K',8,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('anowak','a48wak1','Anna','Nowak','K',6,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('swilk','s14ilk3','Stanisława','Wilk','K',4,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('kandrzejewska','k30ska0','Karolina','Andrzejewska','K',5,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('kkowalska','k42ska7','Krystyna','Kowalska','K',5,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('sadamska','s13ska5','Stefania','Adamska','K',6,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('kwysocka','k23cka6','Kazimiera','Wysocka','K',6,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('gmarciniak','g44iak2','Grażyna','Marciniak','K',9,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('imazurek','i42rek2','Izabela','Mazurek','K',5,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('kduda','k22uda6','Karolina','Duda','K',6,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('awalczak','a16zak4','Aleksandra','Walczak','K',5,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('msikorska','m26ska7','Magdalena','Sikorska','K',2,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dtomaszewska','d18ska2','Dorota','Tomaszewska','K',8,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('bmajewska','b33ska3','Barbara','Majewska','K',5,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('nczarnecka','n3cka1','Natalia','Czarnecka','K',7,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('uandrzejewska','u48ska5','Urszula','Andrzejewska','K',7,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jgorska','j19ska3','Joanna','Górska','K',7,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('asikorska','a39ska1','Alicja','Sikorska','K',10,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ncieslak','n35lak10','Natalia','Cieślak','K',5,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('bmazurek','b50rek9','Barbara','Mazurek','K',7,'handler','wege','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rnowakowska','r42ska11','Renata','Nowakowska','K',5,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('tsikora','t20ora5','Teresa','Sikora','K',4,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('bkowalczyk','b54zyk3','Beata','Kowalczyk','K',3,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ewasilewska','e57ska9','Elżbieta','Wasilewska','K',2,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('tkwiatkowska','t41ska11','Teresa','Kwiatkowska','K',8,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('hnowak','h17wak4','Halina','Nowak','K',10,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('bbaran','b21ran1','Barbara','Baran','K',2,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ssadowska','s1ska3','Stanisława','Sadowska','K',8,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('zwojciechowska','z36ska8','Zofia','Wojciechowska','K',10,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('abaranowska','a29ska2','Alicja','Baranowska','K',9,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('sborkowska','s5ska6','Stanisława','Borkowska','K',5,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ezajac','e11jąc4','Elwira','Zając','K',7,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ejablonska','e21ska5','Ewelina','Jabłońska','K',2,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('emajewska','e12ska4','Elżbieta','Majewska','K',1,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('bwasilewska','b55ska8','Bożena','Wasilewska','K',1,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('olis','o37Lis2','Oksana','Lis','K',9,'cutter','wege','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('sbak','s10Bąk10','Sandra','Bąk','K',2,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('aszczepanska','a24ska6','Agnieszka','Szczepańska','K',6,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mpawlowska','m29ska3','Maria','Pawłowska','K',2,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ipawlak','i48lak11','Iwona','Pawlak','K',9,'handler','wege','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jpiotrowska','j28ska4','Jadwiga','Piotrowska','K',7,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rpietrzak','r52zak7','Renata','Pietrzak','K',3,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wszulc','w26ulc2','Wiesława','Szulc','K',4,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ntomaszewska','n19ska3','Natalia','Tomaszewska','K',5,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mprzybylska','m11ska3','Magdalena','Przybylska','K',6,'handler','wege','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('eolszewska','e24ska2','Ewa','Olszewska','K',3,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('adudek','a3dek10','Agata','Dudek','K',6,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jkalinowska','j23ska11','Janina','Kalinowska','K',10,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('uprzybylska','u8ska6','Urszula','Przybylska','K',3,'cutter','wege','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('swieczorek','s27rek6','Sylwia','Wieczorek','K',4,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('zkowalczyk','z2zyk2','Zdzisław','Kowalczyk','M',9,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('cduda','c29uda9','Czesław','Duda','M',6,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jpawlowski','j12ski4','Jacek','Pawłowski','M',1,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rkrajewski','r21ski3','Roman','Krajewski','M',1,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('msikora','m16ora5','Mariusz','Sikora','M',3,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jmazur','j11zur9','Jacek','Mazur','M',1,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mkalinowski','m59ski3','Maciej','Kalinowski','M',10,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('skrajewski','s49ski8','Sebastian','Krajewski','M',8,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('lbak','l50Bąk11','Leszek','Bąk','M',3,'handler','wege','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mwalczak','m44zak7','Marek','Walczak','M',2,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jjankowski','j2ski3','Jan','Jankowski','M',7,'cutter','wege','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('spiotrowski','s55ski9','Stanisław','Piotrowski','M',1,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('cdabrowski','c10ski3','Czesław','Dąbrowski','M',8,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('pczarnecki','p49cki7','Piotr','Czarnecki','M',7,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jsobczak','j57zak11','Jakub','Sobczak','M',3,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mczerwinski','m19ski8','Mateusz','Czerwiński','M',8,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jszczepanski','j41ski7','Jacek','Szczepański','M',1,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('kbaranowski','k34ski3','Krzysztof','Baranowski','M',9,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rkwiatkowski','r36ski2','Ryszard','Kwiatkowski','M',8,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rwisniewski','r48ski11','Ryszard','Wiśniewski','M',5,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('kbaran','k35ran6','Karol','Baran','M',1,'cutter','wege','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mwojcik','m1cik8','Maciej','Wójcik','M',4,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wtomaszewski','w10ski7','Waldemar','Tomaszewski','M',4,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('awilk','a57ilk0','Artur','Wilk','M',7,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('akwiatkowski','a2ski8','Adam','Kwiatkowski','M',6,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jszymanski','j27ski2','Jerzy','Szymański','M',9,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mkrol','m46ról7','Mateusz','Król','M',3,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('pnowicki','p58cki8','Paweł','Nowicki','M',4,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('szajac','s53jąc5','Sebastian','Zając','M',10,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wandrzejewski','w10ski6','Władysław','Andrzejewski','M',4,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dwojcik','d10cik9','Dawid','Wójcik','M',2,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jwalczak','j1zak9','Jakub','Walczak','M',4,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('iszczepanski','i45ski1','Ireneusz','Szczepański','M',7,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('lsadowski','l42ski10','Ludwik','Sadowski','M',6,'cutter','wege','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rostrowski','r31ski9','Rafał','Ostrowski','M',6,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dszczepanski','d27ski9','Dariusz','Szczepański','M',9,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('akalinowski','a13ski5','Andrzej','Kalinowski','M',5,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mmalinowski','m26ski4','Marek','Malinowski','M',1,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('lsawicki','ł10cki10','Łukasz','Sawicki','M',10,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rbak','r30Bąk7','Robert','Bąk','M',6,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jjasinski','j30ski2','Jarosław','Jasiński','M',6,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mostrowski','m58ski10','Marcin','Ostrowski','M',2,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rsawicki','r9cki8','Rafał','Sawicki','M',10,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('sstępien','s30ień3','Stanisław','Stępień','M',6,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wzakrzewski','w19ski0','Władysław','Zakrzewski','M',3,'cutter','wege','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('sziolkowski','s18ski9','Stanisław','Ziółkowski','M',3,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jmazurek','j47rek1','Janusz','Mazurek','M',5,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('pbaran','p14ran3','Piotr','Baran','M',9,'cutter','wege','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('lostrowski','ł58ski7','Łukasz','Ostrowski','M',2,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dzajac','d44jąc1','Damian','Zając','M',8,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rjaworski','r39ski1','Roman','Jaworski','M',3,'handler','wege','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jwasilewski','j26ski8','Jakub','Wasilewski','M',3,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rkalinowski','r2ski1','Robert','Kalinowski','M',6,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wwieczorek','w10rek6','Wojciech','Wieczorek','M',8,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('lrutkowski','ł53ski4','Łukasz','Rutkowski','M',10,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('tkaczmarek','t49rek3','Tadeusz','Kaczmarek','M',7,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('snowakowski','s3ski8','Sebastian','Nowakowski','M',7,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rmichalak','r3lak1','Rafał','Michalak','M',1,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('cjakubowski','c5ski0','Czesław','Jakubowski','M',1,'handler','wege','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wnowicki','w25cki9','Wiesław','Nowicki','M',7,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dsokolowski','d10ski5','Daniel','Sokołowski','M',5,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('smazurek','s57rek8','Sławomir','Mazurek','M',3,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mzajac','m37jąc4','Marek','Zając','M',1,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rlaskowski','r53ski0','Ryszard','Laskowski','M',3,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jkalinowski','j23ski5','Jarosław','Kalinowski','M',9,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('zkowalski','z26ski3','Zbigniew','Kowalski','M',3,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('cjasinski','c24ski5','Czesław','Jasiński','M',9,'cutter','wege','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dzalewski','d43ski1','Damian','Zalewski','M',10,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('aglowacki','a45cki5','Andrzej','Głowacki','M',4,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('sszulc','s7ulc2','Sławomir','Szulc','M',1,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('pandrzejewski','p12ski7','Piotr','Andrzejewski','M',1,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wpawlak','w13lak6','Władysław','Pawlak','M',7,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wlaskowski','w31ski1','Waldemar','Laskowski','M',5,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jmakowski','j35ski8','Jan','Makowski','M',8,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wmazurek','w12rek9','Waldemar','Mazurek','M',9,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jsadowski','j41ski8','Jarosław','Sadowski','M',1,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mjankowski','m34ski8','Marian','Jankowski','M',5,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jwoźniak','j24iak3','Jan','Woźniak','M',10,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('lwalczak','ł0zak8','Łukasz','Walczak','M',10,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jwrobel','j13bel9','Jan','Wróbel','M',3,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('azielinski','a26ski2','Andrzej','Zieliński','M',6,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('anowakowski','a23ski6','Artur','Nowakowski','M',3,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ewilk','e37ilk0','Ernest','Wilk','M',8,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('trutkowski','t60ski10','Tadeusz','Rutkowski','M',3,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jgrabowski','j35ski5','Jarosław','Grabowski','M',3,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ssobczak','s31zak10','Sebastian','Sobczak','M',2,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('lkrajewski','l15ski9','Leszek','Krajewski','M',2,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mzawadzki','m16zki4','Marek','Zawadzki','M',8,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('djasinski','d23ski8','Daniel','Jasiński','M',7,'cutter','wege','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mwilk','m29ilk4','Marian','Wilk','M',10,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('lzielinski','l46ski7','Leszek','Zieliński','M',10,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('akrol','a1ról3','Artur','Król','M',1,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('alis','a33Lis7','Adam','Lis','M',2,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('lgorski','ł47ski6','Łukasz','Górski','M',8,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wkaminski','w52ski5','Waldemar','Kamiński','M',1,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('swrobel','s16bel1','Sławomir','Wróbel','M',10,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('apiotrowski','a0ski7','Adam','Piotrowski','M',1,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('tjasinski','t49ski5','Tadeusz','Jasiński','M',5,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('kstępien','k33ień2','Kazimierz','Stępień','M',10,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('eprzybylski','e12ski6','Edward','Przybylski','M',3,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mjasinski','m25ski5','Marcin','Jasiński','M',6,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mszczepanski','m52ski6','Mieczysław','Szczepański','M',4,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('msawicki','m17cki9','Maciej','Sawicki','M',3,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mlewandowski','m8ski6','Michał','Lewandowski','M',8,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('cmakowski','c34ski2','Czesław','Makowski','M',6,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('zduda','z13uda3','Zbigniew','Duda','M',3,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('spawlowski','s53ski10','Sławomir','Pawłowski','M',3,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rszymczak','r50zak0','Robert','Szymczak','M',2,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rmaciejewski','r17ski6','Roman','Maciejewski','M',6,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dwroblewski','d12ski8','Damian','Wróblewski','M',7,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jwysocki','j51cki9','Jacek','Wysocki','M',6,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jbaran','j33ran1','Janusz','Baran','M',1,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('kzakrzewski','k10ski5','Krzysztof','Zakrzewski','M',9,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('emazurek','e39rek1','Eryk','Mazurek','M',5,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('zkaźmierczak','z60zak6','Zbigniew','Kaźmierczak','M',4,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rczarnecki','r53cki1','Rafał','Czarnecki','M',4,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rrutkowski','r45ski3','Rafał','Rutkowski','M',1,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ekubiak','e21iak2','Edward','Kubiak','M',6,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rkaczmarek','r5rek4','Rafał','Kaczmarek','M',9,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dduda','d18uda5','Dawid','Duda','M',6,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('zkolodziej','z33iej2','Zbigniew','Kołodziej','M',6,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('abak','a36Bąk6','Artur','Bąk','M',3,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jmaciejewski','j56ski4','Jerzy','Maciejewski','M',6,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jkucharski','j21ski7','Jan','Kucharski','M',9,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dbak','d51Bąk6','Damian','Bąk','M',10,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jzalewski','j15ski7','Jakub','Zalewski','M',6,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('swisniewski','s1ski3','Stanisław','Wiśniewski','M',1,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rzielinski','r12ski11','Rafał','Zieliński','M',9,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('sgajewski','s16ski6','Stanisław','Gajewski','M',7,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('costrowski','c49ski4','Czesław','Ostrowski','M',10,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wmarciniak','w58iak8','Wojciech','Marciniak','M',6,'handler','wege','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('gsobczak','g47zak9','Grzegorz','Sobczak','M',7,'cutter','wege','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('tmazurek','t51rek4','Tomasz','Mazurek','M',1,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ksikora','k54ora8','Kazimierz','Sikora','M',2,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rpiotrowski','r51ski3','Remigiusz','Piotrowski','M',7,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('smaciejewski','s16ski6','Sławomir','Maciejewski','M',5,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('aurbanski','a49ski11','Andrzej','Urbański','M',4,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dmazur','d53zur6','Daniel','Mazur','M',3,'handler','wege','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('amichalski','a56ski4','Artur','Michalski','M',10,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wmichalski','w14ski9','Władysław','Michalski','M',3,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mmazurek','m59rek4','Marek','Mazurek','M',7,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('hwilk','h48ilk7','Henryk','Wilk','M',1,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('pzawadzki','p19zki7','Przemysław','Zawadzki','M',6,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rcieslak','r35lak10','Roman','Cieślak','M',10,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mpiotrowski','m1ski2','Marek','Piotrowski','M',9,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('zmichalski','z32ski10','Zbigniew','Michalski','M',2,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wzawadzki','w4zki0','Władysław','Zawadzki','M',3,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('lwysocki','ł31cki5','Łukasz','Wysocki','M',8,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('gwitkowski','g4ski8','Grzegorz','Witkowski','M',3,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('msadowski','m50ski6','Mateusz','Sadowski','M',7,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rkrawczyk','r31zyk4','Roman','Krawczyk','M',7,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ptomaszewski','p10ski10','Paweł','Tomaszewski','M',1,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('gmichalski','g24ski4','Grzegorz','Michalski','M',3,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mlis','m35Lis9','Maciej','Lis','M',10,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('molszewski','m48ski8','Maciej','Olszewski','M',4,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mbak','m5Bąk10','Marian','Bąk','M',2,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dkozlowski','d44ski5','Dawid','Kozłowski','M',2,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ktomaszewski','k49ski1','Krzysztof','Tomaszewski','M',2,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('pwroblewski','p42ski10','Paweł','Wróblewski','M',9,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('lkaczmarek','ł57rek5','Łukasz','Kaczmarek','M',8,'handler','mięso','M');

#Utworzenie tabeli meczów
create table mecze(id tinyint primary key auto_increment, faza varchar(12), kto_id tinyint, z_kim_id tinyint, kto_pkt tinyint, z_kim_pkt tinyint, foreign key(kto_id) references druzyny(id), foreign key(z_kim_id) references druzyny(id));

#Utworzenie widoku "punktacja" w którym zbierana jest liczba zwycięstw i małe punkty TYLKO Z FAZY GRUPOWEJ
create view punktacja as
select kto_id as Drużyna, 1 as Zwycięstwa, kto_pkt As Punkty_plus, z_kim_pkt As Punkty_minus from mecze where kto_pkt>z_kim_pkt and faza='Faza grupowa'
union all
select z_kim_id as Drużyna, 1 as Zwycięstwa, z_kim_pkt As Punkty_plus, kto_pkt As Punkty_minus from mecze where kto_pkt<z_kim_pkt and faza='Faza grupowa'
union all
select kto_id as Drużyna, 0 as Zwycięstwa, kto_pkt As Punkty_plus, z_kim_pkt As Punkty_minus from mecze where kto_pkt<z_kim_pkt and faza='Faza grupowa'
union all
select z_kim_id as Drużyna, 0 as Zwycięstwa, z_kim_pkt As Punkty_plus, kto_pkt As Punkty_minus from mecze where kto_pkt>z_kim_pkt and faza='Faza grupowa';

#Stworzenie triggerów do aktualizacji liczby rozegranych meczów, zdobyczy punktowych itp. (do punktów dodano małe randomowe wpisy, żeby rozgraniczyć dwie drużyny o tych samych punktach - trochę to brzydkie rozwiązanie, ale na razie tak musi być)
create trigger po_meczu after update on mecze for each row update druzyny set mecze = (select count(*) from punktacja where Drużyna = id), zwyc = coalesce((select sum(Zwycięstwa) from punktacja where Drużyna = id),0), porazka = (select count(*) from punktacja where Zwycięstwa=0 and Drużyna = id), male_pkt_plus = coalesce((select sum(Punkty_plus) from punktacja where Drużyna = id),0), male_pkt_minus = coalesce((select sum(Punkty_minus) from punktacja where Drużyna = id),0), roznica_pkt = male_pkt_plus - male_pkt_minus, punkty = zwyc+roznica_pkt/1000+rand()/1000;

#Stworzenie drugiego triggera (właściwie to dwóch triggerów) do nadawania awansów w fazie playoff
create trigger playoff1 after update on mecze for each row update druzyny set awans = awans + 1 where old.faza!='Faza grupowa' and old.kto_id = id and new.kto_pkt = 15;
create trigger playoff2 after update on mecze for each row update druzyny set awans = awans + 1 where old.faza!='Faza grupowa' and old.z_kim_id = id and new.z_kim_pkt = 15;

#select * from mecze;
#select * from druzyny;
#select * from zawodnicy;
#update mecze set kto_pkt = 15, z_kim_pkt = floor(rand()*15) where id<47;
