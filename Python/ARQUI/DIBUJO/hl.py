
from PIL import Image, ImageColor


def absolute(x):
    if x > 0:
        return x
    else:
        return -x


def getCoords(x, y):
    tmp = 1
    coords = tmp << x
    tmp = 2
    tmp = y << tmp
    tmp = tmp + y
    coords = coords << tmp
    return coords


def drawCircle(xc, yc, x, y):
    global resultDraw
    # result.append((xc+x, yc+y))
    # result.append((xc-x, yc+y))
    # result.append((xc+x, yc-y))
    # result.append((xc-x, yc-y))
    # result.append((xc+y, yc+x))
    # result.append((xc-y, yc+x))
    # result.append((xc+y, yc-x))
    # result.append((xc-y, yc-x))
    resultDraw = resultDraw | getCoords(xc + x, yc + y)
    resultDraw = resultDraw | getCoords(xc - x, yc + y)
    resultDraw = resultDraw | getCoords(xc + x, yc - y)
    resultDraw = resultDraw | getCoords(xc - x, yc - y)
    resultDraw = resultDraw | getCoords(xc + y, yc + x)
    resultDraw = resultDraw | getCoords(xc - y, yc + x)
    resultDraw = resultDraw | getCoords(xc + y, yc - x)
    resultDraw = resultDraw | getCoords(xc - y, yc - x)


def circleBres(xc, yc, r):
    x = 0
    y = r
    tmp = r << 1
    d = 3 - tmp
    drawCircle(xc, yc, x, y)
    # y,x,d,
    while True:
        if (y < x):
            break
        x = x + 1

        if (0 < d):
            y = y - 1
            d = d + 10
            tmp = x - y
            tmp = tmp << 2
            d = d + tmp
        else:
            d = d + 6
            tmp = x << 2
            d = d + tmp
        drawCircle(xc, yc, x, y)


def plotLine(x0, y0, x1, y1):
    global resultDraw

    eval = x1-x0
    eval = absolute(eval)
    tmp = y1-y0
    tmp = absolute(tmp)

    if eval > tmp:
        eval = 1
    else:
        eval = 0

    if not eval:
        tmp = x0
        x0 = y0
        y0 = tmp
        tmp = x1
        x1 = y1
        y1 = tmp

    dx = x1 - x0
    dy = y1 - y0

    yi = 1
    if dy < 0:
        yi = -1
        dy = -dy

    dif = dy - dx
    D = dy + dif
    y = y0
    x = x0

    # x,x1,y,eval,yi,D,dif,dy,
    while True:  # break x1<x
        if (x1 < x):
            break
        if eval:
            coords = getCoords(x, y)
        else:
            coords = getCoords(y, x)
        resultDraw = resultDraw | coords

        if 0 < D:
            y = y + yi
            D = D + dif
            D = D + dif
        else:
            D = D + dy
            D = D + dy
        x = x + 1


