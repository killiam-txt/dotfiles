#!/bin/bash
set -e

# colors
WHITE='\033[1;37m'
GRAY='\033[0;37m'
NC='\033[0m'

print_info() { echo -e "${WHITE}[INFO]${NC} $1"; }
print_success() { echo -e "${WHITE}[OK]${NC} $1"; }
print_error() { echo -e "${WHITE}[ERROR]${NC} $1"; }

clear
echo "╔══════════════════════════════════════╗"
echo "║       NixOS Config Installer         ║"
echo "╚══════════════════════════════════════╝"
echo
echo -e "${GRAY}This script will:${NC}"
echo "  1. Generate hardware-configuration.nix"
echo "  2. Clone your nixos-config repository"
echo "  3. Apply the configuration via nixos-rebuild"
echo

# confirmation gate
read -p "Are you sure you want to continue? (yes/N): " confirm
if [ "$confirm" != "yes" ]; then
    print_info "Installation aborted."
    exit 0
fi
echo

# verify NixOS
if [ ! -f /etc/nixos/configuration.nix ]; then
    print_error "This does not appear to be a NixOS system. Aborting."
    exit 1
fi

# generate hardware config
print_info "Generating hardware-configuration.nix..."
sudo nixos-generate-config --show-hardware-config > /tmp/hardware-configuration.nix
print_success "Hardware config generated."

# clone repository
if [ -d ~/nixos-config ]; then
    print_info "~/nixos-config already exists, skipping clone."
else
    print_info "Cloning nixos-config..."
    git clone https://github.com/killiam-txt/dotfiles ~/nixos-config
    print_success "Repository cloned."
fi

# replace hardware config
print_info "Replacing hardware-configuration.nix with current system's..."
cp /tmp/hardware-configuration.nix ~/nixos-config/nixos/hardware-configuration.nix
print_success "Hardware config replaced."

# apply configuration
print_info "Applying NixOS configuration..."
cd ~/nixos-config
sudo nixos-rebuild switch --flake ~/nixos-config#nixos
print_success "Configuration applied."

echo
echo "╔══════════════════════════════════════╗"
echo "║           Install complete!          ║"
echo "╚══════════════════════════════════════╝"
echo

# reboot prompt
read -p "Reboot now? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_info "Rebooting..."
    systemctl reboot
else
    print_info "Remember to reboot later."
fi