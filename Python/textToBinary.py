f = open("text.txt","r")
text = f.readlines()[0]
memsize = 1024
text = text.upper()
asciiList = []
for c in text:
    if c == " ":
        asciiList.append('{:05b}'.format(31)+"\n" )
    elif c == "1":
        asciiList.append('{:05b}'.format(27)+"\n" )
        asciiList.append('{:05b}'.format(28)+"\n" )
    elif c == ",":
        asciiList.append('{:05b}'.format(29)+"\n" )
    elif c == ".":
        asciiList.append('{:05b}'.format(30)+"\n" )
    else:
        asciiList.append('{:05b}'.format(ord(c)-64)+"\n")

print(len(asciiList))

for i in range(len(asciiList), memsize):
    asciiList.append('{:05b}'.format(0)+"\n" )


f = open("../mem3.txt", "w")
f.writelines(asciiList)

mem = []
for i in range(750):
    mem.append('{:036b}'.format(0)+"\n" )
f = open("../mem4.txt", "w")
f.writelines(mem)
