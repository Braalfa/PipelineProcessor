text = "Lorem,. ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur Excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum Lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat"
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
    mem.append('{:032b}'.format(0)+"\n" )
f = open("../mem4.txt", "w")
f.writelines(mem)
