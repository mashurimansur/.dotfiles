# 🚀 **My Dotfiles**  

This repository contains my personal **dotfiles** for setting up and managing my development environment effortlessly. It includes configurations for **Zsh, Neovim, Git, Node.js, Go, and more**, making it easy to set up a fresh system in minutes.  

## 📌 **Features**
- 🔹 **Automated setup** with `install.sh`  
- 🔹 **Zsh + Oh My Zsh** with **Powerlevel10k**  
- 🔹 **Neovim configuration** for an enhanced development experience  
- 🔹 **Node.js & NVM installation** for JavaScript/TypeScript development  
- 🔹 **Go environment setup** with the latest version  
- 🔹 **Git configuration** with global aliases and settings  
- 🔹 **Stow-powered dotfiles management** for easy linking and portability  

---

## 🛠️ **Requirements**  
Ensure your system has the following installed before proceeding:  
- **Git** (`sudo apt install git -y`)  
- **GNU Stow** (`sudo apt install stow -y`)  
- **Zsh** (`sudo apt install zsh -y`)  

---

## 🚀 **Installation**  
To set up your environment, follow these steps:

### **1️⃣ Clone the Repository**
Run the following command to clone the dotfiles repository into your home directory:  
```bash
git clone https://github.com/mashurimansur/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### **2️⃣ Run the Installation Script**
Execute the `install.sh` script to automatically install dependencies and configure your system:  
```bash
bash install.sh
```

### **3️⃣ Use GNU Stow to Symlink Dotfiles**
The repository uses [GNU Stow](https://www.gnu.org/software/stow/) to manage symbolic links for configuration files.  

To link a specific configuration folder, use:  
```bash
stow {folder-name}
```
For example, to set up **Zsh and Neovim**:  
```bash
stow zsh
stow nvim
```
To apply all configurations at once:  
```bash
stow *
```

---

## ⚙️ **Included Configurations**  
| 📁 Folder  | 🛠️ Configuration |
|------------|-----------------|
| `zsh`      | Zsh + Oh My Zsh + Powerlevel10k |
| `nvim`     | Neovim (customized for development) |
| `gitconfig`| Git aliases and settings |
| `scripts/install_go.sh`       | Go environment setup |
| `scripts/install_zsh.sh`       | Installing ZSH, OhMyZSH and pluggins |
| `scripts/install_nvm.sh`      | NVM setup |
| `scripts/install_node.sh`      | NodeJS setup |

---

## 🔄 **Updating Dotfiles**
If you make changes to your configurations, you can update them by **pulling the latest version** from the repository and re-running the installation:
```bash
cd ~/.dotfiles
git pull origin main
bash install.sh
```

---

## 🛠️ **Customization**
You can modify any configuration file inside the `.dotfiles` folder. After making changes, reapply the settings using:
```bash
stow {modified-folder}
```

---

## 🔥 **Useful Commands**
| Command | Description |
|---------|-------------|
| `stow *` | Apply all configurations |
| `stow zsh` | Apply Zsh configuration only |
| `stow -D {folder}` | Unlink a configuration folder |
| `rm ~/.zshrc` | Remove existing `.zshrc` before applying new settings |
| `zsh` | Restart Zsh after applying new settings |

---

## ❓ **Troubleshooting**
- **Dotfiles not applying correctly?**  
  → Ensure you **remove existing config files** before stowing:  
  ```bash
  rm -rf ~/.zshrc ~/.gitconfig ~/.config/nvim
  ```

- **Changes not taking effect?**  
  → Restart your terminal or run:  
  ```bash
  exec zsh
  ```

- **Installation issues?**  
  → Run the script in debug mode:  
  ```bash
  bash -x install.sh
  ```

---

## 🎯 **Why Use Dotfiles?**
- ✅ **Consistency** across multiple machines  
- ✅ **Easily restorable** on new systems  
- ✅ **Custom environment** tailored to your workflow  
- ✅ **Portable & version-controlled** with Git  

---

## ❤️ **Contributing**
Feel free to fork this repository and submit pull requests if you have improvements or suggestions!

---

## 🐝 **License**
This project is open-source and available under the **MIT License**.

