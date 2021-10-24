
from PIL import Image, ImageColor


def absolute(x):
    if x > 0:
        return x
    else:
        return -x


def getCoords(x, y):
    tmp = 1
    x = x + 6
    coords = tmp << x
    tmp = 2
    tmp = y << tmp
    tmp = tmp + y
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


def drawAll():
    global resultDraw
    i = 1

    # A
    resultDraw = 0
    plotLine(0, 0, 4, 0)
    plotLine(0, 3, 4, 3)
    plotLine(0, 0, 0, 4)
    plotLine(4, 0, 4, 4)
    memmory[i] = resultDraw
    i += 1

    # B
    resultDraw = 0
    plotLine(0, 0, 3, 0)  # -
    plotLine(0, 2, 4, 2)  # -
    plotLine(0, 4, 4, 4)  # -
    plotLine(0, 0, 0, 4)  # |
    plotLine(3, 0, 3, 2)  # |
    plotLine(4, 2, 4, 4)  # |
    memmory[i] = resultDraw
    i += 1

    # C
    resultDraw = 0
    plotLine(0, 0, 4, 0)  # -
    plotLine(0, 4, 4, 4)  # -
    plotLine(0, 0, 0, 4)  # |
    memmory[i] = resultDraw
    i += 1

    # D
    resultDraw = 0
    plotLine(0, 0, 0, 4)  # |
    plotLine(4, 1, 4, 3)  # |
    plotLine(0, 0, 4, 1)  # -
    plotLine(0, 4, 4, 3)  # -
    memmory[i] = resultDraw
    i += 1

    # E
    resultDraw = 0
    plotLine(0, 0, 4, 0)  # -
    plotLine(0, 2, 4, 2)  # -
    plotLine(0, 4, 4, 4)  # -
    plotLine(0, 0, 0, 4)  # |
    memmory[i] = resultDraw
    i += 1

    # F
    resultDraw = 0
    plotLine(0, 0, 4, 0)  # -
    plotLine(0, 2, 4, 2)  # -
    plotLine(0, 0, 0, 4)  # |
    memmory[i] = resultDraw
    i += 1

    # G
    resultDraw = 0
    plotLine(0, 0, 4, 0)  # -
    plotLine(2, 2, 4, 2)  # -
    plotLine(0, 4, 4, 4)  # -
    plotLine(0, 0, 0, 4)  # |
    plotLine(4, 2, 4, 4)  # |
    memmory[i] = resultDraw
    i += 1

    # H
    resultDraw = 0
    plotLine(0, 2, 4, 2)  # -
    plotLine(0, 0, 0, 4)  # |
    plotLine(4, 0, 4, 4)  # |
    memmory[i] = resultDraw
    i += 1

    # I
    resultDraw = 0
    plotLine(0, 0, 4, 0)  # -
    plotLine(0, 4, 4, 4)  # -
    plotLine(2, 0, 2, 4)  # |
    memmory[i] = resultDraw
    i += 1

    # J
    resultDraw = 0
    plotLine(1, 0, 4, 0)  # -
    plotLine(2, 0, 2, 4)  # |
    plotLine(0, 4, 2, 4)  # -
    memmory[i] = resultDraw
    i += 1

    # K
    resultDraw = 0
    plotLine(0, 0, 0, 4)  # |
    plotLine(1, 2, 4, 0)  # /
    plotLine(1, 2, 4, 4)  # \
    memmory[i] = resultDraw
    i += 1

    # L
    resultDraw = 0
    plotLine(0, 0, 0, 4)  # |
    plotLine(0, 4, 4, 4)  # -
    memmory[i] = resultDraw
    i += 1

    # M
    resultDraw = 0
    plotLine(0, 0, 0, 4)  # |
    plotLine(4, 0, 4, 4)  # |
    plotLine(0, 0, 2, 3)  # |
    plotLine(4, 0, 2, 3)  # |
    memmory[i] = resultDraw
    i += 1

    # N
    resultDraw = 0
    plotLine(0, 0, 0, 4)  # |
    plotLine(4, 0, 4, 4)  # |
    plotLine(0, 0, 4, 4)  # |
    memmory[i] = resultDraw
    i += 1

    # O
    resultDraw = 0
    plotLine(0, 1, 0, 3)  # |
    plotLine(1, 0, 3, 0)  # -
    plotLine(1, 4, 3, 4)  # -
    plotLine(4, 1, 4, 3)  # |
    memmory[i] = resultDraw
    i += 1

    # P
    resultDraw = 0
    plotLine(0, 0, 0, 4)  # |
    plotLine(1, 0, 4, 0)  # -
    plotLine(1, 3, 4, 3)  # -
    plotLine(4, 0, 4, 3)  # |
    memmory[i] = resultDraw
    i += 1

    # Q
    resultDraw = 0
    plotLine(0, 1, 0, 3)  # |
    plotLine(1, 0, 3, 0)  # -
    plotLine(1, 4, 3, 4)  # -
    plotLine(4, 1, 4, 3)  # |
    plotLine(3, 3, 4, 4)  # |
    memmory[i] = resultDraw
    i += 1

    # R
    resultDraw = 0
    plotLine(0, 0, 0, 4)  # |
    plotLine(3, 0, 3, 3)  # |
    plotLine(0, 0, 3, 0)  # -
    plotLine(0, 3, 4, 3)  # -
    plotLine(4, 3, 4, 4)  # |
    memmory[i] = resultDraw
    i += 1

    # S
    resultDraw = 0
    plotLine(0, 0, 0, 2)  # |
    plotLine(4, 2, 4, 4)  # |
    plotLine(0, 0, 4, 0)  # -
    plotLine(0, 4, 4, 4)  # -
    plotLine(0, 2, 4, 2)  # -
    memmory[i] = resultDraw
    i += 1

    # T
    resultDraw = 0
    plotLine(0, 0, 4, 0)  # -
    plotLine(2, 0, 2, 4)  # |
    memmory[i] = resultDraw
    i += 1

    # U
    resultDraw = 0
    plotLine(0, 0, 0, 4)  # |
    plotLine(4, 0, 4, 4)  # |
    plotLine(0, 4, 4, 4)  # -
    memmory[i] = resultDraw
    i += 1

    # V
    resultDraw = 0
    plotLine(0, 0, 2, 4)  # \
    plotLine(4, 0, 2, 4)  # /
    memmory[i] = resultDraw
    i += 1

    # W
    resultDraw = 0
    plotLine(0, 0, 0, 4)  # |
    plotLine(2, 0, 2, 4)  # |
    plotLine(4, 0, 4, 4)  # |
    plotLine(0, 4, 4, 4)  # -
    memmory[i] = resultDraw
    i += 1

    # X
    resultDraw = 0
    plotLine(0, 0, 4, 4)  # \
    plotLine(4, 0, 0, 4)  # /
    memmory[i] = resultDraw
    i += 1

    # Y
    resultDraw = 0
    plotLine(0, 0, 2, 2)  # \
    plotLine(4, 0, 2, 2)  # /
    plotLine(2, 3, 2, 4)  # |
    memmory[i] = resultDraw
    i += 1

    # Z
    resultDraw = 0
    plotLine(0, 0, 4, 0)  # -
    plotLine(4, 0, 0, 4)  # /
    plotLine(0, 4, 4, 4)  # -
    memmory[i] = resultDraw
    i += 1

    # 27
    resultDraw = 0
    circleBres(2, 2, 2)  # O
    memmory[i] = resultDraw
    i += 1

    # 28
    resultDraw = 0
    plotLine(2, 0, 2, 1)  # |
    plotLine(2, 3, 2, 4)  # |
    plotLine(0, 2, 1, 2)  # |
    plotLine(3, 2, 4, 2)  # |
    plotLine(0, 2, 0, 4)  # |
    memmory[i] = resultDraw
    i += 1

    # 29 ,
    resultDraw = 0
    plotLine(1, 2, 0, 4)  # |
    memmory[i] = resultDraw
    i += 1

    # 30 .
    resultDraw = 0
    plotLine(0, 3, 0, 4)  # |
    plotLine(1, 3, 1, 4)  # |
    memmory[i] = resultDraw
    i += 1

    # 31 ' '
    resultDraw = 0
    memmory[i] = resultDraw
    i += 1


