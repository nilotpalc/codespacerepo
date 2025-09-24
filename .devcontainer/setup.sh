#!/bin/bash

# Exit on any error
set -e

echo "🚀 Starting environment setup..."

# Install Python build dependencies first
echo "📦 Installing build dependencies..."
sudo apt-get update
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
libffi-dev liblzma-dev

# Install pyenv
echo "📥 Installing pyenv..."
curl -fsSL https://pyenv.run | bash

# Add pyenv to PATH for current session and future sessions
echo "🔧 Configuring pyenv..."
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Add to shell configuration files
{
    echo 'export PYENV_ROOT="$HOME/.pyenv"'
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"'
    echo 'eval "$(pyenv init -)"'
} >> ~/.bashrc

# Also add to .profile for non-bash shells
{
    echo 'export PYENV_ROOT="$HOME/.pyenv"'
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"'
    echo 'eval "$(pyenv init -)"'
} >> ~/.profile

# Initialize pyenv for current session
eval "$(pyenv init -)"

# Install Python 3.12 (latest stable)
echo "🐍 Installing Python 3.12..."
pyenv install 3.12.6 || {
    echo "⚠️  Python 3.12.6 installation failed, trying 3.12.0..."
    pyenv install 3.12.0
}

# Set as global default
echo "🔧 Setting Python 3.12 as global default..."
pyenv global $(pyenv versions --bare | grep "^3.12" | head -1)

# Verify pyenv installation
echo "✓ pyenv version: $(pyenv --version)"
echo "✓ Active Python: $(pyenv version)"

# Install pipx
echo "📦 Installing pipx..."
python -m pip install --user pipx
python -m pipx ensurepath

# Add pipx to PATH for current session
export PATH="$HOME/.local/bin:$PATH"

# Install Poetry using pipx
echo "📚 Installing Poetry..."
pipx install poetry

# Configure Poetry
poetry config virtualenvs.in-project true

# Verify installations
echo ""
echo "✅ Setup complete!"
echo "🐍 System Python: $(python3 --version)"
echo "🐍 pyenv Python: $(python --version)"
echo "📦 Poetry version: $(poetry --version)"
echo "🔧 pyenv version: $(pyenv --version)"
echo ""
echo "💡 Available Python versions:"
pyenv versions
echo ""
echo "💡 Useful commands:"
echo "   pyenv install 3.11.9     # Install another Python version"
echo "   pyenv local 3.11.9       # Set Python version for current project"
echo "   pyenv global 3.12.6      # Set global Python version"
echo "   poetry init              # Create new Poetry project"
echo "   poetry add package-name  # Install a package"
echo "   poetry shell             # Activate project environment"#!/bin/bash