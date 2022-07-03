import numpy as np
from PIL import Image
import cv2 

image = np.array(Image.open('F:/All_works/Download/smile_cat.jpg').convert('L'))
col=len(image[0])
row=len(image)

if col>256:
    col = 256
    img = Image.open('F:/All_works/Download/smile_cat.jpg').convert('L')
    wpercent = (col / float(img.size[0]))
    row = int((float(img.size[1]) * float(wpercent)))
elif row>256:
    row = 256
    img = Image.open('F:/All_works/Download/smile_cat.jpg').convert('L')
    hpercent = (row / float(img.size[1]))
    col = int((float(img.size[0]) * float(hpercent)))


bnd=(col+2)*(row+2)

f = open('F:/All_works/Desktop/project/output_sunday_tree.txt', 'r')
Lines = f.readlines()

im=[]

for i in range (bnd):
    im.append(int(Lines[i][:9],2))



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
print(downsampled.shape)

original = cv2.imread("F:/All_works/Download/smile_cat.jpg")
down_sampled_image = cv2.imread("./downsampled.png")

cv2.imshow("down_sampled image",down_sampled_image)
cv2.imshow("original image",original)
cv2.waitKey(0) 
cv2.destroyAllWindows() 
