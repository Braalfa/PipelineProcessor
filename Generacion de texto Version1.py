from matplotlib import pyplot as plt
import numpy as np

# Memoria de datos (ROM) -> 250x250
'''dataMemoryROM = {
              0 : '01000100', #D
              1 : '01000001', #A
              2 : '01010110', #V
              3 : '01001001', #I
              4 : '01000100', #D
              5 : '00100000'  #espacio en blanco
              }'''
dataMemoryROM = {}

# Convertir a ASCII
def convertir_a_ASCII(texto):

    for i in range(len(texto)):

        character_to_ascii = ord(texto[i]) # convertir caracter a ascii
        int_to_binary = "{0:b}".format(character_to_ascii)

        '''ceros = ""
        largo = len(int_to_binary)
        while largo < 8:
            ceros += '0'
            largo += 1'''
            
        dataMemoryROM[i] = int_to_binary

texto = "DA VID "
convertir_a_ASCII(texto)
# ---------------------

# Memoria de datos (RAM) -> 250x250  
filas = 24
columnas = 24

lista = []
for i in range(filas):
    lista.append(0)

matriz = []
for i in range(columnas):
    matriz.append(lista)

dataMemoryRAM = np.array(matriz)

# Ciclo principal
def main():

    # Declarar variables y constantes
    posicionX = 0
    posicionY = 0
    direccionMemoriaROM = 0
    LINE_SIZE = 4 # 4 caracteres por renglon
    line_size_used = 0
    inicio_palabra = 0
    
    while(direccionMemoriaROM < 6):
    
        # Traer el caracter de memoria
        caracter = dataMemoryROM[direccionMemoriaROM]
        
        # Subciclo -> Revisar si la palabra cabe en el renglon
        direccionMemoriaAuxiliar = direccionMemoriaROM
        word_size = 0
        while dataMemoryROM[direccionMemoriaAuxiliar] != '100000': # espacio en blanco
            word_size += 1
            direccionMemoriaAuxiliar += 1  # Aumenta la posicion en memoria para obtener el siguiente caracter
   
        line_size_used += word_size
        if line_size_used <= LINE_SIZE: # Verifica que (la palabra + lo ya utilizado) quepa en el espacio restante del renglon
            # Puede agregar la palabra en la linea actual
            line_size_used = line_size_used - (word_size - 1)
            
            # Determina el caracter de la posicion en memoria actual
            if dataMemoryROM[direccionMemoriaROM] == '1000001': # A
                # Ejecutar el algoritmo para obtener la primer linea horizontal
                line(posicionX, posicionY, posicionX+4, posicionY)
                
                # Ejecutar el algoritmo para obtener la segunda linea horizontal
                line(posicionX, posicionY+2, posicionX+4, posicionY+2)

                # Ejecutar el algoritmo para obtener la primer linea vertical
                line(posicionX, posicionY, posicionX, posicionY+4)
                
                # Ejecutar el algoritmo para obtener la primer linea vertical
                line(posicionX+4, posicionY, posicionX+4, posicionY+4)

            elif dataMemoryROM[direccionMemoriaROM] == '1111111': # B
                pass

            elif dataMemoryROM[direccionMemoriaROM] == '1111111': # C
                pass

            elif dataMemoryROM[direccionMemoriaROM] == '1000100': # D
                line(posicionX, posicionY, posicionX, posicionY+4)
                line(posicionX, posicionY, posicionX+4, posicionY+1)
                line(posicionX, posicionY+4, posicionX+4, posicionY+3)
                line(posicionX+4, posicionY+1, posicionX+4, posicionY+3)
                                                                              
            elif dataMemoryROM[direccionMemoriaROM] == '1001001': # I
                line(posicionX, posicionY, posicionX+4, posicionY)
                line(posicionX, posicionY+4, posicionX+4, posicionY+4)
                line(posicionX+2, posicionY, posicionX+2, posicionY+4)

            elif dataMemoryROM[direccionMemoriaROM] == '1010110': # V
                line(posicionX, posicionY, posicionX+2, posicionY+4)
                line(posicionX+4, posicionY, posicionX+2, posicionY+4)

            # Aumentar posicion
            posicionX += 6 # Las 5 posiciones + 1 cero (espacio)
            direccionMemoriaROM += 1

            if posicionX >= filas:
                posicionX = 0
                posicionY += 6 # Las 5 posiciones + 1 cero (espacio)
                
        else:
            # Debe agregar la palabra en la siguiente linea y almacenar en las posiciones no utilizadas un 0
            posicionX = 0
            posicionY += 6 # Las 5 posiciones + 1 cero (espacio)
            line_size_used = 0
            
    print(dataMemoryRAM)

# Algortimo Bresenham
def line( x0, y0, x1, y1):
    "Bresenham's line algorithm"
    dx = abs(x1 - x0)
    dy = abs(y1 - y0)
    x, y = x0, y0
    sx = -1 if x0 > x1 else 1
    sy = -1 if y0 > y1 else 1
    if dx > dy:
        err = dx / 2.0
        while x != x1:
            dataMemoryRAM[y][x] = 1
            err -= dy
            if err < 0:
                y += sy
                err += dx
            x += sx
    else:
        err = dy / 2.0
        while y != y1:
            dataMemoryRAM[y][x] = 1
            err -= dx
            if err < 0:
                x += sx
                err += dy
            y += sy        
    dataMemoryRAM[y][x] = 1

main()

# ------------------------------------------------ Dibujar texto

texto = "100010111110111110"
i = 0;
j = 0;
x = 1;
y = 3;
while(i < len(dataMemoryRAM)):

    j = 0
    while(j < len(dataMemoryRAM)):
        if(dataMemoryRAM[i][j] == 1):
            plt.scatter(x, y, marker="o", color="black", s=10)
        x += 0.2
        j += 1; 

    y -= 0.2
    x = 1  
    i += 1; 

# Dibujar Superficie
plt.plot([0, 5], [0, 0], 'C3', lw=1)
plt.plot([0, 5], [5, 5], 'C3', lw=1)
plt.plot([0, 0], [0, 5], 'C3', lw=1)
plt.plot([5, 5], [0, 5], 'C3', lw=1)

plt.show()



 
