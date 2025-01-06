import os
import numpy as np
import matplotlib.pyplot as plt
from librosa import load, feature
from tensorflow import keras

# Preprocessing Function
def preprocess_data(data_path, sr=22050, n_mfcc=13):
    y, sr = load(data_path, sr=sr)
    mfccs = feature.mfcc(y=y, sr=sr, n_mfcc=n_mfcc)
    mfccs_scaled = mfccs.T  # Normalize and segment (replace with your approach)
    mfccs_scaled = mfccs_scaled[:65]
    processed_data = []
    for segment in mfccs_scaled:
        processed_data.extend(segment)
    return processed_data

# Load the trained model
model = keras.models.load_model('fake_audio_detector111.h5')

# Folder paths for real and fake audio files
real_folder_path = r"D:\FAKEDETECTION\for-rerec\for-rerecorded\testing\real"
fake_folder_path = r"D:\FAKEDETECTION\for-rerec\for-rerecorded\training\fake"

# Load real audio file paths
real_data_paths = [os.path.join(real_folder_path, filename) for filename in os.listdir(real_folder_path)]
# Load fake audio file paths
fake_data_paths = [os.path.join(fake_folder_path, filename) for filename in os.listdir(fake_folder_path)]

# Preprocess the data
real_data = [preprocess_data(path) for path in real_data_paths if len(preprocess_data(path)) == 845]
fake_data = [preprocess_data(path) for path in fake_data_paths if len(preprocess_data(path)) == 845]

# Choose a sample index for visualization
sample_idx = 0  # Choose a sample index to visualize

# Get the sample audio and its path for real and fake samples
sample_real_audio = real_data[sample_idx]
sample_real_audio_path = real_data_paths[sample_idx]
sample_fake_audio = fake_data[sample_idx]
sample_fake_audio_path = fake_data_paths[sample_idx]

# Predict confidence using the model for real and fake samples
real_confidence = model.predict(np.expand_dims(sample_real_audio, axis=0))[0][0]
fake_confidence = model.predict(np.expand_dims(sample_fake_audio, axis=0))[0][0]

# Visualize the sample audio and prediction confidence for real sample
plt.figure(figsize=(10, 5))

plt.subplot(2, 1, 1)
plt.plot(sample_real_audio)
plt.title('Sample Real Audio')
plt.xlabel('Sample Index')
plt.ylabel('Amplitude')

plt.subplot(2, 1, 2)
plt.bar(['Fake', 'Real'], [1-real_confidence, real_confidence], color=['red', 'green'])
plt.title('Prediction Confidence (Real Audio)')
plt.xlabel('Class')
plt.ylabel('Confidence')

# Adjust spacing between subplots
plt.tight_layout()

# Save the plot to the "graphs" folder
graphs_folder = "graphs"
if not os.path.exists(graphs_folder):
    os.makedirs(graphs_folder)
plt.savefig(os.path.join(graphs_folder, 'sample_real_audio_prediction.png'))

plt.show()

# Visualize the sample audio and prediction confidence for fake sample
plt.figure(figsize=(10, 5))

plt.subplot(2, 1, 1)
plt.plot(sample_fake_audio)
plt.title('Sample Fake Audio')
plt.xlabel('Sample Index')
plt.ylabel('Amplitude')

plt.subplot(2, 1, 2)
plt.bar(['Fake', 'Real'], [1-fake_confidence, fake_confidence], color=['red', 'green'])
plt.title('Prediction Confidence (Fake Audio)')
plt.xlabel('Class')
plt.ylabel('Confidence')

# Adjust spacing between subplots
plt.tight_layout()

# Save the plot to the "graphs" folder
plt.savefig(os.path.join(graphs_folder, 'sample_fake_audio_prediction.png'))

plt.show()
