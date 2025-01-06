import tensorflow as tf
from tensorflow import keras
from tensorflow.keras.layers import Conv1D, MaxPooling1D, LSTM, Dense
from librosa import load, feature
import os
import numpy as np
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix, ConfusionMatrixDisplay, precision_score, recall_score, f1_score

def preprocess_data(data_path, sr=22050, n_mfcc=13):
    y, sr = load(data_path, sr=sr)
    mfccs = feature.mfcc(y=y, sr=sr, n_mfcc=n_mfcc)
    mfccs_scaled = mfccs.T  # Normalize and segment (replace with your approach)
    mfccs_scaled = mfccs_scaled[:65]
    processed_data = []
    for segment in mfccs_scaled:
        processed_data.extend(segment)
    return processed_data

# Load your real and fake audio data paths into separate lists
real_data_paths = [
    os.path.join("D:\\FAKEDETECTION\\for-rerec\\for-rerecorded\\training\\real", i)
    for i in os.listdir("D:\\FAKEDETECTION\\for-rerec\\for-rerecorded\\training\\real")
]
fake_data_paths = [
    os.path.join("D:\\FAKEDETECTION\\for-rerec\\for-rerecorded\\training\\fake", i)
    for i in os.listdir("D:\\FAKEDETECTION\\for-rerec\\for-rerecorded\\training\\fake")
]

real_data_paths1 = [
    os.path.join("D:\\FAKEDETECTION\\for-rerec\\for-rerecorded\\testing\\real", i)
    for i in os.listdir("D:\\FAKEDETECTION\\for-rerec\\for-rerecorded\\testing\\real")
]
fake_data_paths1 = [
    os.path.join("D:\\FAKEDETECTION\\for-rerec\\for-rerecorded\\testing\\fake", i)
    for i in os.listdir("D:\\FAKEDETECTION\\for-rerec\\for-rerecorded\\testing\\fake")
]

real_data_paths2 = [
    os.path.join("D:\\FAKEDETECTION\\for-rerec\\for-rerecorded\\validation\\real", i)
    for i in os.listdir("D:\\FAKEDETECTION\\for-rerec\\for-rerecorded\\validation\\real")
]
fake_data_paths2 = [
    os.path.join("D:\\FAKEDETECTION\\for-rerec\\for-rerecorded\\validation\\fake", i)
    for i in os.listdir("D:\\FAKEDETECTION\\for-rerec\\for-rerecorded\\validation\\fake")
]

# Append additional paths to the existing lists
real_data_paths.extend(real_data_paths1)
fake_data_paths.extend(fake_data_paths1)
# Append additional paths to the existing lists
real_data_paths.extend(real_data_paths2)
fake_data_paths.extend(fake_data_paths2)

# Preprocess the data
real_data = [preprocess_data(path) for path in real_data_paths if len(preprocess_data(path)) == 845]
fake_data = [preprocess_data(path) for path in fake_data_paths if len(preprocess_data(path)) == 845]

# Combine and convert data to NumPy arrays for model training
X = np.concatenate((real_data, fake_data))
X = np.expand_dims(X, axis=2)  # Add channel dimension for CNN

# Labels (1 for real, 0 for fake)
y = np.array([1] * len(real_data) + [0] * len(fake_data))

# Split data into training, validation, and test sets (e.g., 70%/15%/15%)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3)
X_val, y_val = X_test, y_test

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

# Print input shape of the first layer
print("X_train shape:", X_train.shape)
print("Input shape of the first layer:", model.layers[0].input_shape)

# Train the model
history = model.fit(X_train, y_train, epochs=200, validation_data=(X_val, y_val))

# Save the graphs in a new folder named "graphs" (create if not exists)
graphs_folder = "newgraphs"
if not os.path.exists(graphs_folder):
    os.makedirs(graphs_folder)

