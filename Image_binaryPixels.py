import numpy as np
from PIL import Image


im = np.array(Image.open('F:/All_works/Download/smile_cat.jpg').convert('L'))
print(im.shape)
col=len(im[0])
row=len(im)
if col>256:
    basewidth = 256
    img = Image.open('F:/All_works/Download/smile_cat.jpg').convert('L')
    wpercent = (basewidth / float(img.size[0]))
    hsize = int((float(img.size[1]) * float(wpercent)))
    img = img.resize((basewidth, hsize), Image.ANTIALIAS)
    im=np.array(img)
    print(im.shape)
elif row>256:
    baseheight = 256
    img = Image.open('F:/All_works/Download/smile_cat.jpg').convert('L')
    hpercent = (baseheight / float(img.size[1]))
    wsize = int((float(img.size[0]) * float(hpercent)))
    img = img.resize((wsize, baseheight), Image.ANTIALIAS)
    im = np.array(img)
    print(im.shape)

im=np.pad(im,1, mode='constant')


im=im.flatten(order='C')

f = open("smile_cat_binary.txt", "w")
for i in range (len(im)-1):
    f.write('{0:09b}\n'.format(im[i]))
f.write('{0:09b}'.format(im[len(im)-1]))


f.close()