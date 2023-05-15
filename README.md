Radu Andrei-Laurentiu 312CC Tema 2 PCLP2

Task-1 Criptarea unui string prin shiftarea caracterelor

Pacurgem fiecare caracter din string si adaugam step-ul.
In cazul in care trecem de litera 'Z' scadem numarul de litere din
alfabet.

Task-2 Este impartit in 2 functii: una pentru sortarea proceselor prin compararea campurilor si una pentru determinarea time-ului mediu al proceselor cu aceeasi prioritate pentru fiecare prioritate

Pentru sortare am folosit selection sort pornind de la final.
Pentru determinarea timeului mediu am parcurs vectorul de procese de la final si pentru fiecare element cu prioritatea x am incrementat
prio_result[x] si am adaugat valoarea din campul time in 
time_result[x]. Prio_result este utilizat ca un vector de frecventa. Apoi retinem in avg[x] restul si catul impartirii lui time_result[x] la prio_result[x]. 

Task-4 Primind pozitia unei dame intr-o matrice 8 x 8 trebuie sa marcam pozitiile in care se poate deplasa

Impartim problema in 5 cazuri mari cu alte 4 particulare pentru colturi. Primele 4 cazuri sunt reprezentate de ramele matricei, cazuri in care dama se poate deplasa in 2 pozitii sau 1 pozitie (in cazul unui colt). Cazul 5 este cel in care dama nu se afla pe rama, avand 4 posibilitati de deplasare.

Bonus: Optimizare task-4, matricea este retinuta prin bitii a doua numere intregi.

Punem intr-un registru valoarea 00000101 ce reprezinta 2 pozitii de pe diagonala pozitiei damei. Shiftam cu nr_coloanei - 1 pozitii pentru a afla 
