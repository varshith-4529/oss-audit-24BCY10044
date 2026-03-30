#!/bin/bash
# ============================================
# Script 3: Disk and Permission Auditor
# Course: Open Source Software
# Purpose: Audits disk usage and permissions for system directories
# Demonstrates: Arrays, for loops, awk, du command
# ============================================

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Define an array of directories to audit
DIRS=(
    "/etc"
    "/var/log"
    "/home"
    "/usr/bin"
    "/tmp"
    "/opt"
    "/boot"
    "/var/lib"
)

# Define directories specific to chosen software
LIBREOFFICE_CONFIG_SYSTEM="/etc/libreoffice"
LIBREOFFICE_CONFIG_USER="$HOME/.config/libreoffice"

# Header
echo -e "${BLUE}=========================================${NC}"
echo -e "${BLUE}     DISK USAGE AND PERMISSIONS AUDIT${NC}"
echo -e "${BLUE}=========================================${NC}"
echo ""
echo "Audit Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Audit User: $(whoami)"
echo "Hostname:   $(hostname)"
echo ""

# Function to format size nicely
format_size() {
    local size=$1
    if [ -z "$size" ]; then
        echo "N/A"
    else
        echo "$size"
    fi
}

# Section 1: System Directories Audit
echo -e "${GREEN}--- SYSTEM DIRECTORIES AUDIT ---${NC}"
echo ""

# For loop to iterate through each directory in the array
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Get permissions, owner, group using ls -ld and awk
        PERMS=$(ls -ld "$DIR" 2>/dev/null | awk '{print $1, $3, $4}')
        # Get disk usage with du -sh and cut to extract size
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        # Count number of items in directory
        COUNT=$(ls -1 "$DIR" 2>/dev/null | wc -l)
        
        echo -e "${YELLOW}Directory:${NC} $DIR"
        echo "  Permissions (owner:group): $PERMS"
        echo "  Disk Usage: $(format_size "$SIZE")"
        echo "  Items Count: $COUNT"
        echo ""
    else
        echo -e "${RED}Directory:${NC} $DIR"
        echo "  Status: DOES NOT EXIST on this system"
        echo ""
    fi
done

# Section 2: LibreOffice Configuration Check
echo -e "${GREEN}--- LIBREOFFICE CONFIGURATION CHECK ---${NC}"
echo ""

# Check system-wide configuration
if [ -d "$LIBREOFFICE_CONFIG_SYSTEM" ]; then
    PERMS=$(ls -ld "$LIBREOFFICE_CONFIG_SYSTEM" | awk '{print $1, $3, $4}')
    SIZE=$(du -sh "$LIBREOFFICE_CONFIG_SYSTEM" 2>/dev/null | cut -f1)
    echo -e "${YELLOW}System Config:${NC} $LIBREOFFICE_CONFIG_SYSTEM"
    echo "  Permissions (owner:group): $PERMS"
    echo "  Disk Usage: $(format_size "$SIZE")"
    echo ""
    
    # List configuration files
    echo "  Configuration files (first 5):"
    ls -la "$LIBREOFFICE_CONFIG_SYSTEM" 2>/dev/null | head -6 | tail -5 | while read line; do
        echo "    $line"
    done
else
    echo -e "${YELLOW}System config not found at $LIBREOFFICE_CONFIG_SYSTEM${NC}"
fi

echo ""

# Check user configuration
if [ -d "$LIBREOFFICE_CONFIG_USER" ]; then
    PERMS=$(ls -ld "$LIBREOFFICE_CONFIG_USER" | awk '{print $1, $3, $4}')
    SIZE=$(du -sh "$LIBREOFFICE_CONFIG_USER" 2>/dev/null | cut -f1)
    echo -e "${YELLOW}User Config:${NC} $LIBREOFFICE_CONFIG_USER"
    echo "  Permissions (owner:group): $PERMS"
    echo "  Disk Usage: $(format_size "$SIZE")"
    echo ""
else
    echo -e "${YELLOW}User config not found. LibreOffice may not have been run yet.${NC}"
fi

# Section 3: Disk Usage Summary
echo -e "${GREEN}--- DISK USAGE SUMMARY ---${NC}"
echo ""

# Show overall disk usage
echo "Overall Filesystem Usage:"
df -h | grep -E "^/dev|Filesystem" | while read line; do
    echo "  $line"
done

echo ""
echo -e "${BLUE}=========================================${NC}"
echo -e "${BLUE}           AUDIT COMPLETE${NC}"
echo -e "${BLUE}=========================================${NC}"
