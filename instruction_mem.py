instruction_dic={"FETCH":0,"LDAC":4,"LDACR":11,"LOAD":18,"STORER":22,"STACR":25,"INCAC":30,"INC2AC":32,"INC3AC":34,"DEC1AC":36,"DEC2AC":38,"DEC3AC":40,"ADD":42,"SUB":46,"MUL":50,"DIV":53,
                  "IMM":56,"MULR":59,"JUMPLSB":63,"JUMPNLSB":67,"JUMPNEG":71}
registers={"MDR":"000000001","MAR":"000000010","AC":"000000011","IR":"000000100","PC":"000000101","IAR":"000000110","IDR":"000000111","TR1":"000001000","Rcol":"000001001","Rrow":"000001010",
           "Ri":"000001011","Rj":"000001100","Rtotal":"000001101","Raddress":"000001110","Rbnd":"000001111","RcolTemp":"000010000"}
other={"C":256,"R":256,"1":1,"178":178,"210":210,"33":33}

list1=[]

with open('Reduced_Assembly.txt', 'r') as file:
    # reading each line
    for line in file:

        # reading each word
        for word in line.split():
            # displaying the words
            list1.append(word)
print(list1)

with open('InstructionMemory.txt', 'w') as f:
    for elements in list1:
        if elements in instruction_dic:
            f.write('{0:09b}\n'.format(instruction_dic[elements]))
        elif elements in registers:
            f.write(str(registers[elements])+"\n")
        elif elements in other:
            f.write('{0:09b}\n'.format(other[elements]))
        elif elements=="EXIT":
            f.write('{0:09b}'.format(75))
