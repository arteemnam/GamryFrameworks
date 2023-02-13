# Changelog
#------------
# v1.0 - implemented menu and stated Gamry as function
# v1.1 - added file counter and script timer
# v1.2 - added date and counter as exported file name
# v1.3 - added file transformation and export
#------------

import datetime
import time
import os 
import sys
import pandas as pd
import shutil
from termcolor import colored

#-----------
# MENU FUNCTION
#-----------

def menu():
    print(colored("Zpracovat měření z programu: ", "yellow"))
    print(colored(" 1) Gamry Framework", "green"))
    print(colored(" 2) Program #2", "green"))
    print(colored(" 3) Quit", "red"))
    prompt = colored("   Vyberte program (napište pouze číslo): ", "yellow")
    option = int(input(prompt))
    if option == 1:
        Gamry_Framework()
    elif option == 2:
        # Možnost přidat další programy
        print("Aktuálně neimplementováno..")
        time.sleep(1)
        menu()
    elif option == 3:
        exit()
    else:
        print("")
        print("Error 1: Invalid option selected")
        print("")

#-----------
# END OF MENU FUNCTION
#-----------
# PROGRAM TRANSFORMATIONS AS FUNCTIONS
#-----------

def Gamry_Framework():
    print("")
    print(colored("Zpracovávám data z programu Gamry Framework..", "yellow"))
    print("")

    # Script start time
    start = time.time()

    # Folder and file path
    if getattr(sys, 'frozen', False):
        current_dir = os.path.dirname(sys.executable)
    elif __file__:
        current_dir = os.path.dirname(__file__)

    folder_path = os.path.join(current_dir, "vstupni_soubory")

    # Finished file name with counter
    date = datetime.datetime.now()
    counter = 1
    output_file = f"gamry_framework_{date.day}-{date.month}-{date.year}-{counter}.txt"
    while os.path.exists(os.path.join(current_dir, output_file)):
        counter += 1
        output_file = f"gamry_framework_{date.day}-{date.month}-{date.year}-{counter}.txt"

    # File manipulation
    with open(output_file, 'w') as outfile:
        for filename in os.listdir(folder_path):
            with open(folder_path + '/' + filename) as infile:
                print(colored(f"Čtu {filename}..", "red"))
                lines = infile.readlines()
                # Removing first 11 lines (header)
                lines = lines[11:]
                # Removing last 3 lines (footer)
                lines = lines[:-3]
                # Remove first 4 columns
                lines = [line.split(None, 4)[-1] for line in lines]
                # Adding delimiter between the first two columns
                lines = [";".join(line.split()[:2]) + ' ' + ' '.join(line.split()[2:]) for line in lines]
                # Adding a delimiter after the second column
                lines = [line.replace(' ', ";",1) for line in lines]
                # Replacing decimal "." with decimal ","
                lines = [line.replace('.', ',') for line in lines]
                # Writing into the output file
                print(colored(f"Upravuji {filename}..", "red"))
                print("")
                outfile.write("".join(lines)+"\n")

    # File export
    shutil.move(output_file, os.path.join(current_dir, output_file))

    # Printing out the finished file
    print(colored("Výsledný soubor:", "yellow"))
    print("")
    with open(os.path.join(current_dir, output_file), "r") as file:
        contents = file.read()
        print(contents)

    # Finishing statistics about script runtime and number of files processed
    pocet_souboru = len(os.listdir(folder_path))
    runtime = round((time.time()-start), 2)
    print(colored(f"Zpracováno {pocet_souboru} souborů za {runtime} sekund.", "yellow"))
    print(colored(f"   Vytvořen soubor {output_file}", "yellow"))
    print("")

#-----------
# END OF SCRIPTS
#-----------

os.system('cls')

print(colored("#---------------------------------------------------------------------------------#", "green"))
print(colored("#                    Made by Artee                                           v1.3 #", "green"))
print(colored("#                                Všechna práva vyhlazena                          #", "green"))
print(colored("#---------------------------------------------------------------------------------#", "green"))

menu()

print(colored("#---------------------------------------------------------------------------------#", "green"))
print(colored("#                    Made by Artee                                           v1.3 #", "green"))
print(colored("#                                Všechna práva vyhlazena                          #", "green"))
print(colored("#---------------------------------------------------------------------------------#", "green"))

time.sleep(2)
sys.exit()
