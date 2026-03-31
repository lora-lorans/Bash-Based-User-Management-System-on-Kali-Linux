# User Creation Bash Script

## Overview

This is a basic Bash script that manually creates a new user on a Linux system **without using standard tools** like `useradd` or `adduser`.

It works by directly modifying system files such as `/etc/passwd` and `/etc/group`, and then sets up the user environment.

---

## Features

- Checks if the user already exists  
- Generates a new UID automatically  
- Adds the user to system files  
- Creates a home directory  
- Assigns the user to groups  
- Sets a password for the user  

---

## Usage
1. Run the script as root:  bash
sudo ./your_script.sh

## How It Works

### 1. Generate User ID (UID)
The script reads the last UID from `/etc/passwd` and increments it by 1 to create a unique ID.

### 2. Read Username
It prompts the user to input a username.

### 3. Check if User Exists
It uses the `id` command to verify whether the username already exists.

### 4. Add User to System Files
If the user does not exist:  
- A new entry is added to `/etc/passwd`  
- A new group is added to `/etc/group`  

### 5. Add to Additional Groups
The script asks for group names and adds the user to those groups using `usermod`.

### 6. Create Home Directory
- Creates `/home/username`  
- Assigns ownership to the new user  
- Copies default configuration files from `/etc/skel`  

### 7. Set Password
- Prompts for a password (hidden input)  
- Assigns it using the `passwd` command  

---

## Notes

- This script must be run as **root**  
- It directly modifies critical system files, which can be risky  
- It does **not** include strong validation or error handling  

---

## Warning ⚠️

This script is intended for **learning purposes only**.  
Using it on a real system may cause:

- System instability  
- Security issues  
- File corruption  

> **Be careful when using this script.**

---

## Author

Aya
