import numpy as np
from PIL import Image
im = np.array(Image.open('test.jpg').convert('L'))
print(im.shape)

col=len(im[0])
row=len(im)

if col>256:   ####################change bigger images to 256 size while maintaining the aspect ratio##################
    basewidth = 256
    img = Image.open('test.jpg').convert('L')
    wpercent = (basewidth / float(img.size[0]))
    hsize = int((float(img.size[1]) * float(wpercent)))
    img = img.resize((basewidth, hsize), Image.ANTIALIAS)
    im=np.array(img)
    print(im.shape)
elif row>256:
    baseheight = 256
    img = Image.open('test.jpg').convert('L')
    hpercent = (baseheight / float(img.size[1]))
    wsize = int((float(img.size[0]) * float(hpercent)))
    img = img.resize((wsize, baseheight), Image.ANTIALIAS)
    im = np.array(img)
    print(im.shape)

col=len(im[0])
row=len(im)

gr_im= Image.fromarray(im).save('first_flower.png')
##print(im)

im=np.pad(im,1, mode='constant')
##print(im)

im=im.flatten(order='C')
##print(im)

print(len(im))

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

#################save processed values in a text file###################################
f = open("processed.txt", "w")
for i in range (len(im)-1):
    f.write('{0:09b}\n'.format(im[i]))
f.write('{0:09b}'.format(im[len(im)-1]))
f.close()
