text = "A1B"
memsize = 512
asciiList = ['{:032b}'.format(ord(c))+"\n" for c in text]

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
