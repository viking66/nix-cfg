# Nix Home Manager Configuration

System-independent home directory and dotfiles management using Nix flakes and home-manager.

## Features
- Declarative configuration for dotfiles and packages
- Encrypted SSH and SOPS keys using age
- Cross-platform support (Linux/macOS)

## Setup

### Prerequisites
1. Install Nix:
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### Installation
1. Clone repository:
```bash
nix shell nixpkgs#git -c bash -c 'git clone https://github.com/viking66/nix-cfg.git ~/.config/nix-cfg'
cd ~/.config/nix-cfg
```

2. Add private age key:
- Copy your private age key to `./key.txt`

3. Apply configuration:
```bash
nix --extra-experimental-features "nix-command flakes" run .#install
```

## Usage

Update configuration:
```bash
nix run .#install
```

### Managing Secrets
Encrypt new sensitive files:
```bash
# SSH keys
age -r $(age-keygen -y key.txt) ~/.ssh/id_rsa > keys/id_rsa.age
age -r $(age-keygen -y key.txt) ~/.ssh/id_ed25519 > keys/id_ed25519.age

# SOPS key
age -r $(age-keygen -y key.txt) ~/.config/sops/age/key.txt > keys/sops.key.txt.age
```
