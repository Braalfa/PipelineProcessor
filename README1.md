# Arquitectura de Computadores I - Proyecto Grupal I

## Integrantes
- David Quesada Calderón
- Brayan Alfaro Gonzales
- Juan Pablo Alvarado Villalobos

## Descripción
Especificación de las herramientas utilizadas en el proyecto e instrucciones de uso.

## Herramientas utilizadas

**Quartus**: Se elige Quartus como compilador del sistema ya que esta es una herramienta de software que nos permite realizar el análisis y síntesis de los diseños realizados en HDL. Además, permite compilar los diseños, realizar análisis temporales, examinar diagramas RTL, simular el funcionamiento del sistema, configurar y cargar el dispositivo de destino a disposición del programador.

**Python**: Se emplea el lenguaje interpretado de alto nivel Python debido a su amplia trayectoria en la industria, teniendo una basta documentación, una extensa comunidad de usuarios y una gran cantidad de librerías; además de su facilidad de uso.

## Instrucciones de uso

Para poder utilizar el procesador de generación de graficos y texto se deberá realizar una serie de pasos. 

**Paso 1**: Inicialmente se deberá ingresar al archivo "texto.txt" el texto al cual se le aplicará el proceso de generación de texto mediante gráficos. 

**Paso 2**: Luego de ingresar el texto, se debe convertir dicho texto a un código binario legible por la arquitectura; para esto se debe ejecutar el archivo de python "textToBinary.py"

**Paso 3**: Posteriomente se deberá compilar el programa ensamblador almacenado en el archivo "programa.txt" mediante el script de python "compiler.py"

**Paso 4**: Ya completado el paso 3 se deberá configurar mediante Quartus el test bench del archivo "outdebug.sv". Ya configurado el test bench, se procede a correr la herramienta de simulacion de Quartus.

**Paso 5**: Con la herramienta RTL en ejecución se deberá forzar la entrada "StartIO" en 1 para que comience el proceso de generación de texto mediante gráficos.

**Paso 6**: Finalmente, la ejecucion del paso 5 genera en el archivo "outfile.txt" la imagen binarizada del texto inicialmente cargado en el paso 1, por lo que para visualizarlo de mejor manera se deberá ejecutar el script del archivo "hl.py". 
