#!/bin/bash

# Prompt for username and password
username="$1"
password="$2"
echo

# Encode the credentials
encodedCredentials=$(echo -n "$username:$password" | base64)

# Print the Basic Auth token
echo "Basic $encodedCredentials" | xclip -sel clip