# Plot training history (loss and accuracy) and save the images
plt.plot(history.history['loss'], label='Training Loss')
plt.plot(history.history['val_loss'], label='Validation Loss')
plt.xlabel('Epochs')
plt.ylabel('Loss')
plt.legend()
plt.savefig(os.path.join(graphs_folder, 'training_loss.png'))  # Save the image
plt.show()

plt.plot(history.history['accuracy'], label='Training Accuracy')
plt.plot(history.history['val_accuracy'], label='Validation Accuracy')
plt.xlabel('Epochs')
plt.ylabel('Accuracy')
plt.legend()
plt.savefig(os.path.join(graphs_folder, 'training_accuracy.png'))  # Save the image
plt.show()

# Evaluate the model on test set
loss, accuracy = model.evaluate(X_test, y_test)
print('Test Loss:', loss, 'Test Accuracy:', accuracy)

# Confusion Matrix and save the image
y_pred = model.predict(X_test)
y_pred = (y_pred > 0.5)
cm = confusion_matrix(y_test, y_pred)
disp = ConfusionMatrixDisplay(confusion_matrix=cm, display_labels=['Fake', 'Real'])
disp.plot(cmap=plt.cm.Blues)
plt.title('Confusion Matrix')
plt.savefig(os.path.join(graphs_folder, 'confusion_matrix.png'))  # Save the image
plt.show()

# Visualize test audio results with confidence and save the image for real audio
sample_idx = 0  # Choose a sample index to visualize
sample_audio = X_test[sample_idx]
sample_label = y_test[sample_idx]
confidence = model.predict(np.expand_dims(sample_audio, axis=0))[0][0]

plt.figure(figsize=(10, 5))
plt.subplot(2, 1, 1)
plt.plot(sample_audio)
plt.title('Test Real Audio')
plt.xlabel('Sample Index')
plt.ylabel('Amplitude')

plt.subplot(2, 1, 2)
plt.bar(['Fake', 'Real'], [1-confidence, confidence], color=['red', 'green'])
plt.title('Prediction Confidence (Real Audio)')
plt.xlabel('Class')
plt.ylabel('Confidence')

# Adjust spacing between subplots
plt.tight_layout()

plt.savefig(os.path.join(graphs_folder, 'sample_real_audio_prediction1.png'))  # Save the image
plt.show()

# Visualize test audio results with confidence and save the image for fake audio
fake_sample_idx = 0  # Choose a sample index to visualize
fake_sample_audio = X_test[fake_sample_idx]
fake_sample_label = y_test[fake_sample_idx]
fake_confidence = model.predict(np.expand_dims(fake_sample_audio, axis=0))[0][0]

plt.figure(figsize=(10, 5))
plt.subplot(2, 1, 1)
plt.plot(fake_sample_audio)
plt.title('Test Fake Audio')
plt.xlabel('Sample Index')
plt.ylabel('Amplitude')

plt.subplot(2, 1, 2)
plt.bar(['Fake', 'Real'], [1-fake_confidence, fake_confidence], color=['red', 'green'])
plt.title('Prediction Confidence (Fake Audio)')
plt.xlabel('Class')
plt.ylabel('Confidence')

# Adjust spacing between subplots
plt.tight_layout()

plt.savefig(os.path.join(graphs_folder, 'sample_fake_audio_prediction1.png'))  # Save the image
plt.show()

# Model Summary
model.summary()


# Test Accuracy and Confusion Matrix Metrics
precision = precision_score(y_test, y_pred)
recall = recall_score(y_test, y_pred)
f1 = f1_score(y_test, y_pred)
print('Test Accuracy:', accuracy)
print('Precision:', precision)
print('Recall:', recall)
print('F1 Score:', f1)

# Discussion and Analysis
print("Discussion and Analysis:")
print("The model achieved a test accuracy of {:.2f}.".format(accuracy))
print("Precision: {:.2f}, Recall: {:.2f}, F1 Score: {:.2f}".format(precision, recall, f1))
print("Insert your insights and analysis here...")

# Save the model (optional)
model.save('fake_audio_detector111.h5')
