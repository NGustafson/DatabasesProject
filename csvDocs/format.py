import numpy as np

data1 = np.loadtxt("eng_faculty.txt", dtype = np.string_, delimiter = ",",skiprows = 2, usecols = (1, 2, 4))
data2 = np.loadtxt("eng_lect.txt", dtype = np.string_, delimiter = ",", skiprows = 2, usecols = (1, 2, 4))

#data1 = np.reshape(data1, (88, 1))

#data3 = np.zeros((44, 3))
#data3[0, :] = np.reshape(data, (44, 1))



np.savetxt("ENGR.csv", data1, fmt = '%s', delimiter = ",")
np.savetxt("temp2.txt", data2, fmt = '%s', delimiter = ",")