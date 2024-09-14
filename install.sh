PROJECT_DIR=$(pwd)
VENV_DIR="$PROJECT_DIR/venv"
REQUIREMENTS_FILE="$PROJECT_DIR/requirements.txt"
SCRIPT_PATH="$PROJECT_DIR/text_capture.sh"

setup_venv() {
    if [ ! -d "$VENV_DIR" ]; then
        echo "Creating Python virtual environment..."
        python3 -m venv venv
        echo "Activating virtual environment..."
        source venv/bin/activate
    else
        echo "Virtual environment already exists."
        echo "Activating virtual environment..."
        source $VENV_DIR/bin/activate
    fi
}

install_python_dependencies() {
    echo "Installing Python dependencies..."
    pip install -r $REQUIREMENTS_FILE
}

deactivate_venv() {
    echo "Deactivating virtual environment..."
    deactivate
}

create_script() {
    echo "Creating text_capture.sh script..."
    cat <<EOL > $SCRIPT_PATH
#!/bin/bash
source $VENV_DIR/bin/activate && python3 $PROJECT_DIR/main.py
EOL

    chmod +x $SCRIPT_PATH
}

echo "Starting installation..."

setup_venv

install_python_dependencies

deactivate_venv

create_script

echo ""
echo "Installation completed successfully!"
echo "You can now use the following path to set up the keyboard shortcut manually:"
echo ""
echo "$SCRIPT_PATH"
echo ""
