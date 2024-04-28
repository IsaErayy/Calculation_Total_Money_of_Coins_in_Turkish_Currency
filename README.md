### **Calculator of total money of coins in Turkish currency.**

> **1.Introduction**

-> The main goal of the project is coin detection and calculating the total amount of money 
in the given input image. I followed some steps to detect the coins which are 
preprocessing of the image that includes edge detection, binarizing, morphological operations, 
and creating an algorithm that is based on the reference coin. Reference coin in this project
will be 1TL. And after determining reference coin, we sort the areas 
of the coins which detected in the image. After all, we create an algorithm according to the 
ratio which is “the area of the reference coin/sorted areas of the coins” with scaling it by
“sqrt()” operator. With respect to the scaled values, we create the ranges between (0,1) and,
we put the coin values on that ranges with some adjustment. Furthermore, we indicate the 
results on GUI application.GUI application is created by APP Designer.

> **2.Preprocessing and Analyzing Image**

-> To detect the coins we need some processes on the image.These processes are important 
because we need background and foreground relative to detect coins. These processes
includes grayscaling the image, edge detection, binarizing and morphological operations.

![image](https://github.com/IsaErayy/Calculation-Total-Money-of-Turkis-Coins-with-MATLAB/assets/162883392/aa2d684e-2d8b-401e-9fdf-e5391c8a8887)

> **3.Plotting Image Results**

-> The result image after image prepropcessing.  

![image](https://github.com/IsaErayy/Calculation-Total-Money-of-Turkis-Coins-with-MATLAB/assets/162883392/34760a47-6b34-45d5-82b4-18f9668bb167)

-> The result image that shows the circled coins, their vlaues and the total money of the input image.

![image](https://github.com/IsaErayy/Calculation-Total-Money-of-Turkis-Coins-with-MATLAB/assets/162883392/70aeb4fe-12ab-4cd1-9944-d18d69e3f709)

> **4.GUI Application Interface**

-> GUI Application Interface images are shown below.

> > **4.1- GUI applicaiton Interface**
> > 
![image](https://github.com/IsaErayy/Calculation-Total-Money-of-Turkis-Coins-with-MATLAB/assets/162883392/8e071b41-f56c-403a-b0dd-7a37fb7247c9)

> > **4.2- GUI after “Add an Image” button**
> > 
![image](https://github.com/IsaErayy/Calculation-Total-Money-of-Turkis-Coins-with-MATLAB/assets/162883392/82459587-b8ba-414e-8190-77347a1a0c3c)

> > **4.3- GUI after “Preprocessing” button**
> > 
![image](https://github.com/IsaErayy/Calculation-Total-Money-of-Turkis-Coins-with-MATLAB/assets/162883392/54d8a6d1-9b2c-4668-af77-eedf1aa8053d)

> > **4.4- GUI after “Calculator” button**
> > 
![image](https://github.com/IsaErayy/Calculation-Total-Money-of-Turkis-Coins-with-MATLAB/assets/162883392/0829bc81-5958-48d3-a7fc-5bd4bc64b123)

> **5. Strong and weak sides of the methods**

> > **Weak Sides**
> > > 1-) Changes in shadow, brightness and contrast in the background can cause some errors in our output.
This can happen when using a certain threshold value. For example, we set this threshold value to 0.2,
but it may not be appropriate for a different image.
To avoid such errors and to be able to apply operations more generally, we usually adjust for input
images whose background and brightness do not change much. That is, when choosing a particular
threshold value, we have generally performed our operations with images where the background and
brightness are similar.
To improve suggestions : We can use machine learning to solve this problem. We can build a model
for image segmentation tasks. We can train a model from a diverse dataset to learn the optimal
parameters for different types of images. Evolutionary neural networks are particularly effective for
these tasks.

> > > 2-) Since the difference in area between 0.05 and 0.1 coins is very small, in some pictures 0.05 TL can
be perceived as 0.1 TL and 0.1 TL as 0.05 TL.Also, the images where 1 TL’s are not in it does not
work.Because we adjusted the reference point according to the 1 TL’s area.

> > > -> The distortion effect due to background and not taking 1TL in the input image is shown below.
> > >  
![image](https://github.com/IsaErayy/Calculation-Total-Money-of-Turkis-Coins-with-MATLAB/assets/162883392/4f85474c-e417-4155-af0b-cd09bf50a185)

> > **Strong Sides**
> > > -> We reached very good efficiency with respect to the environment of the images we stated.
Also we had very good results in the situations where the coins are overpallapping on each
other. Our code still figured out detecting the coins.
> > > 
![image](https://github.com/IsaErayy/Calculation-Total-Money-of-Turkis-Coins-with-MATLAB/assets/162883392/f7f26807-e493-43d1-8f7f-52d30c257d4c)

> > > -> RMSE = sqrt [(Σ(Pi – Oi)²) / n]
Here, Pi denotes the predicted value, Oi represents the observed value, and n is the total
number of observations or data points. The sum of the squared differences between the
predicted and observed values is divided by the number of observations, and the square
root of the result is taken to yield the RMSE.According the 39 input image in our
dataset we have obtained RMSE value as “0.29”. This is very good result for an
experiment.






