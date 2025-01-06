import tensorflow as tf
import numpy as np
from librosa import load, feature

# Function to preprocess new data
def preprocess_new_data(data_path, sr=22050, n_mfcc=13):
    print(data_path,"+++++++++++=========++++++")
    print(data_path,"+++++++++++=========++++++")
    print(data_path,"+++++++++++=========++++++")
    print(data_path,"+++++++++++=========++++++")
    y, sr = load(data_path, sr=sr)
    mfccs = feature.mfcc(y=y, sr=sr, n_mfcc=n_mfcc)
    mfccs_scaled = mfccs.T[:65]  # Assuming same preprocessing as training data
    # Flatten the MFCCs to match the shape expected by the model
    flattened_mfccs = mfccs_scaled.flatten()
    return np.expand_dims(flattened_mfccs, axis=0)  # Add batch dimension

# Load the trained model
model = tf.keras.models.load_model(r'D:\fakeaudio_detection\fakeaudio\fake_audio_detector.h5')

# Function to predict whether the audio is real or fake
def predict_audio(data_path, threshold=0.5):
    # Preprocess the new data
    processed_data = preprocess_new_data(data_path)
    # Predict using the loaded model
    prediction = model.predict(processed_data)
    # Determine the class based on the threshold
    if prediction >= threshold:
        class_label = 'Real'
    else:
        class_label = 'Fake'
    # Return the prediction and confidence level
    return class_label, prediction[0][0]
#
# # Example usage:
# new_audio_path = r"C:\Users\HP\Downloads\Recording.wav"
# prediction_label, confidence = predict_audio(new_audio_path)
# print("Prediction Label:", prediction_label)
# print("Confidence Level:", confidence)