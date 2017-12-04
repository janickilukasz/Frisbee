#Usuwanie poprzedniej wersji danych
drop trigger if exists frisbee.po_meczu;
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
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('bbaranowska','b10ska4','Beata','Baranowska','K',3,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('anowak','a22wak1','Anna','Nowak','K',3,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('swilk','s59ilk5','Stanisława','Wilk','K',1,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('kandrzejewska','k14ska2','Karolina','Andrzejewska','K',1,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('kkowalska','k52ska10','Krystyna','Kowalska','K',6,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('sadamska','s1ska10','Stefania','Adamska','K',2,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('kwysocka','k51cka2','Kazimiera','Wysocka','K',7,'cutter','wege','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('gmarciniak','g6iak5','Grażyna','Marciniak','K',8,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('imazurek','i59rek1','Izabela','Mazurek','K',7,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('zduda','z19uda4','Zofia','Duda','K',2,'handler','wege','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('awalczak','a36zak3','Aleksandra','Walczak','K',4,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('msikorska','m8ska1','Magdalena','Sikorska','K',1,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dtomaszewska','d43ska9','Dorota','Tomaszewska','K',1,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('bmajewska','b42ska2','Barbara','Majewska','K',2,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('nczarnecka','n59cka7','Natalia','Czarnecka','K',7,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('uandrzejewska','u36ska11','Urszula','Andrzejewska','K',3,'handler','wege','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jgorska','j43ska5','Joanna','Górska','K',7,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('asikorska','a6ska3','Alicja','Sikorska','K',6,'cutter','wege','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ncieslak','n51lak2','Natalia','Cieślak','K',7,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('bmazurek','b14rek8','Barbara','Mazurek','K',2,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rnowakowska','r51ska8','Renata','Nowakowska','K',10,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('tsikora','t6ora10','Teresa','Sikora','K',1,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('bkowalczyk','b51zyk3','Beata','Kowalczyk','K',5,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ewasilewska','e27ska5','Elżbieta','Wasilewska','K',9,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('tkwiatkowska','t9ska3','Teresa','Kwiatkowska','K',8,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('hnowak','h45wak6','Halina','Nowak','K',3,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('bbaran','b35ran10','Barbara','Baran','K',7,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ssadowska','s46ska4','Stanisława','Sadowska','K',8,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('zwojciechowska','z51ska1','Zofia','Wojciechowska','K',7,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('abaranowska','a50ska7','Alicja','Baranowska','K',2,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('sborkowska','s22ska7','Stanisława','Borkowska','K',3,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ezajac','e7jąc9','Elwira','Zając','K',9,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ejablonska','e6ska0','Ewelina','Jabłońska','K',2,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('emajewska','e9ska2','Elżbieta','Majewska','K',9,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('bwasilewska','b51ska1','Bożena','Wasilewska','K',8,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mlis','m11Lis8','Marzena','Lis','K',1,'handler','wege','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('abak','a55Bąk2','Agata','Bąk','K',7,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('aszczepanska','a22ska1','Agnieszka','Szczepańska','K',1,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mpawlowska','m26ska0','Maria','Pawłowska','K',2,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ipawlak','i0lak3','Iwona','Pawlak','K',3,'handler','wege','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jpiotrowska','j38ska6','Jadwiga','Piotrowska','K',1,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rpietrzak','r28zak10','Renata','Pietrzak','K',3,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wszulc','w36ulc0','Wiesława','Szulc','K',9,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('ntomaszewska','n30ska9','Natalia','Tomaszewska','K',3,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mprzybylska','m42ska3','Magdalena','Przybylska','K',2,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('eolszewska','e45ska3','Ewa','Olszewska','K',6,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('adudek','a50dek1','Agata','Dudek','K',5,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jkalinowska','j52ska6','Janina','Kalinowska','K',8,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('uprzybylska','u38ska5','Urszula','Przybylska','K',3,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('swieczorek','s26rek9','Sylwia','Wieczorek','K',5,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('zkowalczyk','z11zyk8','Zdzisław','Kowalczyk','M',4,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('cduda','c15uda1','Czesław','Duda','M',8,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jpawlowski','j12ski2','Jacek','Pawłowski','M',8,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rkrajewski','r38ski7','Roman','Krajewski','M',6,'cutter','wege','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('msikora','m26ora6','Mariusz','Sikora','M',6,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jmazur','j11zur10','Jacek','Mazur','M',10,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mkalinowski','m32ski5','Maciej','Kalinowski','M',2,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('skrajewski','s45ski10','Sebastian','Krajewski','M',5,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('lbak','l24Bąk4','Leszek','Bąk','M',5,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mwalczak','m2zak4','Marek','Walczak','M',5,'cutter','wege','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jjankowski','j1ski8','Jan','Jankowski','M',4,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('spiotrowski','s14ski10','Stanisław','Piotrowski','M',4,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('cdabrowski','c28ski8','Czesław','Dąbrowski','M',7,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rczarnecki','r20cki4','Roman','Czarnecki','M',4,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jsobczak','j41zak3','Jakub','Sobczak','M',3,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mczerwinski','m59ski1','Mateusz','Czerwiński','M',1,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jszczepanski','j13ski5','Jacek','Szczepański','M',4,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('kbaranowski','k22ski2','Krzysztof','Baranowski','M',8,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rkwiatkowski','r42ski10','Ryszard','Kwiatkowski','M',2,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rwisniewski','r47ski2','Ryszard','Wiśniewski','M',10,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('kbaran','k43ran8','Karol','Baran','M',4,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mwojcik','m21cik6','Maciej','Wójcik','M',4,'handler','wege','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wtomaszewski','w45ski3','Waldemar','Tomaszewski','M',9,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('awilk','a30ilk5','Artur','Wilk','M',3,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('akwiatkowski','a28ski6','Adam','Kwiatkowski','M',3,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jszymanski','j40ski9','Jerzy','Szymański','M',7,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mkrol','m24ról8','Mateusz','Król','M',3,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('pnowicki','p7cki1','Paweł','Nowicki','M',8,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('szajac','s54jąc9','Sebastian','Zając','M',8,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wandrzejewski','w10ski6','Władysław','Andrzejewski','M',8,'cutter','wege','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dwojcik','d55cik3','Dawid','Wójcik','M',8,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jwalczak','j13zak9','Jakub','Walczak','M',3,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mszczepanski','m49ski3','Mirosław','Szczepański','M',6,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('msadowski','m51ski10','Marian','Sadowski','M',9,'handler','wege','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rostrowski','r52ski4','Rafał','Ostrowski','M',5,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dszczepanski','d52ski0','Dariusz','Szczepański','M',10,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('akalinowski','a20ski2','Andrzej','Kalinowski','M',8,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mmalinowski','m1ski7','Marek','Malinowski','M',8,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('lsawicki','ł52cki5','Łukasz','Sawicki','M',3,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mbak','m21Bąk4','Marian','Bąk','M',2,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jjasinski','j8ski10','Jarosław','Jasiński','M',4,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mostrowski','m14ski1','Marcin','Ostrowski','M',10,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rsawicki','r57cki9','Rafał','Sawicki','M',2,'handler','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('sstepien','s1ień9','Stanisław','Stępień','M',6,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wzakrzewski','w34ski10','Władysław','Zakrzewski','M',7,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('sziolkowski','s18ski3','Stanisław','Ziółkowski','M',8,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mmazurek','m16rek0','Mirosław','Mazurek','M',4,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('pbaran','p44ran10','Piotr','Baran','M',1,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('lostrowski','ł43ski5','Łukasz','Ostrowski','M',1,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dzajac','d19jąc5','Damian','Zając','M',2,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rjaworski','r28ski1','Roman','Jaworski','M',8,'handler','wege','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jwasilewski','j21ski3','Jakub','Wasilewski','M',1,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rkalinowski','r58ski5','Robert','Kalinowski','M',1,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wwieczorek','w29rek5','Wojciech','Wieczorek','M',8,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('lrutkowski','ł42ski0','Łukasz','Rutkowski','M',1,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rkaczmarek','r30rek5','Roman','Kaczmarek','M',10,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('snowakowski','s57ski1','Sebastian','Nowakowski','M',6,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rmichalak','r29lak4','Rafał','Michalak','M',3,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('cjakubowski','c32ski3','Czesław','Jakubowski','M',9,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wnowicki','w6cki0','Wiesław','Nowicki','M',1,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dsokolowski','d24ski4','Daniel','Sokołowski','M',10,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('smazurek','s13rek6','Sławomir','Mazurek','M',1,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mzajac','m34jąc2','Marek','Zając','M',1,'handler','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('rlaskowski','r51ski4','Ryszard','Laskowski','M',1,'handler','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jkalinowski','j9ski4','Jarosław','Kalinowski','M',10,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('zkowalski','z35ski8','Zbigniew','Kowalski','M',5,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('cjasinski','c16ski9','Czesław','Jasiński','M',7,'cutter','mięso','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('dzalewski','d9ski0','Damian','Zalewski','M',10,'handler','wege','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('aglowacki','a6cki2','Andrzej','Głowacki','M',2,'cutter','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('sszulc','s56ulc10','Sławomir','Szulc','M',2,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('pandrzejewski','p47ski8','Piotr','Andrzejewski','M',4,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wpawlak','w7lak8','Władysław','Pawlak','M',10,'cutter','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wlaskowski','w49ski6','Waldemar','Laskowski','M',10,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jmakowski','j40ski11','Jan','Makowski','M',9,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('wmazurek','w55rek4','Waldemar','Mazurek','M',2,'cutter','wege','M');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jsadowski','j39ski4','Jarosław','Sadowski','M',7,'cutter','mięso','XL');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('mjankowski','m11ski0','Marian','Jankowski','M',9,'cutter','mięso','S');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jwozniak','j13iak3','Jan','Woźniak','M',9,'handler','mięso','L');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('lwalczak','ł4zak1','Łukasz','Walczak','M',5,'handler','mięso','XS');
insert into zawodnicy(login, pass, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar) values ('jwrobel','j39bel5','Jan','Wróbel','M',9,'cutter','mięso','M');

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
/*
#Jaka faza po fazie grupowej? (w zależności od wybranego systemu rozgrywek)
select case when (select cwierc from systemy where id=(select * from wybrany_system))=1 then 'cwiercfinaly' when (select pol from systemy where id=(select * from wybrany_system))=1 then 'polfinaly' else 'finaly' end as 'Faza następna';

#Ile drużyn awansuje po fazie grupowej?
select case when (select cwierc from systemy where id=(select * from wybrany_system))=1 then 8 when (select pol from systemy where id=(select * from wybrany_system))=1 then 4 else 2 end as 'Ile drużyn awansuje łącznie';
#Podstawienie pod zmienną powyższego
set @ile_awansuje = (select case when (select cwierc from systemy where id=(select * from wybrany_system))=1 then 8 when (select pol from systemy where id=(select * from wybrany_system))=1 then 4 else 2 end as 'Ile drużyn awansuje łącznie');

#Ile drużyn awansuje bezpośrednio z grupy?
select(floor((select case when (select cwierc from systemy where id=(select * from wybrany_system))=1 then 8 when (select pol from systemy where id=(select * from wybrany_system))=1 then 4 else 2 end as Faza)/(select ilosc_gr from systemy where id=(select * from wybrany_system)))) As 'Awans bezpośredni z grupy';
#Podstawienie powyższej wartości pod zmienną
set @bezp = (select(floor((select case when (select cwierc from systemy where id=(select * from wybrany_system))=1 then 8 when (select pol from systemy where id=(select * from wybrany_system))=1 then 4 else 2 end as Faza)/(select ilosc_gr from systemy where id=(select * from wybrany_system)))) As 'Awans bezpośredni z grupy');

#Ile grup?
select ilosc_gr from wybrany_system natural join systemy;

#Ile drużyn awansuje dodatkowo (spoza miejsc premiowanych bezpośrednio)?
select((select case when (select cwierc from systemy where id=(select * from wybrany_system))=1 then 8 when (select pol from systemy where id=(select * from wybrany_system))=1 then 4 else 2 end)
-
(select(floor((select case when (select cwierc from systemy where id=(select * from wybrany_system))=1 then 8 when (select pol from systemy where id=(select * from wybrany_system))=1 then 4 else 2 end as Faza)/(select ilosc_gr from systemy where id=(select * from wybrany_system)))))
*
(select ilosc_gr from wybrany_system natural join systemy)) as 'Ile drużyn awansuje dodatkowo';
#Podstawienie powyższej wartości pod zmienną
set @dodat = (
select((select case when (select cwierc from systemy where id=(select * from wybrany_system))=1 then 8 when (select pol from systemy where id=(select * from wybrany_system))=1 then 4 else 2 end)
-
(select(floor((select case when (select cwierc from systemy where id=(select * from wybrany_system))=1 then 8 when (select pol from systemy where id=(select * from wybrany_system))=1 then 4 else 2 end as Faza)/(select ilosc_gr from systemy where id=(select * from wybrany_system)))))
*
(select ilosc_gr from wybrany_system natural join systemy)) as 'Ile drużyn awansuje dodatkowo');

#Wstawianie awansu drużynom z pierwszych miejsc
update druzyny join (select max(punkty) as b from druzyny where grupa=1) as tab on punkty=b set awans = 1;
update druzyny join (select max(punkty) as b from druzyny where grupa=2) as tab on punkty=b set awans = 1;
update druzyny join (select max(punkty) as b from druzyny where grupa=3) as tab on punkty=b set awans = 1;
update druzyny join (select max(punkty) as b from druzyny where grupa=4) as tab on punkty=b set awans = 1;
update druzyny join (select max(punkty) as b from druzyny where grupa=5) as tab on punkty=b set awans = 1;
update druzyny join (select max(punkty) as b from druzyny where grupa=6) as tab on punkty=b set awans = 1;
update druzyny join (select max(punkty) as b from druzyny where grupa=7) as tab on punkty=b set awans = 1;

#Wstawianie awansu drużynom z drugich miejsc (jeżeli tak przewiduje system) - więcej niż 2 nie ma w systemach:
update druzyny join (select max(punkty) as b from druzyny where grupa=1 and punkty<(select max(punkty) from druzyny where grupa=1)) as tab on punkty=b set awans = case when @bezp>1 then 1 else 0 end;
update druzyny join (select max(punkty) as b from druzyny where grupa=2 and punkty<(select max(punkty) from druzyny where grupa=2)) as tab on punkty=b set awans = case when @bezp>1 then 1 else 0 end;
update druzyny join (select max(punkty) as b from druzyny where grupa=3 and punkty<(select max(punkty) from druzyny where grupa=3)) as tab on punkty=b set awans = case when @bezp>1 then 1 else 0 end;
update druzyny join (select max(punkty) as b from druzyny where grupa=4 and punkty<(select max(punkty) from druzyny where grupa=4)) as tab on punkty=b set awans = case when @bezp>1 then 1 else 0 end;
update druzyny join (select max(punkty) as b from druzyny where grupa=5 and punkty<(select max(punkty) from druzyny where grupa=5)) as tab on punkty=b set awans = case when @bezp>1 then 1 else 0 end;
update druzyny join (select max(punkty) as b from druzyny where grupa=6 and punkty<(select max(punkty) from druzyny where grupa=6)) as tab on punkty=b set awans = case when @bezp>1 then 1 else 0 end;
update druzyny join (select max(punkty) as b from druzyny where grupa=7 and punkty<(select max(punkty) from druzyny where grupa=7)) as tab on punkty=b set awans = case when @bezp>1 then 1 else 0 end;

#Wstawianie awansu drużynom pozostałym (nie ma więcej niż 3):
update druzyny join (select max(punkty) as b from druzyny where awans = 0) as tab on b = punkty set awans = case when @dodat>0 then 1 else 0 end;
update druzyny join (select max(punkty) as b from druzyny where awans = 0) as tab on b = punkty set awans = case when @dodat>1 then 1 else 0 end;
update druzyny join (select max(punkty) as b from druzyny where awans = 0) as tab on b = punkty set awans = case when @dodat>2 then 1 else 0 end;

insert into mecze(faza, kto_id, z_kim_id) select 'Ćwierćfinał', (select id from druzyny where awans = 1 order by punkty desc limit 1 offset 0), (select id from druzyny where awans = 1 order by punkty asc limit 1 offset 0);
insert into mecze(faza, kto_id, z_kim_id) select 'Ćwierćfinał', (select id from druzyny where awans = 1 order by punkty desc limit 1 offset 1), (select id from druzyny where awans = 1 order by punkty asc limit 1 offset 1);
insert into mecze(faza, kto_id, z_kim_id) select 'Ćwierćfinał', (select id from druzyny where awans = 1 order by punkty desc limit 1 offset 2), (select id from druzyny where awans = 1 order by punkty asc limit 1 offset 2);
insert into mecze(faza, kto_id, z_kim_id) select 'Ćwierćfinał', (select id from druzyny where awans = 1 order by punkty desc limit 1 offset 3), (select id from druzyny where awans = 1 order by punkty asc limit 1 offset 3);
*/