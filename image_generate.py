import numpy as np
from PIL import Image

image = np.array(Image.open('test.jpg').convert('L'))
col=len(image[0])
row=len(image)

if col>256:
    col = 256
    img = Image.open('test.jpg').convert('L')
    wpercent = (col / float(img.size[0]))
    row = int((float(img.size[1]) * float(wpercent)))
elif row>256:
    row = 256
    img = Image.open('test.jpg').convert('L')
    hpercent = (row / float(img.size[1]))
    col = int((float(img.size[0]) * float(hpercent)))

f = open('processed.txt', 'r')
Lines = f.readlines()
print(len(Lines))
im=[]

for l in Lines:
    im.append(int(l[:9],2))

temp=[]
downsampled=[]
i=((1+col+1)+1)
j=1
while i<((col+2)*(row+2))-(col+2)-1:
    temp.append(im[i])
    i=i+2
    j=j+1
    if col%2==1:
        if j>col//2+1:
            j=1
            i=i+col+3
            downsampled.append(temp)
            temp=[]
    if col%2==0:
        if j>col//2:
            j=1
            i=i+col+4
            downsampled.append(temp)
            temp=[]

##print(downsampled)
downsampled=np.array(downsampled)
##print(downsampled.shape)
gr_im= Image.fromarray(downsampled).convert('P').save('downsampled.png')