## Introduction
Dotfiles are configuration files used to personalize and customize various aspects of your development environment. These files typically start with a dot (.) and are commonly found in your home directory (~). Managing dotfiles effectively is crucial for maintaining consistency and efficiency across different systems.

## Purpose
The purpose of this repository is to centralize and version control your dotfiles, allowing for easy synchronization and setup of your development environment across multiple machines.

```shell
git clone <repository_url> ~/.dotfiles
```

> Install Stow: If not already installed, install Stow, a symlink farm manager, which will help manage your dotfiles.

```shell
# On Debian/Ubuntu
sudo apt-get install stow
```

> Apply Dotfiles with Stow: Use Stow to symlink the dotfiles to your home directory.

```bash
cd ~/.dotfiles
stow .
```

**Customize:** Edit the dotfiles as needed to tailor your environment preferences. Add new configurations or remove existing ones according to your requirements.

## Updating Dotfiles
**Pull Changes:** Periodically pull changes from the remote repository to sync updates made by yourself or collaborators.

```bash
cd ~/.dotfiles
git pull origin main
```

> Apply Changes with Stow: Apply any new configurations or updates to your environment by re-running Stow.

```bash
stow -R .
```
