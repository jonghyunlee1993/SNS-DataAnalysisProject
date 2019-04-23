import os, glob, csv
import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import find_peaks

# path = os.getcwd();
path = '/media/mnd/MnD_Lee_SSD/SNS_Data/'
Subjects = os.listdir(path)

for Sub in Subjects:
	os.chdir(path + Sub)
	ImageFiles = list()
	print(os.getcwd())

	WholeImages = glob.glob('./*jpg')

	PixelValueHolder = list()

	for ImgNum, Img in enumerate(WholeImages):

		if ImgNum%50 == 0:
			# print(ImgNum/len(WholeImages)*100, '% was done')
			print('{:.2%} was done'.format(ImgNum/len(WholeImages)))
		try:
			src = cv.imread(Img)
			rgb = cv.cvtColor(src, cv.COLOR_BGR2RGB)
			hsv = cv.cvtColor(src, cv.COLOR_BGR2HSV)

			r,g,b = cv.split(rgb)
			h,s,v = cv.split(hsv)

			hist = cv.calcHist(h, [0], None, [180], [0, 180])
			reshaped_hist = hist.reshape(-1)
			peaks, _ = find_peaks(reshaped_hist, height=0)
			
			# plt.plot(hist)
			# plt.plot(peaks, hist[peaks], 'x')
			# plt.show()

			mean_r = np.mean(r)
			mean_g = np.mean(g)
			mean_b = np.mean(b)

			h_peaks = len(peaks)
			mean_s = np.mean(s)
			mean_v = np.mean(v)

			ImgResult = [mean_r, mean_g, mean_b, h_peaks, mean_s, mean_v]
			ResultsHeader = ['R', 'G', 'B', 'H', 'S', 'V']

			try:
				with open (r'PixelValue_' + Sub + '.csv', 'a', newline='') as f:
					writer = csv.writer(f)
					if ImgNum == 0:
						writer.writerow(ResultsHeader)

					writer.writerow(ImgResult)

			except:
				print("ImgNum " + str(ImgNum) + ' was not successfully saved')
		except:
			print("ImgNum " + str(ImgNum) + ' was skipped')
			
	os.chdir(path)

print('Whole analyses were successfully done')