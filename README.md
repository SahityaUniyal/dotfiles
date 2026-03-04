# dotfiles

My dotfiles and automated dev environment setup for macOS and Linux

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
- `.zshrc_alias` - Custom aliases
- `.tmux.conf` - Tmux configuration
- `.vimrc` - Vim configuration
- `.p10k.zsh` - Powerlevel10k theme configuration
- `.config/nvim/` - Neovim configuration
- `.config/ghostty/` - Ghostty terminal configuration


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

## 🔧 Customization

### Adding New Dotfiles

Add your dotfiles (starting with `.`) to the `dotfiles/` directory - it will be automatically symlinked to `$HOME`.

### Adding .config Files

Add files or directories to `dotfiles/.config/` - they'll be automatically symlinked to `~/.config/`

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
