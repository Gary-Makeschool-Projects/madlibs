import sys  # sys library
import re  # regex library
import random
import requests
import json
import os
# colorama library for coloring text and background
from colorama import Fore, Back, Style


filler = {
    'adjectives': [],  # collection of adjectives
    'verbs': [],    # collection of verbs
    'nouns': [],    # collection of nouns
    'adverbs': [],   # collections adverbs
    'pronouns': []  # collection of pronouns

}


def banner():
    """Will create color Banner

        Args:
            None


        Returns:
            strings to the console

    """
    # if operating system does not have requirements installed ask to install
    # if chosen to opt out on requirements print basic banner
    # other wise check the operating system and install the requirements accordingly

    print('+ Installing dependecies')
    os.system('sudo gem install artii')
    os.system('brew install lolcat')

    os.system(
        "echo '===============================================================' | lolcat")
    # requirements artii and lolcat
    os.system('artii MadLibs | lolcat --animate -p 5.0 -d 10 -s 40 --freq 0.4')
    os.system('echo @author: imthaghost | lolcat')
    os.system(
        "echo ' ===============================================================' | lolcat")
    print('\n')


def verify(url, resp):
    if resp.status_code == 200:
        r = requests.get(url)
        data = r.json()
        return data
    else:
        print('error')
        return False

# validate the user input only allow the english alphabet


def validinput(someString):
    if len(someString) > 0 and re.match('^[a-zA-Z]*$', someString):

        return True
    else:
        return False


def getAdjective(adjectives):
    index = random.randrange(len(adjectives['adjectives']))
    adj = Fore.LIGHTMAGENTA_EX + \
        adjectives['adjectives'][index] + Fore.RESET  # adjectives are magneta
    return adj


def setAdjective(kind):
    x = True
    while(x):
        word = input("Give me an " + kind + ": ")  # user input
        # check if user input is a valid string
        if(validinput(word)):
            x = False  # asign x to false to close while loop
            # add user input to adjectives dictionary
            return filler['adjectives'].append(word)
        else:
            print('Need a valid adjective')


def getVerbs(verbs):
    index = random.randrange(len(verbs['verbs']))
    # adjectives are magneta
    verb = Fore.LIGHTRED_EX + verbs['verbs'][index] + Fore.RESET
    return verb


def setVerb(kind):
    x = True
    while(x):
        word = input("Give me an " + kind + ": ")  # user input
        # check if user input is a valid string
        if(validinput(word)):
            x = False  # asign x to false to close while loop
            # add user input to adjectives dictionary
            return filler['verbs'].append(word)
        else:
            print('Need a valid verb')


def getNoun(nouns):
    index = random.randrange(len(nouns['nouns']))
    noun = Fore.LIGHTGREEN_EX + \
        nouns['nouns'][index] + Fore.RESET  # nouns are green
    return noun


def setNoun(kind):
    x = True
    while(x):
        word = input("Give me a " + kind + ": ")  # user input
        # check if user input is a valid string
        if(validinput(word)):
            x = False  # asign x to false to close while loop
            # add user input to adjectives dictionary
            return filler['nouns'].append(word)
        else:
            print('Need a valid noun')


def getAdverbs(adverbs):
    index = random.randrange(len(adverbs['adverbs']))
    # adjectives are magneta
    adverb = Fore.YELLOW + adverbs['adverbs'][index] + Fore.RESET
    return adverb


def setAdverbs(kind):
    x = True
    while(x):
        word = input("Give me an " + kind + ": ")  # user input
        # check if user input is a valid string
        if(validinput(word)):
            x = False  # asign x to false to close while loop
            # add user input to adjectives dictionary
            return filler['adverbs'].append(word)
        else:
            print('Need a valid adverb')


def connect(body, blanks):
    sentence = []
    for x in range(len(body)):
        if x < len(blanks):
            if 'adjective' in blanks[x]:
                sentence.append(body[x] + getAdjective(filler))
            elif 'verb' in blanks[x]:
                sentence.append(body[x])
                sentence.append(getVerbs(filler))
            elif 'noun' in blanks[x]:
                sentence.append(body[x] + getNoun(filler))
            elif 'body' in blanks[x]:
                sentence.append(body[x] + getNoun(filler))
            elif 'clothing' in blanks[x]:
                sentence.append(body[x] + getNoun(filler))
            elif 'place' in blanks[x]:
                sentence.append(body[x] + getNoun(filler))
            elif 'liquid' in blanks[x]:
                sentence.append(body[x] + getNoun(filler))
    return sentence


def story():
    api_url = "http://madlibz.herokuapp.com/api/random?minlength=5&maxlength=25"

    resp = requests.get(
        'http://madlibz.herokuapp.com/api/random?minlength=5&maxlength=25')
    madlib = verify(api_url, resp)  # verify api
    title = madlib['title']  # Title of story
    blanks = madlib['blanks']  # spaces in story
    body = madlib['value']  # body of story
    os.system('artii ' + title + ' | lolcat ')
    # print(blanks)
    for x in range(len(blanks)):
        if 'adjective' in blanks[x]:
            setAdjective(blanks[x])
        elif 'verb' in blanks[x]:
            setVerb(blanks[x])
        elif 'noun' in blanks[x]:
            setNoun(blanks[x])
        elif 'body' in blanks[x]:
            setNoun(blanks[x])
        elif 'clothing' in blanks[x]:
            setNoun(blanks[x])
        elif 'place' in blanks[x]:
            setNoun(blanks[x])
        elif 'country' in blanks[x]:
            setNoun(blanks[x])
        elif 'liquid' in blanks[x]:
            setNoun(blanks[x])
    x = connect(body, blanks)
    s = " "
    s = s.join(x)
    print(s)
    # for i in range(len(x)):
    #     print(x[i])


banner()
story()