def checkSpaces():
    global offset1, offset2, spaces
    tmp1 = 1
    tmp1 = offset1 - tmp1
    tmp1 = memmory[tmp1]
    tmp2 = 31
    if (tmp1 == tmp2):
        spaces = 41
        return
    tmp1 = memmory[offset1]
    if(tmp1 == tmp2):
        spaces = 41
        return

    tmp1 = offset2
    while True:
        tmp2 = 31
        tmp3 = memmory[offset1]
        if (tmp3 == tmp2):
            break
        tmp2 = 0
        memmory[offset2] = tmp2
        tmp2 = 1
        offset1 = offset1-tmp2
        offset2 = offset2-tmp2
    tmp2 = 1
    offset1 = offset1 + tmp2
    offset2 = tmp1

    spaces = 41


file = open("test.txt")
text = file.read()
memmory = {x: 0 for x in range(3000)}
letters = [18, 1, 2, 3, 31, 18, 1, 2, 3, 31, 18, 1, 2, 3, 31, 18, 1, 2, 3, 31, 18, 1, 2, 3,
           31, 18, 1, 2, 3, 31, 18, 1, 2, 3, 31, 18, 1, 2, 18, 1, 2, 3, 31, 18, 1, 2, 3, 31, 18, 1, 2, 3, 31, 18, 1, 2, 3, 31, 18, 1, 2, 3, 31, 18, 1, 2, 3, 31, 18, 1, 2, 3,
           31, 18, 1, 2, 3, 31, 18, 1, 2, 3, 31, 18, 1, 2, 18, 1, 2, 3, 31, 18, 1, 2, 3, 31, 0, ]
for i in range(200):
    if (letters[i] == 0):
        break
    memmory[32+i] = letters[i]

spaces = 41
offset1 = 32
offset2 = 1056
resultDraw = 0
drawAll()
while True:
    if (memmory[offset1] == 0):
        break
    tmp = 0
    if (spaces == tmp):
        checkSpaces()
        continue

    tmp = memmory[offset1]
    tmp = memmory[tmp]
    memmory[offset2] = tmp

    tmp = 1
    offset1 = offset1 + tmp
    offset2 = offset2 + tmp
    spaces = spaces - tmp


# _________________________________/ALTO NIVEL/_________________________________
LINE_SIZE = 41
LETTERS = 60
LETTER_BITS = 32

im = Image.new('1', (250, 250))
offsetX = 0
offsetY = 0
for i in range(1056, 1056+200):
    bits = list("{:036b}".format(memmory[i]))
    # print("{:036b}".format(memmory[i]))
    bits.reverse()
    for j in range(36):
        X = j % 6 + offsetX*6
        Y = int(j/6) + offsetY*6
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
