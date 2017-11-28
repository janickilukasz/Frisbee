#-*- coding: utf-8 -*-
import pymysql
from sys import exit
try:
    from proj_src.haslo import polacz
except ImportError:
    print("Błąd połączenia z bazą danych.")
    exit()

from os import path

class MainScreen:
    
    def __init__(self):
        """
        Pola metody:
        self.p - połączenie z bazą danych
        self.upraw - uprawnienia (0 - użytkownik, 1 - admin)
        self.start - informacja czy turniej już wystartował (0 - nie, 1 - tak)
        self.login - login do systemu
        self.player - informacja czy jest jako zawodnik w systemie (0 - nie, 1 - tak)
        """
        
        self.p = polacz
        self.start = self.file_read(0)
        print("============================\n      FRISBEE CUP 2017\n============================")
        self.log_or_sign()
        #teraz jest sytuacja taka, że użytkownik jest zalogowany i może mieć uprawnienia administratora albo nie, i może być rozpoczęty turniej albo nie
        if(self.start == 0 and self.upraw == 0):
            self.new_player()
        elif(self.start == 0 and self.upraw == 1):
            print("Panel admina przed turniejem")
        elif(self.start == 1 and self.upraw == 0):
            print("Panel zawodnika po starcie turnieju")        
        elif(self.start == 1 and self.upraw == 1):
            print("Panel admina po starcie turnieju")
        #metody po kolei
        self.close()

    def file_read(self,parametr):
        if(path.isfile("proj_src/parametry.txt")):
            temp = open("proj_src/parametry.txt","r")
            #linijkę niżej można później wykasować
            print("Odczytanie pliku powiodło się.\n")
            par_val = int(temp.readlines()[int(parametr)][:4])
            temp.close()
            return par_val

        else:
            print("Błąd przy odczytywaniu pliku.")
            self.close()

    def log_or_sign(self):
        while True:
            logsign = input("Co chcesz zrobić?\n1. ZAREJESTROWAĆ SIĘ\n2. ZALOGOWAĆ SIĘ\n")
            print("")
            if(logsign == "1"):
                self.sign()
                break
            elif(logsign == "2"):
                self.log()
                break
            else:
                print("Spróbuj jeszcze raz!\n")

    def log(self):
        print("=== LOGOWANIE ===\n")
        
        while True:
            login = input("Podaj login:\n")
            print("")
            haslo = input("Podaj hasło:\n")
            print("")
            temp = self.p.cursor()
            temp.execute("SELECT pass FROM zawodnicy WHERE login='"+login+"';")
            haslo_check = temp.fetchall()
            if(len(haslo_check)>0 and haslo_check[0][0]==haslo):
                print("LOGOWANIE UDANE!\n")
                temp = self.p.cursor()
                temp.execute("SELECT uprawnienia FROM zawodnicy WHERE login='"+login+"';")
                upr_temp = temp.fetchall()
                self.upraw = upr_temp[0][0]
                self.login = login
                break
            else:
                tn = input("BŁĘDNY LOGIN LUB HASŁO!\n\nCzy chcesz spróbować jeszcze raz?\n1. TAK\n2. NIE\n")
                print("")
                if(tn!="1"):
                    self.close()

    def sign(self):
        print("=== REJESTRACJA ===\n")
        tekst=""

        while True:
            login = input("Wybierz "+tekst+"login:\n")
            print("")
            temp = self.p.cursor()
            temp.execute("SELECT login FROM zawodnicy WHERE login='"+login+"';")
            log_check = temp.fetchall()
            if(len(log_check)>0):
                print("TAKI LOGIN JUŻ ISTNIEJE!\n")
                tekst="inny "
            else:
                break

        tekst=""
        while True:
            haslo = input("Podaj "+tekst+"hasło:\n")
            print("")
            if(len(haslo)<3):
                print("Hasło powinno mieć przynajmniej 3 znaki!\n")
                tekst = "inne "
            else:
                break

        temp = self.p.cursor()
        temp.execute("INSERT INTO zawodnicy(login, pass) values ('"+login+"','"+haslo+"');")
        self.p.commit()
        print("REJESTRACJA POWIODŁA SIĘ!\nTERAZ MOŻESZ SIĘ ZALOGOWAĆ!\n")
        self.log()

    def new_player(self):
            temp = self.p.cursor()
            temp.execute("select((select imie from zawodnicy where login = '"+self.login+"') is not null);")
            player_check = temp.fetchall()
            self.player = int(player_check[0][0])
            print("============================\n      PANEL UŻYTKOWNIKA      \n============================")
            if(self.player==0):
                tn = input("Czy chcesz się zapisać na turniej?\n1. TAK\n2. NIE\n")
                print("")
                if(tn!="1"):
                    print("Turniej jeszcze nie wystartował. Po więcej informacji wróć później!")
                    self.close()

                imie = input("Podaj swoje imię:\n")
                print("")
                nazwisko = input("Podaj swoje nazwisko:\n")
                print("")

                while True:
                    plec = input("Podaj swoją płeć:\n1. KOBIETA\n2. MĘŻCZYZNA\n")
                    print("")
                    if(plec!="1" and plec !="2"):
                        print("Coś się nie powiodło, spróbuj jeszcze raz!\n")
                    else:
                        if(plec=="1"):
                            plec="K"
                        elif(plec=="2"):
                            plec="M"
                        break

                while True:
                    poziom = input("Jaki jest Twój poziom gry? (1-10):\n")
                    print("")
                    if(poziom.isdigit() and int(poziom)>=1 and int(poziom)<=10):
                        poziom=int(poziom)
                        break
                    else:
                        print("Coś się nie powiodło, spróbuj jeszcze raz!\n")

                while True:
                    pozycja = input("Na jakiej grasz pozycji?\n1. HANDLER\n2. CUTTER\n")
                    print("")
                    if(pozycja!="1" and pozycja !="2"):
                        print("Coś się nie powiodło, spróbuj jeszcze raz!\n")
                    else:
                        if(pozycja=="1"):
                            pozycja="handler"
                        elif(pozycja=="2"):
                            pozycja="cutter"
                        break

                while True:
                    menu = input("Jakie lubisz jedzonko?\n1. dania mięsne\n2. wegetariańskie\n")
                    print("")
                    if(menu!="1" and menu !="2"):
                        print("Coś się nie powiodło, spróbuj jeszcze raz!\n")
                    else:
                        if(menu=="1"):
                            menu="mięso"
                        elif(menu=="2"):
                            menu="wege"
                        break

                while True:
                    rozmiar = input("Jaki jest Twój rozmiar koszulki?\n1. XS\n2. S\n3. M\n4. L\n5. XL\n")
                    print("")
                    if(rozmiar.isdigit() and int(rozmiar)>=1 and int(rozmiar)<=5):
                        if(int(rozmiar)==1):
                            rozmiar="XS"
                        elif(int(rozmiar)==2):
                            rozmiar="S"
                        elif(int(rozmiar)==3):
                            rozmiar="M"
                        elif(int(rozmiar)==4):
                            rozmiar="L"
                        elif(int(rozmiar)==5):
                            rozmiar="XL"                        
                        break
                    else:
                        print("Coś się nie powiodło, spróbuj jeszcze raz!\n")

                print(imie, nazwisko, plec, poziom, pozycja, menu, rozmiar)

    def close(self):
        self.p.close()
        print("THE END")
        exit()



        

MainScreen()