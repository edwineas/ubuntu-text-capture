import os
import pytesseract
from PIL import Image
import pyperclip

def capture_screenshot():
    # Filepath for the screenshot
    screenshot_path = "/tmp/screenshot.png"

    # Capture a region using gnome-screenshot
    os.system(f"gnome-screenshot -a -f {screenshot_path}")

    # Open the screenshot
    screenshot = Image.open(screenshot_path)

    # Extract text from the screenshot using pytesseract
    text = pytesseract.image_to_string(screenshot)

    # Strip any trailing newlines and copy the cleaned text to the clipboard
    pyperclip.copy(text.strip())
    print("Text copied to clipboard:", text.strip())

    # Optionally, remove the screenshot file after use
    os.remove(screenshot_path)

if __name__ == "__main__":
    capture_screenshot()
