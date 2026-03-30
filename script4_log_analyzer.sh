#!/bin/bash
# ============================================
# Script 4: Log File Analyzer
# Course: Open Source Software
# Purpose: Analyzes a log file for error messages
# Demonstrates: While-read loops, counters, command-line arguments
# ============================================

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Usage function
usage() {
    echo "Usage: $0 <logfile> [keyword]"
    echo ""
    echo "Arguments:"
    echo "  logfile   - Path to log file to analyze (required)"
    echo "  keyword   - Search term (optional, default: 'error')"
    echo ""
    echo "Examples:"
    echo "  $0 /var/log/syslog"
    echo "  $0 /var/log/syslog warning"
    echo "  $0 /var/log/auth.log failed"
    exit 1
}

# Check if logfile argument is provided
if [ $# -lt 1 ]; then
    echo -e "${RED}Error: Log file path is required${NC}"
    usage
fi

# Assign variables from command-line arguments
LOGFILE="$1"
KEYWORD="${2:-error}"  # Default to 'error' if not provided
COUNT=0
LINE_NUM=0

# Declare an array to store matching lines
MATCHING_LINES=()

# Check if file exists
if [ ! -e "$LOGFILE" ]; then
    echo -e "${RED}Error: File '$LOGFILE' does not exist.${NC}"
    exit 1
fi

# Check if file is readable
if [ ! -r "$LOGFILE" ]; then
    echo -e "${RED}Error: File '$LOGFILE' is not readable.${NC}"
    echo "Try running with: sudo $0 $LOGFILE $KEYWORD"
    exit 1
fi

# Check if file is empty and retry
if [ ! -s "$LOGFILE" ]; then
    echo -e "${YELLOW}Warning: Log file '$LOGFILE' is empty.${NC}"
    echo -n "Retrying in 2 seconds... (Press Ctrl+C to cancel)"
    for i in 1 2; do
        echo -n "."
        sleep 1
    done
    echo ""
    if [ ! -s "$LOGFILE" ]; then
        echo -e "${RED}File is still empty. Exiting.${NC}"
        exit 0
    fi
fi

# Header
echo -e "${BLUE}=========================================${NC}"
echo -e "${BLUE}         LOG FILE ANALYZER${NC}"
echo -e "${BLUE}=========================================${NC}"
echo ""
echo "Log File: $LOGFILE"
echo "Keyword:  '$KEYWORD' (case-insensitive)"
echo "Date:     $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# Main analysis - while-read loop to process file line by line
while IFS= read -r LINE; do
    LINE_NUM=$((LINE_NUM + 1))
    # Check if line contains keyword (case-insensitive)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))
        # Store line with line number for later display
        MATCHING_LINES+=("$LINE_NUM:$LINE")
    fi
done < "$LOGFILE"

# Print summary
echo -e "${GREEN}-----------------------------------------${NC}"
echo -e "${GREEN}SUMMARY${NC}"
echo -e "${GREEN}-----------------------------------------${NC}"
echo "Total lines analyzed: $(wc -l < "$LOGFILE" | tr -d ' ')"
echo "Lines containing '$KEYWORD': $COUNT"

# Calculate percentage if total lines > 0
TOTAL_LINES=$(wc -l < "$LOGFILE" | tr -d ' ')
if [ $TOTAL_LINES -gt 0 ]; then
    PERCENTAGE=$(echo "scale=2; $COUNT * 100 / $TOTAL_LINES" | bc)
    echo "Percentage: ${PERCENTAGE}%"
fi
echo ""

# Show matching lines
if [ $COUNT -gt 0 ]; then
    echo -e "${YELLOW}Last ${COUNT} occurrences (showing up to 10):${NC}"
    echo -e "${YELLOW}-----------------------------------------${NC}"
    
    # Determine how many to show (max 10)
    SHOW_COUNT=$COUNT
    if [ $COUNT -gt 10 ]; then
        SHOW_COUNT=10
    fi
    
    # Show the last SHOW_COUNT matching lines
    START_INDEX=$(( ${#MATCHING_LINES[@]} - SHOW_COUNT ))
    if [ $START_INDEX -lt 0 ]; then
        START_INDEX=0
    fi
    
    for ((i = START_INDEX; i < ${#MATCHING_LINES[@]}; i++)); do
        # Split the stored line number and content
        LINE_INFO="${MATCHING_LINES[$i]}"
        LNUM=$(echo "$LINE_INFO" | cut -d':' -f1)
        CONTENT=$(echo "$LINE_INFO" | cut -d':' -f2-)
        echo "[Line $LNUM] $CONTENT"
    done
    
    if [ $COUNT -gt 10 ]; then
        echo ""
        echo "... and $((COUNT - 10)) more occurrences"
    fi
else
    echo -e "${GREEN}No lines containing '$KEYWORD' were found in the log file.${NC}"
fi

echo ""
echo -e "${BLUE}=========================================${NC}"

# Option to save results to file
echo ""
read -p "Save results to file? (y/n): " SAVE_RESULT
if [[ "$SAVE_RESULT" == "y" || "$SAVE_RESULT" == "Y" ]]; then
    OUTPUT_FILE="log_analysis_$(date '+%Y%m%d_%H%M%S').txt"
    {
        echo "Log Analysis Report"
        echo "==================="
        echo "Log File: $LOGFILE"
        echo "Keyword: $KEYWORD"
        echo "Date: $(date)"
        echo ""
        echo "Total lines: $TOTAL_LINES"
        echo "Matching lines: $COUNT"
        echo ""
        echo "Matching lines:"
        echo "---------------"
        for LINE_INFO in "${MATCHING_LINES[@]}"; do
            echo "$LINE_INFO"
        done
    } > "$OUTPUT_FILE"
    echo -e "${GREEN}Results saved to: $OUTPUT_FILE${NC}"
fi
