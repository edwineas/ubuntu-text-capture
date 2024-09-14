#!/bin/bash

# Set variables
PROJECT_DIR=$(pwd)
VENV_DIR="$PROJECT_DIR/venv"
REQUIREMENTS_FILE="$PROJECT_DIR/requirements.txt"
SCRIPT_PATH="$PROJECT_DIR/text_capture.sh"

# Create virtual environment
echo "Creating virtual environment..."
python3 -m venv $VENV_DIR

# Activate virtual environment and install dependencies
echo "Activating virtual environment and installing Python dependencies..."
source $VENV_DIR/bin/activate
pip install -r $REQUIREMENTS_FILE

# Deactivate virtual environment
echo "Deactivating virtual environment..."
deactivate

# Create the script for text capture
echo "Creating text_capture.sh script..."
cat <<EOL > text_capture.sh
#!/bin/bash
source $VENV_DIR/bin/activate && python3 $PROJECT_DIR/main.py
EOL

# Make it executable
chmod +x text_capture.sh

# Set up GNOME shortcut
echo "Setting up GNOME shortcut..."

CURRENT_BINDINGS=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

if [[ "$CURRENT_BINDINGS" != *"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"* ]]; then
    if [[ "$CURRENT_BINDINGS" == "@as []" ]]; then
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
    else
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "${CURRENT_BINDINGS%,*}, '/org/gnome/settings-daemon/plugins-media-keys/custom-keybindings/custom0/']"
    fi
fi

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'text-capture'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "$SCRIPT_PATH"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Shift><Ctrl>T'

echo "Shortcut for 'text-capture' added successfully!"
echo "You can now use 'Shift + Ctrl + T' to trigger text capture."
