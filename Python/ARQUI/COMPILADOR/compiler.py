import sys
import re

REGISTERS = {
    "r0": 0,
    "r1": 1,
    "r2": 2,
    "r3": 3,
    "r4": 4,
    "r5": 5,
    "r6": 6,
    "r7": 7,
    "r8": 8,
    "r9": 9,
    "r10": 10,
    "r11": 11,
    "r12": 12,
    "r13": 13,
    "r14": 14,
    "r15": 15
}

INSTR = {
    "ADD":	{"OP": 5, "CAT": "arimeticas"},
    "OR":	{"OP": 8, "CAT": "arimeticas"},
    "SL":	{"OP": 9, "CAT": "arimeticas"},
    "SUB":	{"OP": 6, "CAT": "arimeticas"},
    "BI":	{"OP": 15, "CAT": "branches inm"},
    "B":	{"OP": 12, "CAT": "branches reg"},
    "BL":	{"OP": 13, "CAT": "branches inm"},
    "BE":	{"OP": 11, "CAT": "branches inm"},
    "CMP":	{"OP": 10, "CAT": "cmp"},
    "LDR":	{"OP": 7, "CAT": "load word"},
    "MOV":	{"OP": 3, "CAT": "move"},
    "MOVI":	{"OP": 2, "CAT": "move Inmediate"},
    "STR":	{"OP": 1, "CAT": "store word"},
    "OUT":	{"OP": 4, "CAT": "out"}
}


'''
BRAYAN - ENTRADA/SALIDA
DAVID - CODIGO CIRCULO - PRUEBAS
JUAN - CODIGO LINEA v2 - COMPILADOR

'''


def findBranches(text):
    branches = {}
    i = 0
    while i < len(text):
        if (":" in text[i]):
            branches[text[i][:-1]] = i
            text.pop(i)
        i += 1

    return branches


def cleanText(text):
    newText = []
    for l in text.split("\n"):
        line = l.split(";")[0]
        line = line.replace("\t", " ")
        line = line.strip()
        if (line == ""):
            continue
        newText += [re.sub(' +', ' ', line)]

    return newText


if (not sys.argv[1]):
    print("SELECT FILE TO COMPILE")

file = open(sys.argv[1])
text = file.read()
text = cleanText(text)
BRANCHES = findBranches(text)


binResult = ""
for (i, l) in enumerate(text):
    print(l)
    instr = l.split(" ")[0]
    params = "".join(l.split(" ")[1:]).split(",")
    if(not INSTR.get(instr)):

        print("[WARNING] OP NOT RECOGNIZED LINE: "+str(i))
        continue
    result = "{1}OP{0}({0:04b})".format(INSTR[instr]["OP"], l.ljust(28, "."))

    cat = INSTR[instr]["CAT"]
    if (cat == "arimeticas"):
        for r in params:
            result += "R{0}({0:04b})".format(REGISTERS[r])
    elif (cat == "branches inm"):
        result += "I{0}('0000'{0:016b})".format(int(BRANCHES[params[0]]))
    elif (cat == "branches reg"):
        result += "R{0}('0000'{0:04b})".format(REGISTERS[params[0]])
    elif (cat == "load word"):
        for r in params:
            result += "R{0}({0:04b})".format(REGISTERS[r])
    elif (cat == "store word"):
        result += "('0000')"
        for r in params:
            result += "R{0}({0:04b})".format(REGISTERS[r])
    elif (cat == "move Inmediate"):
        result += "R{0}({0:04b})".format(REGISTERS[params[0]])
        result += "I{0}({0:016b})".format(int(params[1]))
    elif (cat == "cmp"):
        result += "('0000')"
        for r in params:
            result += "R{0}({0:04b})".format(REGISTERS[r])
    elif (cat == "out"):
        result += "('0000')"
        result += "R{0}({0:04b})".format(REGISTERS[params[0]])
    elif (cat == "move"):
        for r in params:
            result += "R{0}({0:04b})".format(REGISTERS[r])

    binResult += result + "\n"

print(binResult)
final = []
i = 0
while (i < len(binResult)):
    if (binResult[i] == "("):
        i += 1
        while (binResult[i] != ")"):
            if (binResult[i] == "1" or binResult[i] == "0"):
                final.append(binResult[i])
            i += 1
    if (binResult[i] == "\n"):
        final.append("\n")
    i += 1
final = "".join(final)
final = final.split("\n")
final = [x.ljust(24, "0") for x in final]

outFile = open("out.txt", "w")
outFile.write("\n".join(final))

print([len(x) for x in final], final)
