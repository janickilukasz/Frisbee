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
        p - połączenie z bazą danych
        upraw - uprawnienia (0 - użytkownik, 1 - admin)
        start - informacja czy turniej już wystartował (0 - nie, 1 - tak)
        """
        
        self.p = polacz
        self.start = self.file_read(0)
        print("============================\n      FRISBEE CUP 2017\n============================")
        self.log_or_sign()
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
            temp.execute("SELECT pass FROM logpass WHERE login='"+login+"';")
            haslo_check = temp.fetchall()
            if(len(haslo_check)>0 and haslo_check[0][0]==haslo):
                print("LOGOWANIE UDANE!")
                temp = self.p.cursor()
                temp.execute("SELECT uprawnienia FROM logpass WHERE login='"+login+"';")
                upr_temp = temp.fetchall()
                self.upraw = upr_temp[0][0]
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
            temp.execute("SELECT login FROM logpass WHERE login='"+login+"';")
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
        temp.execute("INSERT INTO logpass(login, pass) values ('"+login+"','"+haslo+"');")
        self.p.commit()
        print("REJESTRACJA POWIODŁA SIĘ!\nTERAZ MOŻESZ SIĘ ZALOGOWAĆ!\n")
        self.log()

    def close(self):
        self.p.close()
        print("THE END")
        exit()



        

MainScreen()