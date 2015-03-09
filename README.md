Skripta za slanje platnih listi na mail.
--

OPIS:
Skripta u LDAP imeniku pronalazi E-mail zaposlenika temeljem podataka o OIB-u iz PDF-a s platnom listom,
nakon cega taj PDF salje na pronadjeni E-mail.



Preduvjeti:
1. bash shell
2. mutt za slanje maila
3. ldap-utils
4. pdftk
5. masina na kojoj se pokrece mora imati mogucnost slanja maila preko mail.irb.hr
5. masina na kojoj se pokrece mora imati anoniman pristup LDAP imeniku

Priprema:
1. u poddirektorij PDF ubaciti platne liste u PDF formatu - svaka lista u posebnoj datoteci:
	- ako je potrebno razlomiti skupni PDF:
	# pdftk SVE_LISTE.pdf burst

Pokretanje:
1. pokrenuti send.sh
2. opcionalno preusmjeriti output u neki fajl
	# ./send.sh > slanje.log
