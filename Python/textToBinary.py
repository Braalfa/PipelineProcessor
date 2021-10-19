text = "ABCDEFG   HIJKLMNOP   QRSA BCDE   FTUVWXYZ1"

memsize = 512

asciiList = []
for i in range(0, 30):
    asciiList.append('{:032b}'.format(0)+"\n" )
for c in text:
    if c == " ":
        asciiList.append('{:032b}'.format(29)+"\n" )
    elif c == "1":
        asciiList.append('{:032b}'.format(27)+"\n" )
        asciiList.append('{:032b}'.format(28)+"\n" )
    else:
        asciiList.append('{:032b}'.format(ord(c)-64)+"\n")

print(len(asciiList)-30)

for i in range(len(asciiList), memsize):
    asciiList.append('{:032b}'.format(0)+"\n" )


f = open("../mem2.txt", "w")
f.writelines(asciiList)

mem = []
for i in range(memsize):
    mem.append('{:032b}'.format(0)+"\n" )

f = open("../mem3.txt", "w")
f.writelines(mem)
f = open("../mem4.txt", "w")
f.writelines(mem)
f = open("../mem5.txt", "w")
f.writelines(mem)
f = open("../mem6.txt", "w")
f.writelines(mem)
f = open("../mem7.txt", "w")
f.writelines(mem)