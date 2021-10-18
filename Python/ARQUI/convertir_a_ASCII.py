# Convertir a ASCII
def convertir_a_ASCII(texto):

    for i in range(len(texto)):

        character_to_ascii = ord(texto[i])  # convertir caracter a ascii
        int_to_binary = "{0:b}".format(character_to_ascii)


texto = "DA VID "
convertir_a_ASCII(texto)
