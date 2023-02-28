#! /bin/bash

# Changelog
#------------
# v1.0 - basics of file reading
# v1.1 - added divider based on number of lines
# v1.2 - added date and counter as output file name
# v1.3 - optimalization of proccesses to improve speed
# v1.4 - added file counter and script timer
# v1.5 - added processing of second (error) column
# v1.6 - implemented menu and stated Gamry as function
#------------

DATE=$(date +%d-%m-%y)

#-----------
# MENU FUNCTION
#-----------

menu(){
echo -e "\e[0;33m  Zpracovat měření z programu: \e[0m"
echo -e "\e[32m   1) Gamry Framework\e[0m"
echo -e "\e[32m   2) Program #2\e[0m"
echo -e "\e[31m   3) Quit\e[0m"
echo -n -e "\e[0;33m  Vyberte program (napište pouze číslo): \e[0m"
	read a
	case $a in
		1) Gamry_Framework;;
		2) Program2;;
		3) exit;;
	esac
}

#-----------
# END OF MENU FUNCTION
#-----------
# SCRITPS AS FUNCTIONS
#-----------

Gamry_Framework(){
echo
echo -e "\e[0;33m Zpracovávám data z programu Gamry Framework..\e[0;33m"
echo
start=$(date +%s.%N)

for i in vstupni_soubory/*; do
echo -e "\e[0;31m  Čtu $i ..\e[0m"
sed -e '1,11d' "$i" | head -n -3 | awk '{$1=$2=$3=$4=$7=$8=""; print $0}' | awk '{$3=""; print $0}' > vystup_temp.txt
divider=$(wc <<< wc -w vystup_temp.txt | awk '{ print $1 }')
echo -e "\e[0;31m  Upravuji $i..\e[0m"
tr " " ";" < vystup_temp.txt | sed 's/;$//' | tr "\n" ";" | sed -e "s/;/\n/$divider" -e 'P;D' | sed 's/;$//' >> gamry_framework_${DATE}.txt
echo
done

name=gamry_framework_${DATE}
if [[ -e $name.txt || -L $name.txt ]]; then
	j=1
	while [[ -e $name-$j.txt || -L $name-$j.txt ]]; do
	let j++
	done
	jmeno=$name-$j
fi

mv gamry_framework_${DATE}.txt $jmeno.txt

echo -e "\e[0;33m Výsledný soubor: \e[0m"
echo
cat $jmeno.txt
echo
echo

pocet_souboru=$(ls vstupni_soubory/ | wc -l)
konec=$(date +%s.%N)
runtime=$(bc <<< "$konec - $start" | sed 's/.......$//')

echo -e "\e[0;33m Script ukončen. Zpracováno $pocet_souboru souborů za $runtime sekund.\e[0m"
echo -e "\e[0;33m   Vytvořen soubor: $jmeno.txt\e[0m"

rm vystup_temp.txt
}

Program2(){
echo NOT YET IMPLEMENTED
exit
echo
echo -e "\e[0;33m   Zpracovávám data z programu 2..\e[0m"
echo
start=$(date +%s.%N)

for i in vstupni_soubory/*; do
echo -e "\e[0;31m  Čtu $i ..\e[0m"
echo -e "\e[0;31m  Upravuji $i ..\e[0m"
echo

#------------
# UPRAVA SOUBORU  !!! DODĚLAT !!!
#------------

done

name=program2_${DATE}
if [[ -e $name.txt || -L $name.txt ]]; then
	j=1
	while [[ -e $name-$j.txt || -L $name-$j.txt ]]; do
	let j++
	done
	jmeno=$name-$j
fi

mv program2_${DATE}.txt $jmeno.txt

echo -e "\e[0;33m Výsledný soubor: \e[0m"
echo
cat $jmeno.txt
echo
echo

pocet_souboru=$(ls vstupni_soubory/ | wc -l)
konec=$(date +%s.%N)
runtime=$(bc <<< "$konec - $start" | sed 's/.......$//')

echo -e "\e[0;33m Script ukončen. Zpracováno $pocet_souboru souborů za $runtime sekund.\e[0m"
echo -e "\e[0;33m   Vytvořen soubor: $jmeno.txt\e[0m"

rm vystup_temp.txt
}

#-----------
# END OF SCRIPTS
#-----------

clear

echo
echo -e "\e[0;32m   #---------------------------------------------------------------------------------#\e[0m"
echo -e "\e[0;32m   #                    Made by Artee                                           v1.6 #\e[0m"
echo -e "\e[0;32m   #                                Všechna práva vyhlazena                          #\e[0m"
echo -e "\e[0;32m   #---------------------------------------------------------------------------------#\e[0m"
echo

menu

echo
echo -e "\e[0;32m   #---------------------------------------------------------------------------------#\e[0m"
echo -e "\e[0;32m   #                    Made by Artee                                           v1.6 #\e[0m"
echo -e "\e[0;32m   #                                Všechna práva vyhlazena                          #\e[0m"
echo -e "\e[0;32m   #---------------------------------------------------------------------------------#\e[0m"
echo

exit
