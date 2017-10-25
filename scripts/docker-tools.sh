#!/usr/bin/env bash

# Install the aws cli
pip install --quiet --user awscli

# Ensure the cli can be found
export PATH=$PATH:$HOME/.local/bin

# Check the versions of our publish tools
aws --version
docker --version

# vim: set syn=sh :
