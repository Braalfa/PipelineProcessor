def wordsToAscii(text):
    asciiList = [ord(c) for c in text]
    for code in asciiList:
        print(bin(code)[2:])

wordsToAscii("hola como se encuentra usted")