# Ubuntu Text Capture

A Python-based tool that allows you to capture a selected area of the screen, extract text from it using Tesseract OCR, and copy the extracted text directly to the clipboard. This tool provides functionality similar to the text extraction feature in Windows PowerToys.

## Features

- Capture a portion of the screen.
- Extract text from the captured screenshot using Tesseract OCR.
- Automatically copy the extracted text to the clipboard.

## Requirements

- **Ubuntu** or any Linux distribution with GNOME.
- Python 3.x.
- `gnome-screenshot` for capturing the screenshot.
- `Tesseract OCR` for extracting text.

## System Dependencies

You will need to install several dependencies manually. Here are the commands to install each component individually.

```bash
sudo apt update 
```
```bash
sudo apt install gnome-screenshot
```
```bash
sudo apt install tesseract-ocr 
```
```bash
sudo apt install libtesseract-dev
```
```bash
sudo apt install xclip
```
```bash
sudo apt install python3-venv
```


This command will:
- Update your package lists.
- Install all the required dependencies (`gnome-screenshot`, `tesseract-ocr`, `libtesseract-dev`, `xclip`, `dbus-x11`, and `python3-venv`).


## Installation

### 1. Clone the Repository

First, clone this repository to your local machine:

```bash
git clone https://github.com/edwineas/ubuntu-text-capture.git
```
or

```bash
git@github.com:edwineas/ubuntu-text-capture.git
```

```bash
cd ubuntu-text-capture
```


### 2. Run the Installation Script

The installation script will:
- Create a virtual environment and install the required Python dependencies.
- Create the `text_capture.sh` script, which you can use to run the tool manually or as part of a custom keyboard shortcut.

Run the following command:

```bash
sudo ./install.sh
```

### 3. Path to `text_capture.sh`

After running the installation script, the `text_capture.sh` script will be located at:

### 4. Manually Create a Keyboard Shortcut

To manually create a keyboard shortcut that triggers the text capture:

1. Open **Settings** > **Keyboard** > **View and Customize Shortcuts** > **Custom Shortcuts**.
2. Click **+** to add a new shortcut.
3. Set the **Name** to "Text Capture."
4. In the **Command** field, enter the full path to the `text_capture.sh` script (e.g., `/home/username/ubuntu-text-capture/text_capture.sh`).
5. Set the **Shortcut** to `Shift + Ctrl + T` (or your preferred key combination).
6. Save the shortcut.

Now, pressing the shortcut will trigger the text capture process.

## How to Use

Once the installation is complete, you can use the tool in two ways:

1. **Via Terminal**:
   
   Run the following command:

```bash
./text_capture.sh
```
You will be prompted to select a portion of the screen. The extracted text will be copied to your clipboard.

2. **Via Keyboard Shortcut** (if manually created):

Press `Shift + Ctrl + T` (or the custom shortcut you created) to activate the tool.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.


