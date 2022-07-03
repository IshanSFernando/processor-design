instruction_dic={"FETCH":0,"LDAC":4,"LDACR":11,"LOAD":18,"STORER":22,"STACR":25,"INC1AC":30,"INC2AC":32,"INC3AC":34,"DEC1AC":36,"DEC2AC":38,"DEC3AC":40,"ADD":42,"SUB":46,"MUL":50,"DIV":53,
                  "IMM":56,"MULR":59,"JUMPLSB":63,"JUMPNLSB":67,"JUMPNNEG":71}
registers={"Rcol":"000000001","Rrow":"000000010",
           "Ri":"000000011","Rj":"000000100","Rtotal":"000000101","Raddress":"000000110","Rbnd":"000000111","RcolTemp":"000001000"}
other={"C":256,"R":256,"1":1,"188":188,"210":210,"32":32,"2":2,"4":4,"16":16}

list1=[]

with open('Reduced_Assembly.txt', 'r') as file:
    # reading each line
    for line in file:

        # reading each word
        for word in line.split():
            # displaying the words
            list1.append(word)

with open('InstructionMemory_smile_cat.txt', 'w') as f:
    for elements in list1:
        if elements in instruction_dic:
            f.write('{0:09b}\n'.format(instruction_dic[elements]))
        elif elements in registers:
            f.write(str(registers[elements])+"\n")
        elif elements in other:
            f.write('{0:09b}\n'.format(other[elements]))
        elif elements=="EXIT":
            f.write('{0:09b}'.format(75))
        else:
            f.write("-------"+str(elements)+"-----------")