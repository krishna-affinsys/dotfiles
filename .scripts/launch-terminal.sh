#!/bin/bash

if command -v ghostty &> /dev/null
then
  ghostty
elif command -v wezterm &> /dev/null
then
  wezterm
else
  alacritty
fi