def draw(char):
    global resultDraw
    resultDraw = 0
    if (char == 'A'):
        plotLine(0, 0, 4, 0)
        plotLine(0, 3, 4, 3)
        plotLine(0, 0, 0, 4)
        plotLine(4, 0, 4, 4)
        # s = "{0:032b}".format(resultDraw)
        # print('-'.join(s[i:i+8] for i in range(0, len(s), 8)))
    elif (char == 'B'):
        plotLine(0, 0, 3, 0)  # -
        plotLine(0, 2, 4, 2)  # -
        plotLine(0, 4, 4, 4)  # -
        plotLine(0, 0, 0, 4)  # |
        plotLine(3, 0, 3, 2)  # |
        plotLine(4, 2, 4, 4)  # |
    elif (char == 'C'):
        plotLine(0, 0, 4, 0)  # -
        plotLine(0, 4, 4, 4)  # -
        plotLine(0, 0, 0, 4)  # |
    elif (char == 'D'):
        plotLine(0, 0, 0, 4)  # |
        plotLine(4, 1, 4, 3)  # |
        plotLine(0, 0, 4, 1)  # -
        plotLine(0, 4, 4, 3)  # -
    elif (char == 'E'):
        plotLine(0, 0, 4, 0)  # -
        plotLine(0, 2, 4, 2)  # -
        plotLine(0, 4, 4, 4)  # -
        plotLine(0, 0, 0, 4)  # |
    elif (char == 'F'):
        plotLine(0, 0, 4, 0)  # -
        plotLine(0, 2, 4, 2)  # -
        plotLine(0, 0, 0, 4)  # |
    elif (char == 'G'):
        plotLine(0, 0, 4, 0)  # -
        plotLine(2, 2, 4, 2)  # -
        plotLine(0, 4, 4, 4)  # -
        plotLine(0, 0, 0, 4)  # |
        plotLine(4, 2, 4, 4)  # |
    elif (char == 'H'):
        plotLine(0, 2, 4, 2)  # -
        plotLine(0, 0, 0, 4)  # |
        plotLine(4, 0, 4, 4)  # |
    elif (char == 'I'):
        plotLine(0, 0, 4, 0)  # -
        plotLine(0, 4, 4, 4)  # -
        plotLine(2, 0, 2, 4)  # |

    elif (char == 'J'):
        plotLine(1, 0, 4, 0)  # -
        plotLine(2, 0, 2, 4)  # |
        plotLine(0, 4, 2, 4)  # -
    elif (char == 'K'):
        plotLine(0, 0, 0, 4)  # |
        plotLine(1, 2, 4, 0)  # /
        plotLine(1, 2, 4, 4)  # \
    elif (char == 'L'):
        plotLine(0, 0, 0, 4)  # |
        plotLine(0, 4, 4, 4)  # -

    elif (char == 'M'):
        plotLine(0, 0, 0, 4)  # |
        plotLine(4, 0, 4, 4)  # |
        plotLine(0, 0, 2, 3)  # |
        plotLine(4, 0, 2, 3)  # |
    elif (char == 'N'):
        plotLine(0, 0, 0, 4)  # |
        plotLine(4, 0, 4, 4)  # |
        plotLine(0, 0, 4, 4)  # |

    elif (char == 'O'):
        plotLine(0, 1, 0, 3)  # |
        plotLine(1, 0, 3, 0)  # -
        plotLine(1, 4, 3, 4)  # -
        plotLine(4, 1, 4, 3)  # |
    elif (char == 'P'):
        plotLine(0, 0, 0, 4)  # |
        plotLine(1, 0, 4, 0)  # -
        plotLine(1, 3, 4, 3)  # -
        plotLine(4, 0, 4, 3)  # |
    elif (char == 'Q'):
        plotLine(0, 1, 0, 3)  # |
        plotLine(1, 0, 3, 0)  # -
        plotLine(1, 4, 3, 4)  # -
        plotLine(4, 1, 4, 3)  # |
        plotLine(3, 3, 4, 4)  # |
    elif (char == 'R'):
        plotLine(0, 0, 0, 4)  # |
        plotLine(1, 0, 4, 0)  # -
        plotLine(1, 3, 4, 3)  # -
        plotLine(4, 0, 4, 3)  # |
        plotLine(3, 3, 4, 4)  # |

    elif (char == 'S'):
        plotLine(0, 0, 0, 2)  # |
        plotLine(4, 2, 4, 4)  # |
        plotLine(0, 0, 4, 0)  # -
        plotLine(0, 4, 4, 4)  # -
        plotLine(0, 2, 4, 2)  # -
    elif (char == 'T'):
        plotLine(0, 0, 4, 0)  # -
        plotLine(2, 0, 2, 4)  # |
    elif (char == 'U'):
        plotLine(0, 0, 0, 4)  # |
        plotLine(4, 0, 4, 4)  # |
        plotLine(0, 4, 4, 4)  # -

    elif (char == 'V'):
        plotLine(0, 0, 2, 4)  # \
        plotLine(4, 0, 2, 4)  # /
    elif (char == 'W'):
        plotLine(0, 0, 0, 4)  # |
        plotLine(2, 0, 2, 4)  # |
        plotLine(4, 0, 4, 4)  # |
        plotLine(0, 4, 4, 4)  # -
    elif (char == 'X'):
        plotLine(0, 0, 4, 4)  # \
        plotLine(4, 0, 0, 4)  # /
    elif (char == 'Y'):
        plotLine(0, 0, 2, 2)  # \
        plotLine(4, 0, 2, 2)  # /
        plotLine(2, 3, 2, 4)  # |
    elif (char == 'Z'):
        plotLine(0, 0, 4, 0)  # -
        plotLine(4, 0, 0, 4)  # /
        plotLine(0, 4, 4, 4)  # -

    elif (char == 'O'):
        plotLine(0, 0, 0, 4)  # |
        plotLine(4, 0, 4, 4)  # |
        plotLine(0, 4, 4, 4)  # -
        plotLine(0, 0, 4, 0)  # -
    elif (char == '1'):
        circleBres(2, 2, 2)  # O
    elif (char == '2'):
        plotLine(2, 0, 2, 1)  # |
        plotLine(2, 3, 2, 4)  # |
        plotLine(0, 2, 1, 2)  # |
        plotLine(3, 2, 4, 2)  # |
        plotLine(0, 2, 0, 4)  # |

    print(char, resultDraw)

    memmory[offset] = resultDraw


memmory = {x: 0 for x in range(200)}
file = open("test.txt")
text = file.read()
memmoryText = list(text)+[0]

offset = 0
resultDraw = 0
while True:
    if (memmoryText[offset] == 0):
        break
    draw(memmoryText[offset])
    offset = offset + 1


# _________________________________/ALTO NIVEL/_________________________________
LINE_SIZE = 41
LETTERS = 60
LETTER_BITS = 32

im = Image.new('1', (250, 250))
offsetX = 0
offsetY = 0
for i in range(200):
    bits = list("{:032b}".format(memmory[i]))
    bits.reverse()
    for j in range(32):
        X = j % 5 + offsetX*6
        Y = int(j/5) + offsetY*6
        if (bits[j] == '1'):
            color = ImageColor.getcolor('white', '1')
        else:
            color = ImageColor.getcolor('black', '1')
        # print((X, Y), color, (offsetX, offsetY))
        im.putpixel((X, Y), color)
    offsetX += 1
    if offsetX >= LINE_SIZE:
        offsetX = 0
        offsetY += 1

im.save('out.png')
