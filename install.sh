#!/bin/bash
# Exit on error
set -e

INSTALLER=""
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

install_homebrew() {
	if ! command -v brew &>/dev/null; then
		echo "Installing Homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

		# Add Homebrew to PATH for Apple Silicon Macs
		if [[ $(uname -m) == "arm64" ]]; then
			echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
			eval "$(/opt/homebrew/bin/brew shellenv)"
		fi

		echo "Homebrew installed successfully!"
	else
		echo "Homebrew is already installed"
	fi
}

set_installer() {
	# Detect OS and set package manager
	if [[ "$OSTYPE" == "darwin"* ]]; then
		echo "Detected macOS"
		install_homebrew
		INSTALLER="brew"

	elif [[ -f /etc/os-release ]]; then
		. /etc/os-release

		if [[ "$ID" == "ubuntu" ]] || [[ "$ID_LIKE" == *"ubuntu"* ]] || [[ "$ID_LIKE" == *"debian"* ]]; then
			echo "Detected Ubuntu/Debian-based system"
			INSTALLER="apt"

		elif [[ "$ID" == "fedora" ]]; then
			echo "Detected Fedora"
			INSTALLER="dnf"

		elif [[ "$ID" == "arch" ]] || [[ "$ID_LIKE" == *"arch"* ]]; then
			echo "Detected Arch-based system"
			INSTALLER="pacman"

		else
			echo "Detected Linux distribution: $ID"
			echo "Unsupported distribution"
			exit 1
		fi
	else
		echo "Unable to detect operating system"
		exit 1
	fi
	echo "Package manager set to: $INSTALLER"
}

# Function to install packages
install_package() {
	local package=$1
	echo "Installing $package..."

	if [[ "$INSTALLER" == "brew" ]]; then
		brew list "$package" &>/dev/null || brew install "$package"
	elif [[ "$INSTALLER" == "apt" ]]; then
		sudo apt-get install -y "$package"
	elif [[ "$INSTALLER" == "dnf" ]]; then
		sudo dnf install -y "$package"
	elif [[ "$INSTALLER" == "pacman" ]]; then
		sudo pacman -S --noconfirm "$package"
	fi
}

# Function to create symlink
create_symlink() {
	local source=$1
	local target=$2

	if [ -e "$target" ] && [ ! -L "$target" ]; then
		echo "Backing up existing file: $target to ${target}.backup"
		mv "$target" "${target}.backup"
	fi

	ln -sfn "$source" "$target"
	echo "Symlinked: $target -> $source"
}

oh_my_zsh_install() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        echo "Oh My Zsh installed successfully!"
    else
        echo "Oh My Zsh is already installed"
    fi
}

oh_my_zsh_plugins_setup() {
    local plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    local theme_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    
    # Install zsh-autosuggestions plugin
    if [ ! -d "$plugin_dir" ]; then
        echo "Installing zsh-autosuggestions plugin..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$plugin_dir"
        echo "zsh-autosuggestions installed successfully!"
    else
        echo "zsh-autosuggestions plugin already installed"
    fi
    
    # Install Powerlevel10k theme
    if [ ! -d "$theme_dir" ]; then
        echo "Installing Powerlevel10k theme..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$theme_dir"
        echo "Powerlevel10k installed successfully!"
    else
        echo "Powerlevel10k theme already installed"
    fi
}

# Start the installation process
set_installer

# Install packages
package_list=(
	"git"
	"zsh"
	"tmux"
	"neovim"
	"npm"
	"ripgrep"
	"jq"
)
for package in "${package_list[@]}"; do
	install_package "$package"
done

# Install Oh My Zsh
oh_my_zsh_install

# Install Oh My Zsh plugins
oh_my_zsh_plugins_setup

# Setup dotfiles (after plugins to avoid conflicts)
echo "Setting up dotfiles..."
if [ -d "$DOTFILES_DIR" ]; then
	# Explicit allowlist of dotfiles to symlink
	DOTFILES_HOME=(
		".zshrc"
		".tmux.conf"
		".vimrc"
		".p10k.zsh"
	)
	
	for file in "${DOTFILES_HOME[@]}"; do
		if [ -f "$DOTFILES_DIR/$file" ]; then
			create_symlink "$DOTFILES_DIR/$file" "$HOME/$file"
		fi
	done
	
	# Setup .config directory
	if [ -d "$DOTFILES_DIR/.config" ]; then
		echo "Setting up .config directory..."
		# Create .config directory if it doesn't exist
		mkdir -p "$HOME/.config"
		
		# Symlink each subdirectory in .config
		for config_dir in "$DOTFILES_DIR/.config"/*; do
			if [ -d "$config_dir" ]; then
				dirname=$(basename "$config_dir")
				create_symlink "$config_dir" "$HOME/.config/$dirname"
			fi
		done
	fi
else
	echo "Dotfiles directory not found at $DOTFILES_DIR"
fi

echo "Initial Setup Complete! Please restart your terminal."
