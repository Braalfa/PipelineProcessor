from PIL import Image, ImageColor
import numpy as np
# _________________________________/ALTO NIVEL/_________________________________
LINE_SIZE = 41
LETTERS = 60
LETTER_BITS = 32

im = Image.new('1', (250, 250))
offsetX = 0
offsetY = 0

memmory = []
with open('../outfile.txt') as f:
    memmory = f.readlines()

for i in range(len(memmory)):
    memmory[i] = memmory[i][:-2]
    
for i in range(200):
    bits = [int(c) for c in memmory[i]]
    bits.reverse()
    for j in range(32):
        X = j % 5 + offsetX*6
        Y = int(j/5) + offsetY*6
        if (bits[j] == '1'):
            color = ImageColor.getcolor('white', '1')
        else:
            color = ImageColor.getcolor('black', '1')
        #print((X, Y), color, (offsetX, offsetY))
        im.putpixel((X, Y), color)
    offsetX += 1
    if offsetX >= LINE_SIZE:
        offsetX = 0
        offsetY += 1

im.save('out.png')
