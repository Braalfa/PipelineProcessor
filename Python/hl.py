from PIL import Image, ImageColor
import numpy as np
# _________________________________/ALTO NIVEL/_________________________________
LINE_SIZE = 41

im = Image.new('1', (250, 250), 'white')
offsetX = 0
offsetY = 0

memmory = []
with open('../outfile.txt') as f:
    memmory = f.readlines()

for i in range(len(memmory)):
    memmory[i] = memmory[i][:-1]

for i in range(len(memmory), 1681):
    memmory.append("{:036b}".format(0))

for i in range(1681):
    bits = [int(c) for c in memmory[i]]
    bits.reverse()
    for j in range(36):
        X = j % 6 + 6*(i%41)
        Y = j//6 + 6*(i//41)
        if (bits[j] == 1):
            color = ImageColor.getcolor('black', '1')
        else:
            color = ImageColor.getcolor('white', '1')
        #print((X, Y), color, (offsetX, offsetY))
        im.putpixel((X, Y), color)
     
im.save('out.png')
import matplotlib.pyplot as plt
plt.imshow(im, cmap='gray', vmin=0,vmax=255)
plt.axis('off')
plt.show()

