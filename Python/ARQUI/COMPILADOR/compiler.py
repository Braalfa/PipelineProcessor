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
    "ADD":	{"OP": 5, "category": "ART"},
    "OR":	{"OP": 8, "category": "ART"},
    "SL":	{"OP": 9, "category": "ART"},
    "SUB":	{"OP": 6, "category": "ART"},
    "BI":	{"OP": 15, "category": "BI"},
    "B":	{"OP": 12, "category": "BR"},
    "BL":	{"OP": 13, "category": "BI"},
    "BE":	{"OP": 11, "category": "BI"},
    "CMP":	{"OP": 10, "category": "CMP"},
    "LDR":	{"OP": 7, "category": "LDW"},
    "MOV":	{"OP": 3, "category": "MOV"},
    "MOVI":	{"OP": 2, "category": "MOVI"},
    "STR":	{"OP": 1, "category": "STW"},
    "OUT":	{"OP": 4, "category": "OUT"}
}


# Finds labels using the  ":" char, maps the name of the branche to the instruction line
# and deletes de branch of the text in order to have only intrusctions to compile.
# The dictorionary of branch name and instruction number is used for futures branches instructions as an inmediate
def findBranches(text):
    branches = {}
    i = 0
    while i < len(text):
        if (":" in text[i]):
            branches[text[i][:-1]] = i
            text.pop(i)
        i += 1

    return branches


# Removes the comments, whitespaces and tabs from the program to make it easier to compile
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


try:
    sys.argv[1]
except:
    raise Exception("SELECT THE FILE TO COMPILE AS COMMAND PARAMETER")

file = open(sys.argv[1])
text = file.read()
# clean the input text and separe it into lines
text = cleanText(text)
# map the branches inmediantes for jumps
BRANCHES = findBranches(text)

binResult = ""
for (i, l) in enumerate(text):
    # The instruction is the first word of the line
    instr = l.split(" ")[0]
    # The rest of words separed by ',' are parameters
    params = "".join(l.split(" ")[1:]).split(",")
    # Check if the instruction match some of the ISA
    if(not INSTR.get(instr)):
        raise Exception("OP NOT RECOGNIZED LINE ({}) '{}'".format(i, l))

    # Creates a debug string that includes the bits inside () and a description
    result = "Current instr: {1}OP{0}({0:04b})".format(
        INSTR[instr]["OP"], l.ljust(28, "."))

    # Switch to order the bits according to the category
    category = INSTR[instr]["category"]
    # Aritmetic
    if (category == "ART"):
        for r in params:
            result += "R{0}({0:04b})".format(REGISTERS[r])
    # Branch inmediate
    elif (category == "BI"):
        result += "I{0}('0000'{0:016b})".format(int(BRANCHES[params[0]]))
    # Branch to register
    elif (category == "BR"):
        result += "R{0}('0000'{0:04b})".format(REGISTERS[params[0]])
    # Load word
    elif (category == "LDW"):
        for r in params:
            result += "R{0}({0:04b})".format(REGISTERS[r])
    # Store word
    elif (category == "STW"):
        result += "('0000')"
        for r in params:
            result += "R{0}({0:04b})".format(REGISTERS[r])
    # Move inmediate
    elif (category == "MOVI"):
        result += "R{0}({0:04b})".format(REGISTERS[params[0]])
        result += "I{0}({0:016b})".format(int(params[1]))
    # Compare
    elif (category == "CMP"):
        result += "('0000')"
        for r in params:
            result += "R{0}({0:04b})".format(REGISTERS[r])
    # Out
    elif (category == "OUT"):
        result += "('0000')"
        result += "R{0}({0:04b})".format(REGISTERS[params[0]])
    elif (category == "MOV"):
        for r in params:
            result += "R{0}({0:04b})".format(REGISTERS[r])

    # Add the debug string to a final string
    binResult += result + "\n"

print(binResult)
# final is a list with just the binary code compiled
# without the debug data, only the bits inside ()
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

# Join the final bits into one string in order to generate a txt with the binary code
final = "".join(final)
final = final.split("\n")
final = [x.ljust(24, "0") for x in final]

outFile = open("OUT.txt", "w")
outFile.write("\n".join(final))
print("Compiled succesesfully!")
