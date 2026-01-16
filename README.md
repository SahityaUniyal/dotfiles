# dotfiles

My dotfiles and automated dev environment setup for macOS and Linux

## ✨ Features

- 🚀 **One-command setup** - Fully automated installation script
- 🔄 **Cross-platform** - Works on macOS, Ubuntu, Fedora, and Arch Linux
- 🔗 **Symlinked dotfiles** - Easy to manage and version control
- 🎨 **Beautiful terminal** - Zsh + Oh My Zsh + Powerlevel10k
- ⚡ **Modern dev tools** - Neovim, tmux, ripgrep, jq, and more

## 📦 What's Included

### Tools & Packages
- **Shell**: Zsh with Oh My Zsh
- **Theme**: Powerlevel10k
- **Plugins**: zsh-autosuggestions
- **Editor**: Neovim (with custom config)
- **Multiplexer**: tmux
- **Search**: ripgrep
- **JSON**: jq
- **Version Control**: git
- **JavaScript**: npm

### Dotfiles
- `.zshrc` - Zsh configuration
- `.tmux.conf` - Tmux configuration
- `.gitconfig` - Git configuration
- `.vimrc` - Vim configuration
- `.p10k.zsh` - Powerlevel10k theme configuration
- `.config/nvim/` - Neovim configuration

## 🚀 Quick Start

### Prerequisites
- macOS, Ubuntu, Fedora, or Arch Linux
- `git` installed
- `curl` installed (usually pre-installed)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Run the install script:
```bash
chmod +x install.sh
./install.sh
```

3. Restart your terminal

### First Time Setup

After installation:
- Run `p10k configure` to customize your Powerlevel10k theme (optional)
- Your configuration will be saved to `.p10k.zsh`

## 📁 Repository Structure

```
.
├── install.sh              # Main installation script
├── dotfiles/
│   ├── .zshrc             # Zsh configuration
│   ├── .tmux.conf         # Tmux configuration
│   ├── .gitconfig         # Git configuration
│   ├── .vimrc             # Vim configuration
│   ├── .p10k.zsh          # Powerlevel10k theme
│   └── .config/
│       └── nvim/          # Neovim configuration
└── README.md
```

## 🔧 Customization

### Adding New Dotfiles

1. Add your dotfile to the `dotfiles/` directory
2. Update the `DOTFILES_HOME` array in `install.sh`:
```bash
DOTFILES_HOME=(
    ".gitconfig"
    ".zshrc"
    ".tmux.conf"
    ".vimrc"
    ".p10k.zsh"
    ".your-new-file"  # Add here
)
```

### Adding .config Files

Simply add new directories to `dotfiles/.config/` - they'll be automatically symlinked to `~/.config/`

### Adding Packages

Add package names to the `package_list` array in `install.sh`:
```bash
package_list=(
    "git"
    "zsh"
    "tmux"
    "neovim"
    "your-package"  # Add here
)
```

## 🔄 Updating

To update your dotfiles:
```bash
cd ~/dotfiles
git pull
./install.sh  # Re-run to update symlinks
```

The install script is idempotent - safe to run multiple times.

## 🛠️ How It Works

1. **Detects your OS** and sets the appropriate package manager (brew/apt/dnf/pacman)
2. **Installs Homebrew** (macOS only) if not present
3. **Installs packages** using your system's package manager
4. **Installs Oh My Zsh** with plugins and themes
5. **Symlinks dotfiles** from the repo to your home directory
6. **Backs up existing files** with `.backup` extension before overwriting

## 💡 Tips

- All dotfiles are symlinked - edit them in the repo and changes apply immediately
- The script is idempotent - run it anytime to ensure everything is set up
- Commit your changes to version control for easy syncing across machines
