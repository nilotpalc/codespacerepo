#!/bin/bash

# Exit on any error
set -e

echo "🚀 Starting environment setup..."

# Install pyenv
echo "📥 Installing pyenv..."
curl -fsSL https://pyenv.run | bash

# Add pyenv to PATH
echo "🔧 Configuring pyenv..."
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

# Reload bash configuration
source ~/.bashrc

# Install Python build dependencies
echo "📦 Installing build dependencies..."
sudo apt-get update
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
libffi-dev liblzma-dev

# Install a single Python version (3.11.7 as default)
# echo "🐍 Installing Python 3.11.7..."
# pyenv install 3.12

# Set as global default
# pyenv global 3.11.7

# Install pipx
echo "📦 Installing pipx..."
python3 -m pip install --user pipx
python3 -m pipx ensurepath

# Add pipx to PATH in current session
export PATH="$HOME/.local/bin:$PATH"

# Install Poetry using pipx
echo "📚 Installing Poetry..."
pipx install poetry

# Configure Poetry
poetry config virtualenvs.in-project true

echo ""
echo "✅ Setup complete!"
echo "🐍 Python version: $(python3 --version)"
echo "📦 Poetry version: $(poetry --version)"
echo "🔧 pyenv version: $(pyenv --version)"
echo ""
echo "💡 Useful commands for later:"
echo "   pyenv install 3.10.12    # Install another Python version when needed"
echo "   pyenv local 3.10.12      # Set Python version for current project"
echo "   poetry init              # Create new Poetry project"
echo "   poetry add package-name  # Install a package"
