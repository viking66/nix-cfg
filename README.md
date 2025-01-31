# Dotfiles & Home Manager Configuration

## First-Time Setup

1. Install Nix:
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. Enable flakes:
```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

3. Clone using a temporary shell with git:
```bash
nix shell nixpkgs#git -c bash -c 'git clone https://github.com/viking66/nix-cfg.git ~/.config/nix-cfg'
cd ~/.config/nix-cfg
```

4. Copy private age key to ./key.txt

5. Install configuration:
```bash
nix run .#install
```

## Daily Usage

After initial setup, update configuration with:
```bash
nix run .#install
```

## Structure

- `home/home.nix`: Home Manager configuration
- `dotfiles/`: Original dotfiles
- `flake.nix`: Nix flake configuration

## Encrypting sensitive data
```bash
age -r $(age-keygen -y key.txt) ~/.ssh/id_rsa > keys/id_rsa.age
```
