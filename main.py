import os
import pytesseract
from PIL import Image, ImageOps
import pyperclip
import re

# --- CONFIGURATION: Preferred Languages per Script ---
SCRIPT_PREFERENCES = {
    'Latin': ['eng', 'fra', 'spa', 'deu', 'ita', 'por'],
    'Han': ['chi_sim', 'chi_tra', 'jpn'],
    'Cyrillic': ['rus', 'ukr', 'bul'],
    'Devanagari': ['hin', 'mar', 'nep'],
    'Arabic': ['ara', 'fas', 'urd'],
}

def get_available_languages():
    """Returns a set of all Tesseract languages installed on the system."""
    try:
        langs = pytesseract.get_languages(config='')
        return set(langs)
    except Exception:
        return {'eng'}

def preprocess_image(image):
    """
    Improves the image for OCR:
    1. Grayscale
    2. Upscale (2x) - Crucial for Arabic/Small text
    """
    # Convert to grayscale
    image = ImageOps.grayscale(image)
    
    # Resize (Scale up by 2)
    new_size = tuple(2 * x for x in image.size)
    image = image.resize(new_size, Image.Resampling.LANCZOS)
    
    return image

def capture_screenshot():
    screenshot_path = "/tmp/screenshot.png"
    
    # 1. Check installed languages
    installed_langs = get_available_languages()
    print(f"System Installed Languages: {installed_langs}")

    # 2. Capture Screenshot
    ret = os.system(f"gnome-screenshot -a -f {screenshot_path}")
    if ret != 0 or not os.path.exists(screenshot_path):
        return

    try:
        # Load and Preprocess
        original_image = Image.open(screenshot_path)
        processed_image = preprocess_image(original_image)

        lang_config = ""

        # 3. Try to Detect Script
        try:
            osd = pytesseract.image_to_osd(processed_image)
            script_match = re.search(r"Script: (\w+)", osd)
            script_name = script_match.group(1) if script_match else "Unknown"
            print(f"Detected Script: {script_name}")
            
            # Build specific config for detected script
            wish_list = SCRIPT_PREFERENCES.get(script_name, [])
            valid_langs = [l for l in wish_list if l in installed_langs]
            if 'eng' in installed_langs and 'eng' not in valid_langs:
                valid_langs.append('eng')
            
            if valid_langs:
                lang_config = "+".join(valid_langs)

        except pytesseract.TesseractError:
            print("Script detection failed (Image too small).")
            script_name = "Unknown"

        # 4. FALLBACK STRATEGY
        # If script detection failed OR returned no config, use ALL installed languages.
        if not lang_config:
            print("Fallback: Using ALL installed languages combined.")
            # Remove 'osd' from the list as it's not a text language
            usable_langs = [l for l in installed_langs if l != 'osd']
            lang_config = "+".join(usable_langs)

        print(f"Running OCR with configuration: [{lang_config}]")

        # 5. Perform OCR
        # --psm 6 assumes a single uniform block of text (good for screenshots)
        custom_config = r'--psm 6' 
        text = pytesseract.image_to_string(processed_image, lang=lang_config, config=custom_config)

        if text.strip():
            pyperclip.copy(text.strip())
            print("-" * 30)
            print(text.strip())
            print("-" * 30)
            os.system(f'notify-send "OCR Copied ({lang_config})" "Text copied to clipboard"')
        else:
            print("No text detected.")
            os.system('notify-send "OCR Failed" "No text detected."')

    except Exception as e:
        print(f"Error: {e}")
        os.system(f'notify-send "OCR Error" "{e}"')

    finally:
        if os.path.exists(screenshot_path):
            os.remove(screenshot_path)

if __name__ == "__main__":
    capture_screenshot()