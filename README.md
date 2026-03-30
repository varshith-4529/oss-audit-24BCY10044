# OSS Audit Project: LibreOffice

* **Student Name:** Kandaraboina Varshith 
* **Roll Number:** 24BCY10044
* **Course:** Open Source Software  
* **Date of Submission:** March 30, 2026

---

## * Table of Contents

1. [Project Overview](#project-overview)
2. [Chosen Software](#chosen-software)
3. [Scripts Overview](#scripts-overview)
4. [Installation & Dependencies](#installation--dependencies)
5. [How to Run the Scripts](#how-to-run-the-scripts)
6. [Script Details](#script-details)
7. [Troubleshooting](#troubleshooting)
8. [References](#references)
9. [Declaration](#declaration)

---

## * Project Overview

This capstone project is a comprehensive audit of an open-source software project. It combines philosophical analysis with practical Linux shell scripting to demonstrate understanding of open-source principles, licensing, governance, and system administration.

The project consists of two main components:

1. **Written Report:** A 12-16 page analysis covering the origin story, license, ethics, Linux footprint, ecosystem mapping, and comparison with proprietary alternatives of the chosen software.

2. **Five Shell Scripts:** Practical Linux scripts that demonstrate command-line proficiency and understanding of open-source tooling.

---

## * Chosen Software: LibreOffice

LibreOffice is a free and open-source office productivity suite. It was born in 2010 when the OpenOffice.org community forked the project in response to governance concerns following Oracle's acquisition of Sun Microsystems. Today, it is maintained by The Document Foundation, a non-profit organization that ensures the software remains community-driven and free from corporate control.

### Key Facts:

| Attribute | Details |
|-----------|---------|
| **License** | Mozilla Public License 2.0 (MPL 2.0) |
| **First Release** | September 28, 2010 |
| **Current Version** | 7.x |
| **Maintainer** | The Document Foundation |
| **Languages** | Available in over 120 languages |
| **Platforms** | Linux, Windows, macOS |

---

## * Scripts Overview

| Script | Filename | Purpose | Key Concepts |
|--------|----------|---------|--------------|
| Script 1 | `script1_system_identity.sh` | Displays system information like a welcome screen | Variables, command substitution, formatted output |
| Script 2 | `script2_package_inspector.sh` | Checks if LibreOffice is installed and displays details | Package management, case statements, functions |
| Script 3 | `script3_disk_auditor.sh` | Audits disk usage and permissions of system directories | Arrays, for loops, awk, du command |
| Script 4 | `script4_log_analyzer.sh` | Analyzes log files for error messages | While-read loops, counters, command-line arguments |
| Script 5 | `script5_manifesto_generator.sh` | Generates a personalized open-source philosophy | User input (read), file writing, here-documents |

---

## * Installation & Dependencies

### Operating System Requirements

- **Linux Distribution:** Ubuntu 20.04/22.04 LTS, Debian 11+, or any Debian-based distribution
- **Alternative:** Any Linux distribution with Bash 4.0+

### Required Packages

Run the following command to install all dependencies:

```bash
sudo apt update
sudo apt install -y bash libreoffice coreutils grep gawk# oss-audit-24BCY10044
