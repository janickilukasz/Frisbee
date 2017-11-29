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
        print("================================================\n               FRISBEE CUP 2017\n================================================")
        self.log_or_sign()
        #teraz jest sytuacja taka, że użytkownik jest zalogowany i może mieć uprawnienia administratora albo nie, i może być rozpoczęty turniej albo nie
        if(self.start == 0 and self.upraw == 0):
            self.player_before()
        elif(self.start == 0 and self.upraw == 1):
            self.admin_before()
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
        print("=================== LOGOWANIE ==================\n")
        
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
        print("================== REJESTRACJA =================\n")
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
                print("HASŁO POWINNO MIEĆ PRZYNAJMNIEJ 3 ZNAKI!\n")
                tekst = "inne "
            else:
                break

        temp = self.p.cursor()
        temp.execute("INSERT INTO zawodnicy(login, pass) values ('"+login+"','"+haslo+"');")
        self.p.commit()
        print("REJESTRACJA POWIODŁA SIĘ!\nTERAZ MOŻESZ SIĘ ZALOGOWAĆ!\n")
        self.log()

    def player_before(self):
        while True:
            temp = self.p.cursor()
            temp.execute("select((select imie from zawodnicy where login = '"+self.login+"') is not null);")
            player_check = temp.fetchall()
            self.player = int(player_check[0][0])
            if(self.player==0):
                tekst1 = "CHCĘ ZAPISAĆ SIĘ NA TURNIEJ!"
                temp_imie = ""
                temp_nazwisko = ""
                temp_plec = ""
                temp_poziom = ""
                temp_pozycja = ""
                temp_menu = ""
                temp_rozmiar = ""                 
            else:
                tekst1 = "CHCĘ ZAKTUALIZOWAĆ MOJE DANE"
                temp = self.p.cursor()
                temp.execute("SELECT imie, nazwisko, plec, poziom, pozycja, menu, rozmiar FROM zawodnicy WHERE login='"+self.login+"';")
                krotka = temp.fetchall()
                temp_imie = "Wcześniej wpisane imię to " + str(krotka[0][0])
                temp_nazwisko = "Wcześniej wpisane nazwisko to " + str(krotka[0][1])
                temp_plec = "Wcześniej podana płeć to " + str(krotka[0][2])
                temp_poziom = "Wcześniej podany poziom gry to " + str(krotka[0][3])
                temp_pozycja = "Wcześniej podana pozycja to " + str(krotka[0][4])
                temp_menu = "Wcześniej zadeklarowane posiłki to " + str(krotka[0][5])
                temp_rozmiar = "Wcześniej podany rozmiar koszulki to " + str(krotka[0][6])

            if(self.upraw==1):
                temp_opcja = "---------------------------------\n4. WRÓCIĆ DO PANELU ADMINISTRATORA\n---------------------------------\n"
            else:
                temp_opcja = ""

            print("================================================\n                  PANEL UŻYTKOWNIKA\n================================================")
            tn = input("Co chcesz zrobić?\n1. "+tekst1+"\n2. CHCĘ ZOBACZYĆ KTO JUŻ SIĘ ZAPISAŁ\n3. WŁAŚCIWIE TO NIC\n"+temp_opcja)
            print("")

            if(tn=="1"):
                print(temp_imie)
                imie = input("Podaj swoje imię:\n")
                print("")
                
                print(temp_nazwisko)
                nazwisko = input("Podaj swoje nazwisko:\n")
                print("")

                while True:
                    print(temp_plec)
                    plec = input("Podaj swoją płeć:\n1. KOBIETA\n2. MĘŻCZYZNA\n")
                    print("")
                    if(plec!="1" and plec !="2"):
                        print("COŚ SIĘ NIE POWIODŁO, SPRÓBUJ JESZCZE RAZ!\n")
                    else:
                        if(plec=="1"):
                            plec="K"
                        elif(plec=="2"):
                            plec="M"
                        break
    
                while True:
                    print(temp_poziom)
                    poziom = input("Jaki jest Twój poziom gry? (1-10):\n")
                    print("")
                    if(poziom.isdigit() and int(poziom)>=1 and int(poziom)<=10):
                        break
                    else:
                        print("COŚ SIĘ NIE POWIODŁO, SPRÓBUJ JESZCZE RAZ!\n")
    
                while True:
                    print(temp_pozycja)
                    pozycja = input("Na jakiej grasz pozycji?\n1. HANDLER\n2. CUTTER\n")
                    print("")
                    if(pozycja!="1" and pozycja !="2"):
                        print("COŚ SIĘ NIE POWIODŁO, SPRÓBUJ JESZCZE RAZ!\n")
                    else:
                        if(pozycja=="1"):
                            pozycja="handler"
                        elif(pozycja=="2"):
                            pozycja="cutter"
                        break
    
                while True:
                    print(temp_menu)
                    menu = input("Jakie lubisz jedzonko?\n1. dania mięsne\n2. wegetariańskie\n")
                    print("")
                    if(menu!="1" and menu !="2"):
                        print("COŚ SIĘ NIE POWIODŁO, SPRÓBUJ JESZCZE RAZ!\n")
                    else:
                        if(menu=="1"):
                            menu="mięso"
                        elif(menu=="2"):
                            menu="wege"
                        break
    
                while True:
                    print(temp_rozmiar)
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
                        print("COŚ SIĘ NIE POWIODŁO, SPRÓBUJ JESZCZE RAZ!\n")

                temp = self.p.cursor()
                temp.execute("UPDATE zawodnicy SET imie = '" + imie + "', nazwisko = '" + nazwisko + "', plec = '" + plec + "', poziom = " + poziom + ", pozycja = '"+pozycja+"', menu = '"+menu+"', rozmiar = '" + rozmiar + "' WHERE login = '" + self.login + "';")
                self.p.commit()

                if(self.player==0):
                    print(imie.upper() + ", REJESTRACJA NA TURNIEJ POWIODŁA SIĘ!\n")
                elif(self.player==1):
                    print(imie.upper() + ", ZMIANA DANYCH POWIODŁA SIĘ!\n")

            elif(tn=="2"):
                temp = self.p.cursor()
                temp.execute("SELECT imie, nazwisko, plec, poziom, pozycja FROM zawodnicy WHERE imie IS NOT NULL;")
                krotka = temp.fetchall()
                print("================= LISTA ZAPISANYCH ZAWODNIKÓW =================")
                print("%-5s|%-15s|%-15s|%-10s|%-10s|%-10s" % ('LP.','IMIĘ','NAZWISKO','PŁEĆ','POZIOM','POZYCJA'))
                print("---------------------------------------------------------------")
                licznik=0
                for i in krotka:
                    licznik = licznik + 1
                    print("%-5i|%-15s|%-15s|%-10s|%-10s|%-10s" % (licznik,i[0],i[1],i[2],i[3],i[4]))
                print("")

            elif(tn=="4" and self.upraw==1):
                break
            else:
                self.close()

    def admin_before(self):
        while True:
            print("================================================\n              PANEL ADMINISTRATORA\n================================================")
            tn = input("Co chcesz zrobić?\n------------------------------------------------\n1. ROZPOCZĄĆ TURNIEJ!\n------------------------------------------------\n2. ZOBACZYĆ SZCZEGÓŁOWĄ LISTĘ UŻYTKOWNIKÓW\n3. DODAĆ UPRAWNIENIA ADMINISTRATORA\n4. SPRAWDZIĆ STATYSTYKI ZAPISANYCH\n5. PRZEŁĄCZYĆ SIĘ NA PANEL ZAWODNIKA\n6. WŁAŚCIWIE TO NIC\n")
            print("")
            if(tn=="1"):
                #TUTAJ!!!
                print("Startujemy z turniejem!")
            elif(tn=="2"):
                temp = self.p.cursor()
                temp.execute("SELECT login, uprawnienia, imie, nazwisko, plec, poziom, pozycja, menu, rozmiar FROM zawodnicy;")
                krotka = temp.fetchall()
                print("=============================================== LISTA UŻYTKOWNIKÓW ==============================================")
                print("%-5s|%-15s|%-7s|%-15s|%-15s|%-10s|%-10s|%-10s|%-10s|%-10s" % ('LP.','LOGIN','ADMIN','IMIĘ','NAZWISKO','PŁEĆ','POZIOM','POZYCJA','MENU','ROZMIAR'))
                print("-----------------------------------------------------------------------------------------------------------------")
                licznik=0
                for i in krotka:
                    licznik = licznik + 1
                    print("%-5s|%-15s|%-7s|%-15s|%-15s|%-10s|%-10s|%-10s|%-10s|%-10s" % (licznik,i[0],i[1],i[2],i[3],i[4],i[5],i[6],i[7],i[8]))
                print("")
            elif(tn=="3"):
                login_adm = input("PODAJ LOGIN OSOBY, KTÓREJ CHCESZ NADAĆ UPRAWNIENIA ADMINA:\n")
                print("")
                temp = self.p.cursor()
                temp.execute("SELECT((SELECT login FROM zawodnicy WHERE login = '"+login_adm+"') is not null);")
                krotka = temp.fetchall()
                if(int(krotka[0][0])==1):
                    temp = self.p.cursor()
                    temp.execute("SELECT uprawnienia FROM zawodnicy WHERE login = '"+login_adm+"';")
                    krotka = temp.fetchall()
                    if(int(krotka[0][0])==0):
                        temp = self.p.cursor()
                        temp.execute("UPDATE zawodnicy SET uprawnienia = true WHERE login = '"+login_adm+"';")
                        self.p.commit()
                        print("UŻYTKOWNIKOWI " + login_adm + " NADANO UPRAWNIENIA ADMINISTRATORA\n")
                    else:
                        print("TEN UŻYTKOWNIK JUŻ MA UPRAWNIENIA ADMINISTRATORA!\n")
                else:
                    print("TAKI LOGIN NIE ISTNIEJE!\n")

            elif(tn=="4"):
                print("================== STATYSTYKI ==================")
                temp = self.p.cursor()
                temp.execute("SELECT count(*) FROM zawodnicy ")
                krotka = temp.fetchall()
                print("%-30s%-3s" % ("Ilość użytkowników: ",str(krotka[0][0])))

                temp = self.p.cursor()
                temp.execute("SELECT count(*) FROM zawodnicy WHERE imie IS NOT NULL")
                krotka = temp.fetchall()
                suma_zaw = krotka[0][0]
                print("%-30s%-3s" % ("Ilość zapisanych zawodników: ",str(suma_zaw)))
                
                temp = self.p.cursor()
                temp.execute("SELECT count(*) FROM zawodnicy WHERE imie IS NOT NULL AND plec = 'K'")
                krotka_k = temp.fetchall()
                suma_k = krotka_k[0][0]
                print("%-30s%-3s%-9s%-3s%-3s" % ("         |-- kobiet:", str(suma_k), "   ---", str(round((suma_k/suma_zaw)*100)), "%"))
                
                temp = self.p.cursor()
                temp.execute("SELECT count(*) FROM zawodnicy WHERE imie IS NOT NULL AND plec = 'M'")
                krotka_m = temp.fetchall()
                suma_m = krotka_m[0][0]
                print("%-30s%-3s%-9s%-3s%-3s" % ("         |-- mężczyzn:", str(suma_m), "   ---", str(round((suma_m/suma_zaw)*100)), "%"))              
                
                print("         ---------------------------------------")
                
                temp = self.p.cursor()
                temp.execute("SELECT count(*) FROM zawodnicy WHERE imie IS NOT NULL AND pozycja = 'handler'")
                krotka_h = temp.fetchall()
                suma_h = krotka_h[0][0]
                print("%-30s%-3s%-9s%-3s%-3s" % ("         |-- handlerów:", str(suma_h), "   ---", str(round((suma_h/suma_zaw)*100)), "%"))                
                
                temp = self.p.cursor()
                temp.execute("SELECT count(*) FROM zawodnicy WHERE imie IS NOT NULL AND pozycja = 'cutter'")
                krotka_c = temp.fetchall()
                suma_c = krotka_c[0][0]
                print("%-30s%-3s%-9s%-3s%-3s" % ("         |-- cutterów:", str(suma_c), "   ---", str(round((suma_c/suma_zaw)*100)), "%"))                
                
                print("         ---------------------------------------")
                
                for i in range(1,11):
                    temp = self.p.cursor()
                    temp.execute("SELECT count(*) FROM zawodnicy WHERE imie IS NOT NULL AND poziom = " + str(i))
                    krotka = temp.fetchall()
                    ilosc = krotka[0][0]
                    print("%-30s%-3s%-9s%-3s%-3s" % ("         |-- na poziomie "+str(i)+":", str(ilosc), "   ---", str(round((ilosc/suma_zaw)*100)), "%"))                 
                ile_druz = round(suma_zaw/15)
                temp = self.p.cursor()
                temp.execute("SELECT DISTINCT ilosc_druz FROM systemy;")
                krotka = temp.fetchall()
                naj = 100
                licznik = 0
                for i in krotka:
                    rozn = abs(ile_druz-i[0])
                    if(rozn<naj):
                        naj = rozn
                        best_krotka = licznik
                    licznik = licznik + 1
                tekst1 = ""
                if(best_krotka!=0):
                    tekst1 = str(krotka[best_krotka-1][0]) + ", "
                tekst2 = str(krotka[best_krotka][0])
                tekst3 = ""
                if(best_krotka!=len(krotka)-1):
                    tekst3 = ", " + str(krotka[best_krotka+1][0])
                print("\nZalecane ilości drużyn: " + tekst1 + tekst2 + tekst3)
                print("")
            elif(tn=="5"):
                self.player_before()
            else:
                self.close()

    def close(self):
        self.p.close()
        print("================================================\n         DZIĘKUJEMY I ZAPRASZAMY PONOWNIE!\n================================================")
        exit()



        

MainScreen()