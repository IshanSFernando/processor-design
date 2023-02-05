# Processor Design

This processor is designed to down sample a given image by a given factor. The image maximum size should be 500 X 500. 
The Image loads into the processor and filters the high frequencies using 3X3 approximated Gaussian kernel and downsample it.

## Methodology
Processor design fulfils the following stages
1. Designing algorithm
2. Simulate the algorithm in Python
3. Determine the processor specification according to the task (Bus sizes, Memory Size
and the number of registers).
4. Design the ISA, Data path and control unit.
5. Rewrite the algorithm using the designed assembly language.
6. Implement the processor in Verilog
7. Simulate the processer in VIVADO.

## Down sampling Algorithm
When the image is down sampled, the neighbourhood area of a pixel maps into one pixel. Then the image can be completely different 
from the original image due to the high-frequency components of the picture. Therefore, the Image passes through a lowpass filter to
filter out high-frequency components and then down sample it. Lowpass filtering is achieved by convoluting the image with a gaussian kernel. 

However, the processor is designed to process only positive integer numbers. So Gaussian 2D kernel is approximated as follows.

![image](https://user-images.githubusercontent.com/68647363/216841691-85320edb-e4aa-415d-b854-f0ebca2f35a3.png)

The Gaussian kernel operates on only the required pixel to reduce processing power. Image feeds into the processor as a flat vector 
after adding padding of size one. The algorithm is designed to convolve that flat vector with a Gaussian kernel using one loop. 
2D visualization of the convolution is given below.

![image](https://user-images.githubusercontent.com/68647363/216841755-12e7de7f-2f96-42e3-857c-216ac21d166e.png)

Flatten Image

![image](https://user-images.githubusercontent.com/68647363/216841772-36f554ec-efea-4d50-a301-cf0e948b270c.png)

Each element in the array is replaced by the convolved value with a Gaussian kernel and this process is continued with 2 strides 
in all directions, excluding paddings.

## Results
![image](https://user-images.githubusercontent.com/68647363/216841481-819c4af7-3eeb-4f70-993e-9e16a6827b18.png)
