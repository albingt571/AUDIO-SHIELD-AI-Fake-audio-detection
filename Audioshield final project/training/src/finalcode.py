import tensorflow as tf
from tensorflow import keras
from tensorflow.keras.layers import Conv1D, MaxPooling1D, LSTM, Dense
from librosa import load, feature
import os
import  numpy as np
from sklearn.model_selection import train_test_split
# Data Preprocessing Function (replace with yours)
def preprocess_data(data_path, sr=22050, n_mfcc=13):
  y, sr = load(data_path, sr=sr)
  mfccs = feature.mfcc(y=y, sr=sr, n_mfcc=n_mfcc)
  mfccs_scaled = mfccs.T  # Normalize and segment (replace with your approach)
  print(len(mfccs_scaled))
  print(type(mfccs_scaled))
  print(len(mfccs_scaled[0]))
  print(type(mfccs_scaled[0]))
  print("==============================")
  mfccs_scaled=mfccs_scaled[:65]
  l=[]
  if len(mfccs_scaled==65):
    for i in mfccs_scaled:
      for j in i:
        l.append(j)
  print(len(l))
  print("***********************")
  return l

# Load your real and fake audio data paths into separate lists

dir_list = os.listdir(r"D:\FAKEDETECTION\for-rerec\for-rerecorded\training\real")
real_data_paths = []
for i in dir_list:
  real_data_paths.append(r"D:\FAKEDETECTION\for-rerec\for-rerecorded\training\real/"+i)


dir_list = os.listdir(r"D:\FAKEDETECTION\for-rerec\for-rerecorded\training\fake")
fake_data_paths = []
for i in dir_list:
  fake_data_paths.append(r"D:\FAKEDETECTION\for-rerec\for-rerecorded\training\fake/"+i)
# Preprocess the data
real_data = []
for path in real_data_paths:

  r=preprocess_data(path)
  if len(r)==845:
    real_data.append(r)
  else:
    print("nnnnnnnnnnnnnnnnnnnnnnnnn")
fake_data = []
for path in fake_data_paths:
  r=preprocess_data(path)
  if len(r)==845:
    fake_data.append(r)
  else
    print("************88888888888888")
# Combine and convert data to NumPy arrays for model training
X = np.concatenate((real_data, fake_data))
X = np.expand_dims(X, axis=2)  # Add channel dimension for CNN

# Labels (1 for real, 0 for fake)
y = np.array([1] * len(real_data) + [0] * len(fake_data))

# Split data into training, validation, and test sets (e.g., 70%/15%/15%)
X_train, X_test, y_train,  y_test = train_test_split(X, y, test_size=0.3)
X_val=X_test
y_val=y_test
# Define the CNN-RNN Model
model = keras.Sequential([
  Conv1D(filters=32, kernel_size=3, activation='relu', input_shape=X_train.shape[1:]),
  MaxPooling1D(pool_size=2),
  LSTM(64, return_sequences=True),
  LSTM(32),
  Dense(1, activation='sigmoid')  # Sigmoid for binary classification
])

# Compile the model
model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])

# Train the model
model.fit(X_train, y_train, epochs=30, validation_data=(X_val, y_val))

# Evaluate the model on test set
loss, accuracy = model.evaluate(X_test, y_test)
print('Test Loss:', loss, 'Test Accuracy:', accuracy)

# Save the model (optional)
model.save('fake_audio_detector1.h5')
