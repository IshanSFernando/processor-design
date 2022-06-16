import numpy as np
from PIL import Image
im = np.array(Image.open('flower.jpg').convert('L'))
print(im.shape)
col=len(im[0])
row=len(im)
gr_im= Image.fromarray(im).save('first_flower.png')
##print(im)

im=np.pad(im,1, mode='constant')
##print(im)

im=im.flatten(order='C')
##print(im)

i=((1+col+1)+1)
j=1
while i<((col+2)*(row+2))-(col+2)-1:
    c=im[i-1+col+2]
    a=2*im[i+col+2]
    c=c+a
    c=c+im[i+1+col+2]
    a=2*im[i-1]
    c=c+a
    a=4*im[i]
    c=c+a
    a=2*im[i+1]
    c=c+a
    c=c+im[i-1-col-2]
    a=2*im[i-col-2]
    c=c+a
    c=c+im[i+1-col-2]
    im[i]=c/16
    i=i+2
    j=j+1
    if col%2==1:
        if j>col//2+1:
            j=1
            i=i+col+3
    if col%2==0:
        if j>col//2:
            j=1
            i=i+col+4

##print(im)


####recrearing the downsampled image
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
gr_im= Image.fromarray(downsampled).save('downsampled_flower.png')
