# Ubuntu Text Capture

A Python-based tool that allows you to capture a selected area of the screen, extract text from it using Tesseract OCR, and copy the extracted text directly to the clipboard. This tool provides functionality similar to the text extraction feature in Windows PowerToys.

## Features

- Capture a portion of the screen.
- Extract text from the captured screenshot using Tesseract OCR.
- Automatically copy the extracted text to the clipboard.
- Create a custom keyboard shortcut (`Shift + Ctrl + T`) to trigger the tool quickly.

## Requirements

- **Ubuntu** or any Linux distribution with GNOME.
- Python 3.x.

## System Dependencies

You will need to install several dependencies manually. Here are the commands to install each component individually.

```bash
sudo apt update 
```
```bash
sudo apt install gnome-screenshot
```
```bash
sudo apt install tesseract-ocr sudo apt install libtesseract-dev
```
```bash
sudo apt install xclip
```
```bash
sudo apt install dbus-x11
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
- Install system dependencies (`gnome-screenshot`, `tesseract-ocr`, `libtesseract-dev`, `dbus-x11`).
- Create a virtual environment and install the required Python dependencies.
- Set up a custom GNOME keyboard shortcut to trigger the tool.

Run the following command:

```bash
sudo ./install.sh
```

### 3. Verify the Setup

After the installation, you can test if the `text-capture` command is working by running:

```bash
./text_capture.sh
```


The tool will allow you to select a portion of the screen. After selecting, the extracted text will be copied to your clipboard.

## How to Use

Once the installation is complete, you can use the tool in two ways:

1. **Via Terminal**:
   
   Run the following command:

```bash
./text_capture.sh
```


You will be prompted to select a portion of the screen. The extracted text will be copied to your clipboard.

2. **Via Keyboard Shortcut**:

Press `Shift + Ctrl + T` to activate the tool. This shortcut will trigger the text capture process.

## Custom Keyboard Shortcut

The installation script automatically creates a custom GNOME keyboard shortcut (`Shift + Ctrl + T`) for launching the tool. 

If you wish to modify the shortcut, you can do so via the **Settings** > **Keyboard Shortcuts** section of your GNOME environment.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

