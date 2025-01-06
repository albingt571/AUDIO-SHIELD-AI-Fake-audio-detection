import tensorflow as tf
from tensorflow.keras.layers import Conv1D, MaxPooling1D, LSTM, Dense
from librosa import load, feature
import os
import numpy as np
from sklearn.model_selection import train_test_split

def preprocess_data(data_path, sr=22050, n_mfcc=13):
    y, sr = load(data_path, sr=sr)
    mfccs = feature.mfcc(y=y, sr=sr, n_mfcc=n_mfcc)
    mfccs_scaled = mfccs.T[:65].flatten()
    return mfccs_scaled

def load_data(directory):
    data_paths = [os.path.join(directory, f) for f in os.listdir(directory)]
    data = []
    for path in data_paths:
        processed_data = preprocess_data(path)
        if len(processed_data) == 845:
            data.append(processed_data)
    return data

real_data = load_data(r"D:\FAKEDETECTION\for-rerec\for-rerecorded\training\real")
fake_data = load_data(r"D:\FAKEDETECTION\for-rerec\for-rerecorded\training\fake")
X = np.concatenate((real_data, fake_data))
X = np.expand_dims(X, axis=2)
y = np.array([1] * len(real_data) + [0] * len(fake_data))
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

model = tf.keras.Sequential([
    Conv1D(filters=32, kernel_size=3, activation='relu', input_shape=X_train.shape[1:]),
    MaxPooling1D(pool_size=2),
    LSTM(64, return_sequences=True),
    LSTM(32),
    Dense(1, activation='sigmoid')
])
model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])
model.fit(X_train, y_train, epochs=30, validation_data=(X_test, y_test))

loss, accuracy = model.evaluate(X_test, y_test)
print('Test Loss:', loss, 'Test Accuracy:', accuracy)
model.save('fake_audio_detector1.h5')


