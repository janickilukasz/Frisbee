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
        if self.start == 0:
            if self.upraw == 0:
                self.player_before()
            elif self.upraw == 1:
                self.admin_before()
        if self.start == 1:
            self.menu_after()
        self.close()

    def file_read(self,parametr):
        if(path.isfile("proj_src/parametry.txt")):
            temp = open("proj_src/parametry.txt","r")
            par_val = int(temp.readlines()[int(parametr)][:4])
            temp.close()
            return par_val
        else:
            print("Błąd przy odczytywaniu pliku.")
            self.close()

    def file_write(self,parametr,value):
        temp = open("proj_src/parametry.txt","r")
        czytanko = temp.readlines()
        czytanko[parametr] = value+"\n"
        temp.close()
        
        temp = open("proj_src/parametry.txt","w")
        temp.writelines(czytanko)
        temp.close()        
        #Tutaj już nie sprawdzam czy plik istnieje, bo zostało to sprawdzone w metodzie file_read
        #temp = open("proj_src/parametry.txt","w")
        #temp.seek(4*parametr)
        #temp.writelines(["\n"+value])
        #temp.close()

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

    def is_player(self):
        temp = self.p.cursor()
        temp.execute("select((select imie from zawodnicy where login = '"+self.login+"') is not null);")
        player_check = temp.fetchall()
        self.player = int(player_check[0][0])        

    def player_before(self):
        self.is_player()
        while True:
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
                self.who_play()

            elif(tn=="4" and self.upraw==1):
                break
            else:
                self.close()

