#!/bin/bash

if command -v wezterm &> /dev/null
then
  wezterm
else
  alacritty
fi

