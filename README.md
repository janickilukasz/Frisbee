# Frisbee
Application for organising frisbee HAT tournament

== PL ==
Aplikacja obsługująca przebieg turnieju w Ultimate Frisbee w formacie HAT, czyli z zawodnikami losowo przydzielanymi do drużyn.

Ultimate Frisbee to gra, w której konkurują ze sobą dwie drużyny. Na boisku w jednej drużynie przebywa 7 osób, ale jest nieograniczona liczba zmian, więc zawodników w drużynie zwykle jest więcej (~15).
Turniej w formacie HAT oznacza, że na turniej rejestrują się pojedyncze osoby (określając m.in. swój poziom gry i pozycję na której grają), a potem, w drodze losowania, są przydzielani do drużyn.
W drużynie grają ze sobą zarówno chłopaki jak i dziewczyny.

Końcowa wersja programu powinna umożliwić rejestrację zawodników, wygenerowanie potrzebnych danych dla organizatorów, podzielenie zawodników na drużyny oraz śledzenie przebiegu turnieju (podgląd wyników meczów).

Obecna wersja zawiera:
1. plik "generator_nazwisk.ods" (plik Open Office Calc) w którym wkleiłem imiona i nazwiska z generatora znalezionego w sieci i uzupełniłem o losowe wartości potrzebne w bazie danych + zakładki dotyczące generowania wyników meczów i opis systemów rozgrywek
2. plik "skrypt_prototyp.sql", który:
	a. tworzy nową bazę danych
	b. tworzy tabelę z systemami rozgrywek (np.ile jest grup, czy są rewanże itp.)
	c. tworzy tabelę drużyn i uzupełnia ją o przykładowe drużyny
	d. tworzy tabelę zawodników i uzupełnia ją o przykładowych zawodników
	e. losowo przypisuje zawodników do drużyn
	f. generuje zestawienie ile potrzeba przygotować posiłków mięsnych i wegańskich
	g. generuje zestawienie ile potrzeba zamówić koszulek, w jakim kolorze i w jakim rozmiarze
	h. przypisuje drużyny do grup
	i. tworzy tabelę meczów i wypełnia ją zaplanowanymi meczami oraz udostępnia łatwy podgląd tych meczów
	j. wprowadza kilka przykładowych wyników meczów
	k. umożliwia podgląd meczów w których bierze udział konkretny zawodnik
	l. po rozegraniu fazy grupowej automatycznie przydziela awans do kolejnej fazy i łączy drużyny w pary (na razie ćwierćfinałowe tylko)
	m. tworzy tabelę z loginami i hasłami i uzupełnia ją kilkoma przykładowymi rekordami
  
  
  Najbliższe kroki do zrobienia:
	a. stworzyć mechanizm, który rozdzieli zawodników po równo do drużyn i będzie kierował się również równomiernym rozkładem zawodników pod względem poziomu gry, pozycji na boisku i płci.
	b. możliwość wyboru czym kończy się mecz (obecnie przyjęto, że gra się do 15 pkt) i możliwość remisu
    c. różne opcje boiskowe albo noclegowe
  