#Metoda poniżej zwraca info na temat wszystkich zawodników jeżeli nie poda się żadnych argumentów, a jeśli parametr team_only będzie równy 1 wtedy zwróci zawodników tylko z drużyny team_id
    def who_play(self, team_only=0, team_id=0):
        naglowek = "================== LISTA ZAPISANYCH ZAWODNIKÓW ================"
        tekst = ""
        if team_only==1:
            temp = self.p.cursor()
            temp.execute("SELECT nazwa, kolor FROM druzyny WHERE id = " + str(team_id) + ";")
            krotka = temp.fetchall()
            nazwa = krotka[0][0]
            kolor = krotka[0][1]
            naglowek2 = " "+ nazwa.upper() + " (kolor " + kolor.lower() + ") "
            ile_suma = len(naglowek) - len(naglowek2)
            strona = int(ile_suma/2)
            naglowek = "=" * (strona+ile_suma%2) + naglowek2 + "=" * strona
            tekst = " AND druzyna = " + str(team_id)
        temp = self.p.cursor()
        temp.execute("SELECT imie, nazwisko, plec, poziom, pozycja FROM zawodnicy WHERE imie IS NOT NULL" + tekst + " ORDER BY nazwisko;")
        krotka = temp.fetchall()
        print(naglowek)
        print("%-5s|%-15s|%-15s|%-6s|%-8s|%-9s" % (' LP.','      IMIĘ','    NAZWISKO',' PŁEĆ',' POZIOM',' POZYCJA'))
        print("---------------------------------------------------------------")
        licznik=0
        for i in krotka:
            licznik = licznik + 1
            print("%-5s|%-15s|%-15s|%-6s|%-8s|%-9s" % (" " + str(licznik)," "+i[0]," "+i[1],"  "+i[2],"   "+str(i[3])," "+i[4]))
        print("")
    
    def admin_before(self):
        uciekacz_zewnetrzny = 0
        while uciekacz_zewnetrzny == 0:
            print("================================================\n              PANEL ADMINISTRATORA\n================================================")
            tn = input("Co chcesz zrobić?\n------------------------------------------------\n1. ROZPOCZĄĆ TURNIEJ!\n------------------------------------------------\n2. ZOBACZYĆ SZCZEGÓŁOWĄ LISTĘ UŻYTKOWNIKÓW\n3. DODAĆ UPRAWNIENIA ADMINISTRATORA\n4. SPRAWDZIĆ STATYSTYKI ZAPISANYCH\n5. PRZEŁĄCZYĆ SIĘ NA PANEL ZAWODNIKA\n6. WŁAŚCIWIE TO NIC\n")
            print("")
            if(tn=="1"):
                print("================================================\n               USTAWIENIA TURNIEJU\n================================================")
                temp = self.p.cursor()
                temp.execute("SELECT count(*) FROM zawodnicy WHERE imie IS NOT NULL")
                krotka = temp.fetchall()
                suma_zaw = krotka[0][0]
                propozycje = self.team_vol(suma_zaw,2)
                print("Na turniej zapisanych jest " + str(suma_zaw) + " zawodników.\nProponowane ilości drużyn:")
                for i in propozycje:
                    dodatek = ""
                    if i<10:
                        dodatek = " "
                    if i<5:
                        dodatek = "y"
                    print("  "+str(i), end=" drużyn" + dodatek + "  -  zawodników w drużynie: "+ str(round(suma_zaw/i)) +"\n")
                uciekacz = 0
                while uciekacz == 0:
                    decyzja = input("Ile chcesz stworzyć drużyn?\n")
                    print("")
                    if (decyzja.isdigit() and (int(decyzja) in propozycje)):
                        temp = self.p.cursor()
                        temp.execute("SELECT count(*) FROM systemy WHERE ilosc_druz = " + str(decyzja) + ";")
                        krotka = temp.fetchall()
                        ile_sys = krotka[0][0]
                        
                        temp = self.p.cursor()
                        temp.execute("SELECT * FROM systemy WHERE ilosc_druz = " + str(decyzja) + ";")
                        krotka = temp.fetchall()
                        
                        if ile_sys>1:
                            print("Proponowane systemy rozgrywek:")
                        elif ile_sys==1:
                            print("Wybrano ten system:")
                        print("---------------------------------------------------------------")
                        print("Nr | Ilość | Ilość drużyn | Ćwierćfinały | Półfinały | Rewanże ")
                        print("   | grup  |   w grupie   |              |           |         ")
                        print("---------------------------------------------------------------")
                        licznik = 0
                        for i in krotka:
                            licznik = licznik + 1
                            print("%-3i|   %-3i |      %-3i     |     %-3i      |     %-3i   |    %-3i  " % (licznik, i[2],int(decyzja)/i[2],i[3],i[4],i[5]))                        
                        print("---------------------------------------------------------------\n")
                        while True:
                            wybrany = 0
                            if ile_sys>1:
                                odpowiedz = input("Jaki system wybierasz?\n")
                                print("")
                                if ile_sys>1 and odpowiedz.isdigit() and int(odpowiedz)>0 and int(odpowiedz)<=ile_sys:
                                    print("WYBRANO SYSTEM!")
                                    wybrany = int(odpowiedz)
                                else:
                                    print("Coś jest nie tak")
                            if ile_sys==1 or wybrany > 0:
                                odpowiedz = input("CZY ZATWIERDZASZ TEN SYSTEM? (T/N)\n")
                                print("")
                                if odpowiedz.upper()=="T":
                                    if ile_sys==1:
                                        system_gry = krotka[0][0]
                                    elif ile_sys>1:
                                        system_gry = krotka[wybrany-1][0]
                #======================= TUTAJ JEST WYBÓR SYSTEMU ROZGRYWEK !!! ===========================
                                    print("ZATWIERDZONO SYSTEM!\n")
                                    self.team_insert(decyzja)#wpisywanie drużyn
                                    self.file_write(2,"%04i" % (int(decyzja)))#zmiana parametru DRUŻYNY
                                    self.player_shuffle(decyzja)#losowanie zawodników do drużyn
                                    #przydzielenie do grup
                                    temp = self.p.cursor()
                                    temp.execute("update druzyny set grupa = ceil((id/"+decyzja+")*(select ilosc_gr from systemy where id="+str(system_gry)+"));")
                                    self.p.commit()
                                    #tworzenie meczów
                                    temp = self.p.cursor()
                                    temp.execute("SELECT rewanze FROM systemy WHERE id = "+str(system_gry)+";")
                                    krotka = temp.fetchall()
                                    rewanze = krotka[0][0]#to jest int(1 albo 0)
                                    
                                    temp = self.p.cursor()
                                    temp.execute("INSERT INTO mecze(faza, kto_id, z_kim_id) SELECT 'Faza grupowa', a.id, b.id from druzyny as a join druzyny as b where case when "+str(rewanze)+" then a.id!=b.id else a.id>b.id end and a.grupa=b.grupa;")                                    
                                    self.p.commit()
                                    
                                    self.file_write(0,"0001")#zmiana parametru START
                                    self.file_write(1,"%04i" % (system_gry))#zmiana parametru SYSTEM
                                    
                                    self.start = 1
                                    uciekacz = 1
                                    uciekacz_zewnetrzny = 1
                                    break
                                else:
                                    print("NIE WYBRANO SYSTEMU ROZGRYWEK\nTURNIEJ NIE JEST ROZPOCZĘTY!\n")
                                    uciekacz = 1
                                    break                            
                                
            
                    else:
                        print("NIE MOŻNA WYBRAĆ TAKIEJ ILOŚCI DRUŻYN!\n")
                
            elif(tn=="2"):
                self.who_use()

            elif(tn=="3"):
                self.admin_plus()

            elif(tn=="4"):
                self.stats()

            elif(tn=="5"):
                self.player_before()
            else:
                self.close()
    
    def who_use(self):
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
    
    def admin_plus(self):
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
    
    def stats(self):
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
        wynik = self.team_vol(suma_zaw,1)
        print("")
        if self.start==0 :
            print("Proponowana ilość drużyn:     " + str(wynik)[1:-1] + "\n")
    
    #funkcja zwraca krotkę z polecanymi ilościami drużyn w zależności od zadanych parametrów: players - ilość zawodników, spread - rozrzut wyników (max 2 w góre i w dół)
    def team_vol(self,players,spread):
        ile_druz = round(players/15)
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
        wynik = ()
        if(best_krotka>1 and spread>1):
            wynik+=krotka[best_krotka-2]
        if(best_krotka>0 and spread>0):
            wynik+=krotka[best_krotka-1] 
        wynik+=krotka[best_krotka]
        if((best_krotka<len(krotka)-1) and spread>0):
            wynik+=krotka[best_krotka+1]
        if((best_krotka<len(krotka)-2) and spread>1):
            wynik+=krotka[best_krotka+2] 
        return wynik

    def team_insert(self,ile):
        for i in range(int(ile)):
            n = input("Podaj nazwę drużyny nr " + str(int(i)+1) + ":\n")
            print("")
            k = input("Podaj kolor koszulek drużyny nr " + str(int(i)+1) + ":\n")
            print("")            
            temp = self.p.cursor()
            temp.execute("INSERT INTO druzyny(nazwa, kolor) VALUES ('"+n+"','"+k+"');")
            self.p.commit()
            
    def player_shuffle(self,teams):
        temp = self.p.cursor()
        temp.execute("SELECT id FROM zawodnicy ORDER BY poziom DESC")
        wszyscy = temp.fetchall()
        druzyn = self.file_read(2)
        for i in range(druzyn):
            krotka_temp = ()
            for j in wszyscy[i::druzyn]:
                krotka_temp+=(j[0],)
            temp = self.p.cursor()
            temp.execute("UPDATE zawodnicy SET druzyna = "+str(i+1)+" WHERE id IN "+ str(krotka_temp) + ";")            
        self.p.commit()

    def menu_after(self):
        self.is_player()
        if self.upraw== 1:
            tekst1 = "ADMINISTRATORA"
            tekst2 = "------------------------------------------------\n5. ZOBACZYĆ ILE POTRZEBA KOSZULEK\n6. ZOBACZYĆ ILE POTRZEBA OBIADÓW\n7. WPISAĆ WYNIK MECZU\n8. DODAĆ UPRAWNIENIA ADMINISTRATORA\n9. ZOBACZYĆ SZCZEGÓŁOWĄ LISTĘ UŻYTKOWNIKÓW\n10. SPRAWDZIĆ STATYSTYKI ZAPISANYCH\n"
            if self.player == 1:
                tekst3 = "11. ZOBACZYĆ MOJE MECZE\n12"
            else:
                tekst3 = "11"
        else:
            tekst1 = "UŻYTKOWNIKA"
            tekst2 = ""
            if self.player == 1:
                tekst3 = "5. ZOBACZYĆ MOJE MECZE\n6"
            else:
                tekst3 = "5"
        while True:
            print("================================================\n                PANEL " + tekst1 + "\n================================================")
            tn = input("Co chcesz zrobić?\n1. ZOBACZYĆ WYNIKI MECZÓW\n2. ZOBACZYĆ GRUPY\n3. ZOBACZYĆ DRUŻYNY\n4. ZOBACZYĆ WSZYSTKICH ZAPISANYCH\n" + tekst2 + tekst3 + ". WŁAŚCIWIE TO NIC\n")
            print("")
            if tn=="1":
                self.matches()
            elif tn=="2":
                temp = self.p.cursor()
                temp.execute("SELECT DISTINCT grupa FROM druzyny;")
                krotka = temp.fetchall() 
                print("KTÓRĄ GRUPĘ CHCESZ OBEJRZEĆ?")
                licznik = 0
                for i in krotka:
                    licznik+=1
                    print(str(licznik) + ". GRUPA NR " + str(i[0]))
                odp=input("")
                print("")
                if odp.isdigit() and (int(odp),) in krotka:
                    self.groups(odp)
                else:
                    print("COŚ ŹLE WPISAŁEŚ!\n")
            elif tn=="3":
                temp = self.p.cursor()
                temp.execute("SELECT id, nazwa, kolor, grupa FROM druzyny;")
                krotka = temp.fetchall()
                print("SKŁAD KTÓREJ DRUŻYNY CHCESZ OBEJRZEĆ?")
                for i in krotka:
                    print("%3i. %s (kolor %s)" % (i[0],i[1].upper(),i[2].lower()))  
                odp = input("")
                print("")
                if odp.isdigit() and int(odp)>0 and int(odp)<=len(krotka): 
                    self.who_play(1,odp)
            elif tn=="4":
                self.who_play()
            elif ((tn=="5" and self.upraw==0) or (tn=="11" and self.upraw == 1)) and self.player == 1:
                self.matches(1)
            elif self.upraw==1:
                if tn=="5":
                    self.shirt_stats()
                elif tn=="6":
                    self.menu_stats()
                elif tn=="7":
                    self.matches_to_be()
                elif tn=="8":
                    self.admin_plus()
                elif tn=="9":
                    self.who_use()
                elif tn=="10":
                    self.stats()
                else:
                    self.close()
            else:
                self.close()

    def matches(self, mine=0):
        tekst = ""
        if mine==1:
            temp = self.p.cursor()
            temp.execute("SELECT id FROM zawodnicy WHERE login='"+self.login+"';")
            krotka = temp.fetchall()
            ajdi = krotka[0][0]
            tekst=" join zawodnicy as z on (z.druzyna=kto_id or z.druzyna=z_kim_id) where z.id = " + str(ajdi)
        temp = self.p.cursor()
        temp.execute("select faza, case when faza = 'Faza grupowa' then d1.grupa else '-' end As Grupa, d1.nazwa As Drużyna1, d2.nazwa As Drużyna2, coalesce(concat(kto_pkt,':',z_kim_pkt),'- : -') as Wynik from mecze join druzyny as d1 on kto_id=d1.id join druzyny as d2 on z_kim_id=d2.id"+tekst+";")
        meczyki = temp.fetchall()
        print("%-14s|%-7s|%-15s|%-15s|%-7s" % ("     FAZA"," GRUPA","   DRUŻYNA 1","   DRUŻYNA 2"," WYNIK"))
        print("--------------------------------------------------------------")
        for i in meczyki:
            print("%-14s|%-7s|%-15s|%-15s|%-7s" % (" "+i[0],"   "+i[1]," "+i[2]," "+i[3]," "+i[4]))
        print("\n")
    
    def groups(self, nr):
        temp = self.p.cursor()
        temp.execute("SELECT nazwa as Drużyna, mecze as Mecze, zwyc As Zwycięstwa, porazka As Porażki, male_pkt_plus As 'Punkty zdobyte', male_pkt_minus As 'Punkty stracone', roznica_pkt As 'Różnica punktowa', awans As Awans from druzyny where grupa="+str(nr)+" order by zwyc desc, roznica_pkt desc;")
        krotka = temp.fetchall()
        licznik = 0
        print("=========================== GRUPA "+str(nr)+" ===========================")
        print("%2s  %-14s%-7s%-7s%-7s | %-7s%-8s%3s" % ("","","Mecz.","Zwyc.","Prz.","Pkt+","Pkt-","Różn."))
        for i in krotka:
            licznik+=1
            print("%2i. %-15s%-7i%-7i%-7i|  %-7i%-7i%3i" % (licznik,i[0].upper(),i[1],i[2],i[3],i[4],i[5],i[6]))
        print("")
    
    def matches_to_be(self):
        temp = self.p.cursor()
        temp.execute("SELECT mecze.id, d1.nazwa As Drużyna1, d2.nazwa As Drużyna2 FROM mecze JOIN druzyny AS d1 ON kto_id=d1.id JOIN druzyny AS d2 ON z_kim_id=d2.id WHERE kto_pkt IS NULL ORDER BY mecze.id;")
        meczyki = temp.fetchall()
        licznik = 0
        print("WYBIERZ NUMER MECZU, KTÓREGO WYNIK CHCESZ WPISAĆ:\n")
        print("%3s. %-15s   %-15s" % ("NR","DRUŻYNA 1","DRUŻYNA 2"))
        print("----------------------------------")
        for i in meczyki:
            licznik +=1
            print("%3s. %-15s-  %-15s" % (licznik,i[1],i[2]))
        odp = input("")
        print("")
        if odp.isdigit() and int(odp)>0 and int(odp)<=len(meczyki):
            id_meczu = meczyki[int(odp)-1][0]
            kto = meczyki[int(odp)-1][1]
            zkim = meczyki[int(odp)-1][2]
            kto_pkt = input("ILE PUNKTÓW ZDOBYŁA DRUŻYNA " + kto.upper() + "?\n")
            print("")
            zkim_pkt = input("ILE PUNKTÓW ZDOBYŁA DRUŻYNA " + zkim.upper() + "?\n")
            print("")
            if kto_pkt.isdigit() and zkim_pkt.isdigit() and ((int(kto_pkt)==15 and int(zkim_pkt)<15 and int(zkim_pkt)>=0) or (int(kto_pkt)<15 and int(zkim_pkt)==15 and int(kto_pkt)>=0)):
                temp = self.p.cursor()
                temp.execute("UPDATE mecze SET kto_pkt = "+kto_pkt+", z_kim_pkt = "+zkim_pkt+" where id = "+str(id_meczu)+";")
                self.p.commit()
                print("WPROWADZONO WYNIK MECZU!\n")
                if(len(meczyki)==1):
                    self.promotion()
            else:
                print("PODAŁEŚ NIEPOPRAWNY WYNIK. GRA TOCZY SIĘ DO 15 PUNKTÓW!\n")
        else:
            print("COŚ ŹLE PODAŁEŚ!\n")

    def promotion(self):
        #Ta metoda pozwala na awans po zakończeniu fazy grupowej.
        #ile_awansuje - łączna ilość drużyn awansujących
        #ile_grup - ile było grup
        #ile_bezp - ile drużyn w jednej grupie na pewno awansuje dalej
        #ile_dodat - ile drużyn poza tym awansuje (z tabeli zbiorczej)
        #awans : 1 - do ćwierćfinałów, 2 - do półfinałów, 3 - do finału
        id_sys = self.file_read(1)
        temp = self.p.cursor()
        temp.execute("SELECT cwierc, pol, ilosc_gr FROM systemy WHERE id = " + str(id_sys) + ";")
        krotka = temp.fetchall()#w środku są inty
        if(krotka[0][0]==1):
            ile_awansuje = 8
            awans = 1
        elif(krotka[0][1]==1):
            ile_awansuje = 4
            awans = 2
        else:
            ile_awansuje = 2
            awans = 3
        ile_grup = krotka[0][2]
        ile_bezp = int(ile_awansuje/ile_grup)
        ile_dodat = ile_awansuje%ile_grup
        #Wstawianie awansu drużynom z pierwszych miejsc
        for i in range(1,ile_grup+1):
            temp = self.p.cursor()
            temp.execute("UPDATE druzyny join (SELECT max(punkty) as b from druzyny where grupa="+str(i)+") as tab on punkty=b set awans = "+str(awans)+";")
            self.p.commit()
        #Wstawianie awansu drużynom z drugich miejsc
        if ile_bezp>1:
            for i in range(1,ile_grup+1):
                temp = self.p.cursor()
                temp.execute("UPDATE druzyny join (SELECT max(punkty) as b from druzyny where grupa="+str(i)+" and punkty<(SELECT max(punkty) from druzyny where grupa="+str(i)+")) as tab on punkty=b SET awans = "+str(awans)+";")
                self.p.commit()
        #Wstawianie awansu drużynom dodatkowym
        if ile_dodat>0:
            for i in range(ile_dodat):
                    temp = self.p.cursor()
                    temp.execute("UPDATE druzyny join (SELECT max(punkty) as b from druzyny where awans = 0) as tab on b = punkty SET awans = "+str(awans)+";")
                    self.p.commit()
        #TUTAJ TERAZ!!! Trzeba zrobić wprowadzenie meczów po fazie grupowej i zastanowić się jak to rozegrać z półfinałami i finałami

    def menu_stats(self):
        temp = self.p.cursor()
        temp.execute("SELECT menu, count(*) As ile FROM zawodnicy WHERE menu IS NOT NULL GROUP by menu;")
        obiadki = temp.fetchall()
        print(" --------------------- ")
        print("|%-10s|%-10s|" % ("  MENU","  ILOŚĆ"))
        print("|----------|----------|")
        for i in obiadki:
            print("|%10s|%10s|" % (i[0]+"   ",str(i[1])+"   "))
        print(" --------------------- \n")

    def shirt_stats(self):
        temp = self.p.cursor()
        temp.execute("SELECT kolor, rozmiar, count(*) As ile FROM druzyny JOIN zawodnicy ON druzyny.id = zawodnicy.druzyna WHERE rozmiar IS NOT NULL GROUP BY kolor, rozmiar ORDER BY kolor;")
        koszulki = temp.fetchall()
        print("|%-15s|%-9s|%7s|" % (" KOLOR"," ROZMIAR", " ILOŚĆ"))
        print("-----------------------------------")
        for i in koszulki:
            print("|%-15s|%-9s|%7s|" % (" "+i[0],"   " + str(i[1]),str(i[2])+"   "))
        print("")
    def close(self):
        self.p.close()
        print("================================================\n         DZIĘKUJEMY I ZAPRASZAMY PONOWNIE!\n================================================")
        exit()



        

MainScreen()