import os
import FaceBlurr

path = os.getcwd() # when the pictures in the working directory 
# if the pictures in other directory such as ~/Desktop/my_picture
# path = '~/Desktop/my_picture'
FB = FaceBlurr

image_files = FB.image_cropper(path)
FB.face_detector(image_files, 0) # if (image_files, 1), you can see the output result using plt.show()