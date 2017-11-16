# Frisbee
Application for organising frisbee HAT tournament

== PL ==
Aplikacja obsługująca przebieg turnieju w Ultimate Frisbee w formacie HAT, czyli z zawodnikami losowo przydzielanymi do drużyn.

Ultimate Frisbee to gra, w której konkurują ze sobą dwie drużyny. Na boisku w jednej drużynie przebywa 7 osób, ale jest nieograniczona liczba zmian, więc zawodników w drużynie zwykle jest więcej (~15).
Turniej w formacie HAT oznacza, że na turniej rejestrują się pojedyncze osoby (określając m.in. swój poziom gry i pozycję na której grają), a potem, w drodze losowania, są przydzielani do drużyn.
W drużynie grają ze sobą zarówno chłopaki jak i dziewczyny.

Końcowa wersja programu powinna umożliwić rejestrację zawodników, wygenerowanie potrzebnych danych dla organizatorów, podzielenie zawodników na drużyny oraz śledzenie przebiegu turnieju (podgląd wyników meczów).

Obecna wersja zawiera:
1. plik "generator_nazwisk.ods" (plik Open Office Calc) w którym wkleiłem imiona i nazwiska z generatora znalezionego w sieci i uzupełniłem o losowe wartości potrzebne w bazie danych.
2. plik "skrypt_prototyp.sql", który:
	a. tworzy nową bazę danych
  b. tworzy tabelę parametrów np. ile będzie drużyn, ile będzie grup
  c. tworzy tabelę drużyn i uzupełnia ją o przykładowe drużyny
  d. tworzy trigger, który automatycznie zwiększa parametr 'ilość drużyn' w tabeli parametrów, gdy dodawana jest drużyna.
  e. tworzy tabelę zawodników i uzupełnia ją o przykładowych zawodników
  f. losowo przypisuje zawodników do drużyn
  g. generuje zestawienie ile potrzeba przygotować posiłków mięsnych i wegańskich
  h. generuje zestawienie ile potrzeba zamówić koszulek, w jakim kolorze i w jakim rozmiarze
  i. przypisuje drużyny do grup
  j. tworzy tabelę meczów i wypełnia ją zaplanowanymi meczami oraz udostępnia łatwy podgląd tych meczów
  k. wprowadza kilka przykładowych wyników meczów
  
  
  Najbliższe kroki do zrobienia:
  a. stworzyć mechanizm, który rozdzieli zawodników po równo do drużyn i będzie kierował się również równomiernym rozkładem zawodników pod względem poziomu gry, pozycji na boisku i płci.
  b. stworzyć podliczanie liczby zwycięstw i zdobytych punktów
  c. stworzyć generator par drużyn w fazie play-off aż do finału
  d. wprowadzić większe możliwości edycji parametrów turnieju np. :
    - zmiana liczby drużyn automatycznie generuje inny system rozgrywek
    - możliwość wyboru czym kończy się mecz (obecnie przyjęto, że gra się do 15 pkt) i możliwość remisu
    - różne opcje boiskowe albo noclegowe
	e. dodać tabelę login/pass
	f. dodać tabelę uprawnień
  
