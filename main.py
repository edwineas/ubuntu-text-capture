import os
import pytesseract
from PIL import Image
import pyperclip

def capture_screenshot():
    screenshot_path = "/tmp/screenshot.png"

    os.system(f"gnome-screenshot -a -f {screenshot_path}")

    screenshot = Image.open(screenshot_path)

    text = pytesseract.image_to_string(screenshot, lang='eng')

    pyperclip.copy(text.strip())
    print("Text copied to clipboard:", text.strip())

    os.remove(screenshot_path)

if __name__ == "__main__":
    capture_screenshot()
