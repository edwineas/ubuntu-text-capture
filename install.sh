#!/bin/bash

# Set variables
PROJECT_DIR=$(pwd)
VENV_DIR="$PROJECT_DIR/venv"
REQUIREMENTS_FILE="$PROJECT_DIR/requirements.txt"
SCRIPT_PATH="$PROJECT_DIR/text_capture.sh"

# Function to set up the Python virtual environment
setup_venv() {
    if [ ! -d "$VENV_DIR" ]; then
        echo "Creating Python virtual environment..."
        python3 -m venv $VENV_DIR
    else
        echo "Virtual environment already exists."
    fi
    echo "Activating virtual environment..."
    source $VENV_DIR/bin/activate
}

# Function to install Python dependencies
install_python_dependencies() {
    echo "Installing Python dependencies..."
    pip install -r $REQUIREMENTS_FILE
}

# Deactivate virtual environment
deactivate_venv() {
    echo "Deactivating virtual environment..."
    deactivate
}

# Function to create the text_capture.sh script
create_script() {
    echo "Creating text_capture.sh script..."
    cat <<EOL > $SCRIPT_PATH
#!/bin/bash
source $VENV_DIR/bin/activate && python3 $PROJECT_DIR/main.py
EOL

    # Make it executable
    chmod +x $SCRIPT_PATH
}

# Main execution starts here
echo "Starting installation..."

# Set up Python virtual environment
setup_venv

# Install Python dependencies
install_python_dependencies

# Deactivate virtual environment
deactivate_venv

# Create text_capture.sh script
create_script

# Print the path to text_capture.sh for the user to copy
echo ""
echo "Installation completed successfully!"
echo "You can now use the following path to set up the keyboard shortcut manually:"
echo ""
echo "$SCRIPT_PATH"
echo ""
