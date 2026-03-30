#!/bin/bash
# ============================================
# Script 5: Open Source Manifesto Generator
# Course: Open Source Software
# Purpose: Generates a personalized open source philosophy statement
# Demonstrates: User input (read), file writing, here-documents, aliases
# ============================================

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Clear screen for better presentation
clear

# Display banner
echo -e "${BLUE}=========================================${NC}"
echo -e "${BLUE}   OPEN SOURCE MANIFESTO GENERATOR${NC}"
echo -e "${BLUE}=========================================${NC}"
echo ""
echo "This tool will help you create your personal"
echo "open source philosophy statement."
echo "Your answers will shape a manifesto that reflects"
echo "your relationship with open source software."
echo ""
echo -e "${YELLOW}Press Enter to begin...${NC}"
read

clear
echo -e "${BLUE}=========================================${NC}"
echo -e "${BLUE}   YOUR OPEN SOURCE JOURNEY${NC}"
echo -e "${BLUE}=========================================${NC}"
echo ""

# Collect user input with validation
echo "Question 1 of 4"
echo -e "${YELLOW}----------------------------------------${NC}"
read -p "Name one open-source tool you use every day: " TOOL
while [ -z "$TOOL" ]; do
    echo -e "${RED}Please enter a tool name:${NC}"
    read -p "Name one open-source tool you use every day: " TOOL
done

echo ""
echo "Question 2 of 4"
echo -e "${YELLOW}----------------------------------------${NC}"
read -p "In one word, what does 'freedom' mean to you? " FREEDOM
while [ -z "$FREEDOM" ]; do
    echo -e "${RED}Please enter one word:${NC}"
    read -p "In one word, what does 'freedom' mean to you? " FREEDOM
done

echo ""
echo "Question 3 of 4"
echo -e "${YELLOW}----------------------------------------${NC}"
read -p "Name one thing you would build and share freely: " BUILD
while [ -z "$BUILD" ]; do
    echo -e "${RED}Please enter something you'd build:${NC}"
    read -p "Name one thing you would build and share freely: " BUILD
done

echo ""
echo "Question 4 of 4"
echo -e "${YELLOW}----------------------------------------${NC}"
read -p "What is your name (for the manifesto)? " NAME
while [ -z "$NAME" ]; do
    echo -e "${RED}Please enter your name:${NC}"
    read -p "What is your name (for the manifesto)? " NAME
done

# Get current date
DATE=$(date "+%B %d, %Y")

# Set output filename with timestamp to avoid overwrites
TIMESTAMP=$(date "+%Y%m%d_%H%M%S")
OUTPUT="manifesto_${NAME// /_}_${TIMESTAMP}.txt"

# Clear screen and show generation message
clear
echo -e "${GREEN}Generating your manifesto...${NC}"
sleep 1

# Generate the manifesto using a here-document for clean multi-line output
cat > "$OUTPUT" << EOF
========================================
   OPEN SOURCE MANIFESTO
   Generated on $DATE
========================================

I, $NAME, believe in the power of open source.

Every day, I use $TOOL. This tool was built by people who chose
to share their work freely, trusting that collaboration creates
better software for everyone
