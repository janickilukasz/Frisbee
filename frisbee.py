#-*- coding: utf-8 -*-
import pymysql
from proj_src.haslo import polacz

class MainScreen:
    def __init__(self):
        print("============================\n      FRISBEE CUP 2017\n============================")
        self.lang()
        self.log_or_sign()
        #metody po kolei
    
    def lang(self):
        while True:
            self.jez = input("Wybierz język/Choose your language:\n1. PL\n2. EN\n")
            if(self.jez == "1"):
                self.jez = "pl"
                print("Wybrałeś język polski\n")
                break
            elif(self.jez == "2"):
                self.jez = "en"
                print("You've chosen English\n")
                break
            else:
                print("\nSpróbuj jeszcze raz!/Try once again!\n")

    def log_or_sign(self):
        while True:
            if self.jez == "pl":
                tekst = "Co chcesz zrobić?\n1. ZAREJESTROWAĆ SIĘ\n2. ZALOGOWAĆ SIĘ\n"
            else:
                tekst = "What you gonna do?\n1. SIGN IN\n2. LOG IN\n"
            
            self.logsign = input(tekst)
            
            if(self.logsign == '1'):
                # TUTAJ REJESTRACJA
                print("rejestracja")
                break
            elif(self.logsign == '2'):
                # TUTAJ LOGOWANIE
                print("logowanie")
                break
            else:
                if self.jez == "pl":
                    tekst = "\nSpróbuj jeszcze raz!\n"
                else:
                    tekst = "\nTry once again!\n"
                print(tekst)

MainScreen()