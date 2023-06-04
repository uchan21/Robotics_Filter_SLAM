import cv2
import numpy as np
import matplotlib.pyplot as plt

# Read the image
A = cv2.imread('/content/my_first_map.pgm', cv2.IMREAD_GRAYSCALE)

# Create a copy of the image
copyA = np.copy(A)

# Thresholding: Change the pixel for computer (will change map)
copyA[copyA < 210] = 1
copyA[copyA >= 210] = 0

# Obstacle probability range extend
input_value = 2  # parameter_Distance from robot center

for k in range(input_value + 1):
    copyA_temp = np.pad(copyA, ((1, 1), (1, 1)), mode='constant')  # Pad the array to simplify neighbor checks

    for i in range(1, copyA.shape[0] + 1):
        for j in range(1, copyA.shape[1] + 1):
            if copyA[i-1, j-1] == k + 1:
                if np.any(copyA_temp[i-1:i+2, j-1:j+2] != k + 1):
                    copyA_temp[i-1:i+2, j-1:j+2][copyA_temp[i-1:i+2, j-1:j+2] != k + 1] = k + 2

    copyA = np.copy(copyA_temp[1:-1, 1:-1])  # Remove padding from the updated copyA

# Change the pixel for visible (changed map)
copyA_vision = np.where(copyA > 0, 254, 0)

# Display the images
plt.figure(figsize=(10, 5))

plt.subplot(1, 2, 1)
plt.imshow(A, cmap='gray')
plt.title('Original Image')

plt.subplot(1, 2, 2)
plt.imshow(copyA_vision, cmap='gray')
plt.title('Changed Map')

plt.tight_layout()
plt.show()