#!/bin/bash

# Check if dialog is installed
if ! command -v dialog &>/dev/null; then
    echo "Installing dialog..."
    sudo apt-get update
    sudo apt-get install -y dialog
fi

# Define common packages to choose from
PACKAGES=(
    "git" "Version control system" off
    "nala" "Apt Alternative" off
    "htop" "System monitor" off
    "tmux" "Terminal multiplexer" off
    "curl" "Data transfer tool" off
    "wget" "File download utility" off
    "tree" "Directory listing tool" off
    "net-tools" "Network utilities" off
    "openssh-server" "SSH server" off
    "python3" "Python programming language" off
    "python3-pip" "Python programming language Package Manager" off
    "build-essential" "Development tools" off
    "nodejs" "JavaScript runtime" off
    "docker.io" "Container platform" off
    "vlc" "Media player" off
    "micro" "TUI Text Editor" off

)

# Create temporary file for selections
TEMPFILE=$(mktemp)

# Display checklist dialog
dialog --title "Package Installer" \
    --checklist "Select packages to install (use SPACE to select):" 20 60 15 \
    "${PACKAGES[@]}" 2>"$TEMPFILE"

# Read selections
SELECTIONS=$(cat "$TEMPFILE")

# If user made selections
if [ -n "$SELECTIONS" ]; then
    # Remove quotes from selections
    SELECTIONS=$(echo "$SELECTIONS" | tr -d '"')

    # Install each selected package
    for package in $SELECTIONS; do
        dialog --infobox "Installing $package..." 5 40
        sudo apt-get install -y "$package" >/dev/null 2>&1

        if [ $? -eq 0 ]; then
            dialog --msgbox "$package installed successfully!" 5 40
        else
            dialog --msgbox "Failed to install $package" 5 40
        fi
    done

    dialog --msgbox "All selected packages have been processed." 5 40
fi

# Clean up
rm -f "$TEMPFILE"
clear
