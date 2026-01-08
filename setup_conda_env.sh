#!/bin/bash
# Setup script for METR Time Horizon mamba environment
# This environment can run all commands in example_analysis.ipynb

set -e

ENV_NAME="metr-time-horizon"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "Setting up mamba environment: $ENV_NAME"
echo "=============================================="

# Check if mamba is available
if ! command -v mamba &> /dev/null; then
    echo "Error: mamba is not installed or not in PATH"
    echo "Please install Miniforge or Mambaforge first:"
    echo "  https://github.com/conda-forge/miniforge#miniforge"
    echo ""
    echo "Or install mamba into an existing conda installation:"
    echo "  conda install -n base -c conda-forge mamba"
    exit 1
fi

# Check if environment already exists
if mamba env list | grep -q "^$ENV_NAME "; then
    echo "Environment '$ENV_NAME' already exists."
    read -p "Do you want to remove and recreate it? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Removing existing environment..."
        mamba env remove -n "$ENV_NAME" -y
    else
        echo "Keeping existing environment. To update, run:"
        echo "  mamba env update -n $ENV_NAME -f environment.yml"
        exit 0
    fi
fi

# Create environment from environment.yml
echo ""
echo "Creating mamba environment from environment.yml..."
mamba env create -f "$SCRIPT_DIR/environment.yml"

# Activate environment and install local package
echo ""
echo "Installing local package (src) in editable mode..."
mamba run -n "$ENV_NAME" pip install -e "$SCRIPT_DIR"

# Register Jupyter kernel
echo ""
echo "Registering Jupyter kernel..."
mamba run -n "$ENV_NAME" python -m ipykernel install --user --name "$ENV_NAME" --display-name "Python ($ENV_NAME)"

echo ""
echo "=============================================="
echo "Setup complete!"
echo "=============================================="
echo ""
echo "To activate the environment, run:"
echo "  mamba activate $ENV_NAME"
echo ""
echo "To run the example notebook:"
echo "  1. mamba activate $ENV_NAME"
echo "  2. jupyter notebook example_analysis.ipynb"
echo ""
echo "Or in VS Code / Cursor:"
echo "  Select 'Python ($ENV_NAME)' as your kernel"
echo ""

