import requests
import os
import csv
from PIL import Image
from io import BytesIO
import glob

# Replace <Subscription Key> with your valid subscription key.
subscription_key = "" # your subscription key
assert subscription_key

vision_base_url = "https://westcentralus.api.cognitive.microsoft.com/vision/v2.0/"
analyze_url = vision_base_url + "analyze"

dir_root = "/Path/to/data"
os.chdir(dir_root)
subjects = os.listdir()

for sub in subjects:
    os.chdir(sub)
    dir_sub = os.getcwd()
    print(os.getcwd())

    Whole_Images = glob.glob('*.jpg')
    for ImgNum, Image in enumerate(Whole_Images):

        if ImgNum % 50 == 0:
            print(ImgNum / len(Whole_Images) * 100, '% was done')

        try:
            Image_data = open(dir_sub + '/' + Image, "rb").read()  # '\\'
            # Image_data = open(dir_sub + '\\' + Image, "rb").read()

            headers = {'Ocp-Apim-Subscription-Key': subscription_key,
                       'Content-Type': 'application/octet-stream'}
            params = {'visualFeatures': 'Description'}  # only object recognition
            response = requests.post(analyze_url, headers=headers, params=params, data=Image_data)
            response.raise_for_status()

            # The 'analysis' object contains various fields that describe the Image. The most
            # relevant caption for the Image is obtained from the 'description' property.
            analysis = response.json()

            try:
                # save results into the csv file
                dateinfo = Image[2:8]
                fields = analysis["description"]["tags"]
                fields.insert(0, dateinfo)

                with open(r'Tag_results_' + sub + '.csv', 'a', newline='') as f:
                    writer = csv.writer(f)
                    writer.writerow(fields)
            except:
                print('The image number ' + str(ImgNum) + ' tags was not saved.')

            try:
                Image_caption = analysis["description"]["captions"][0]["text"].capitalize()

                with open(r'Caption_results_' + sub + '.csv', 'a', newline='') as ff:
                    writer = csv.writer(ff)
                    writer.writerow([Image_caption])
            except:
                print('The image number ' + str(ImgNum) + ' caption was not saved.')

        except:
            print('The image number ' + str(ImgNum) + ' was not analzed.')

    os.chdir(dir_root)

print('Whole Image recognition steps were done')

