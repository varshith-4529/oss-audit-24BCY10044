#!/bin/bash
# ============================================
# Script 2: FOSS Package Inspector
# Course: Open Source Software
# Purpose: Checks if a package is installed and displays philosophy note
# Demonstrates: Functions, package management, case statements
# ============================================

# Define the package name (change this to inspect other packages)
PACKAGE="libreoffice"

# Color codes for better output (optional)
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to check package on Debian/Ubuntu systems
check_package_debian() {
    if dpkg -l 2>/dev/null | grep -q "^ii  $PACKAGE "; then
        echo -e "${GREEN}✓ $PACKAGE is INSTALLED${NC}"
        echo ""
        echo "Package Details:"
        echo "----------------"
        dpkg -l | grep "$PACKAGE" | head -5
        echo ""
        echo "License Information:"
        echo "--------------------"
        apt-cache show "$PACKAGE" 2>/dev/null | grep -E "License|Version" | head -3
        return 0
    else
        echo -e "${RED}✗ $PACKAGE is NOT installed on this system${NC}"
        echo ""
        echo "You can install it using: sudo apt install $PACKAGE"
        return 1
    fi
}

# Function to check package on RedHat/Fedora systems
check_package_redhat() {
    if rpm -q "$PACKAGE" 2>/dev/null >/dev/null; then
        echo -e "${GREEN}✓ $PACKAGE is INSTALLED${NC}"
        echo ""
        echo "Package Details:"
        echo "----------------"
        rpm -qi "$PACKAGE" 2>/dev/null | grep -E "Name|Version|License|Summary"
        return 0
    else
        echo -e "${RED}✗ $PACKAGE is NOT installed on this system${NC}"
        echo ""
        echo "You can install it using: sudo dnf install $PACKAGE"
        return 1
    fi
}

# Detect package manager and call appropriate function
if command -v dpkg &>/dev/null; then
    check_package_debian
    INSTALLED=$?
elif command -v rpm &>/dev/null; then
    check_package_redhat
    INSTALLED=$?
else
    echo "Could not detect package manager. Please check manually."
    INSTALLED=1
fi

# Philosophy note using case statement
echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}          PHILOSOPHY NOTE${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

case "$PACKAGE" in
    libreoffice)
        echo "📄 LibreOffice:"
        echo "   Born from a community fork in 2010 when trust in corporate"
        echo "   stewardship failed. It proves that community governance matters more"
        echo "   than corporate ownership. The Document Foundation ensures no single"
        echo "   company can control the software millions depend on."
        echo ""
        echo "   \"The fork was a statement: code can be open, but governance must be too.\""
        ;;
    httpd|apache2)
        echo "🌐 Apache HTTP Server:"
        echo "   The web server that built the open internet. It's a testament"
        echo "   to collaborative development, running nearly 30% of websites worldwide."
        echo "   Apache proves that community-driven software can power critical infrastructure."
        ;;
    mysql|mariadb)
        echo "🗄️ MySQL/MariaDB:"
        echo "   The world's most popular open-source database. Its fork, MariaDB,"
        echo "   was created when Oracle acquired Sun, mirroring the LibreOffice story."
        echo "   A reminder that community resilience matters more than corporate ownership."
        ;;
    firefox)
        echo "🦊 Firefox:"
        echo "   A nonprofit's fight for an open web. Mozilla proves that"
        echo "   software can serve users, not just shareholders."
        echo "   Privacy, transparency, and user rights are not afterthoughts."
        ;;
    vlc)
        echo "🎬 VLC Media Player:"
        echo "   Built by students in Paris, VLC plays anything you throw at it."
        echo "   It's a testament to what happens when you give smart people"
        echo "   the freedom to solve problems without corporate constraints."
        ;;
    python*)
        echo "🐍 Python:"
        echo "   A language shaped entirely by community. The Python Software Foundation"
        echo "   ensures the language remains free, open, and governed by its users."
        echo "   \"Consensus-driven development\" is not just a phrase—it's practice."
        ;;
    git)
        echo "🔀 Git:"
        echo "   The tool Linus Torvalds built when proprietary version control failed him."
        echo "   It's proof that open source can create better solutions than any corporation."
        echo "   Git enabled the entire open source collaboration model we know today."
        ;;
    *)
        echo "Open source is about freedom, transparency, and community."
        echo "Every project has a story. Every contributor matters."
        echo "The software you use today exists because someone chose to share."
        ;;
esac

echo ""
echo -e "${YELLOW}Remember: Open source isn't just free software. It's freedom.${NC}"
echo ""

# Additional tip if package is not installed
if [ $INSTALLED -ne 0 ]; then
    echo "💡 Tip: Install $PACKAGE to explore its capabilities and contribute to the community."
fi
