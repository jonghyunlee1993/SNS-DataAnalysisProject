def image_cropper(img_directory):

    import os

    path = img_directory

    image_files = list()

    jpg_files = [f for f in os.listdir(path) if f.endswith('.jpg')]
    if not jpg_files is None:
        image_files.extend(jpg_files)

    jpeg_files = [f for f in os.listdir(path) if f.endswith('.jpeg')]
    if not jpeg_files is None:
        image_files.extend(jpeg_files)

    png_files = [f for f in os.listdir(path) if f.endswith('.png')]
    if not png_files is None:
        image_files.extend(png_files)

    bmp_files = [f for f in os.listdir(path) if f.endswith('.bmp')]
    if not bmp_files is None:
        image_files.extend(bmp_files)
        
    print('There are {} image files in directory'.format(len(image_files)))

    return image_files

def face_detector(image_files, show_figure):

    import numpy as np
    import cv2 as cv

    save_directory() # chenking save directory

    for ind, name in enumerate(image_files):
        img = cv.imread(name)
        gray=cv.cvtColor(img, cv.COLOR_RGB2GRAY)

        my_path=r"/home/mnd/anaconda3/share/OpenCV/haarcascades/"
        face_cascade = cv.CascadeClassifier(my_path + 'haarcascade_frontalface_default.xml')

        faces = face_cascade.detectMultiScale(gray, 1.3, 5)
        result_image = img.copy()

        if len(faces) != 0:
            for (x,y,w,h) in faces:
                cv.rectangle(img,(x,y),(x+w,y+h),(255,0,0),2)
                roi_gray = gray[y:y+h, x:x+w]
                roi_color = img[y:y+h, x:x+w]
                blur_face = cv.GaussianBlur(roi_color,(23, 23), 30)
                # merge this blurry rectangle to our final image
                
                result_image[y:y+blur_face.shape[0], x:x+blur_face.shape[1]] = blur_face

            if show_figure == 1:
                import matplotlib.pyplot as plt

                plt.subplot(1,2,1)
                plt.imshow(img)
                plt.title('Before')

                plt.subplot(1,2,2)
                plt.title('After')
                plt.imshow(result_image)

                plt.show()

            face_img_save(ind, result_image)

        elif len(faces) == 0:
            print('Image file {} was not detected any face'.format(name)) 

            noface_img_save(ind, result_image)

def save_directory():
    import os

    if os.path.isdir('blurred_face'):
        print('Result directory alreday exist')
    else:
        os.makedirs('blurred_face')

    if os.path.isdir('noface'):
        print('Result directory alreday exist')

    else:
        os.makedirs('noface')

def face_img_save(ind, result_image):
    import shutil
    import cv2 as cv

    file_name = str(ind) + ".jpg"
    cv.imwrite(file_name, result_image)
    shutil.move(file_name, 'blurred_face')

def noface_img_save(ind, result_image):
    import shutil
    import cv2 as cv

    file_name = str(ind) + ".jpg"
    cv.imwrite(file_name, result_image)
    shutil.move(file_name, 'noface')