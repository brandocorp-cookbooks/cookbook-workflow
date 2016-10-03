#!/bin/bash -e
SUCCESS='\033[0;32m'
FAILURE='\033[0;31m'
CLEAR='\033[0m'

cd cookbook-workflow && echo -n "Running Foodcritic..."
if chef exec foodcritic . ; then
  echo -e "${SUCCESS}SUCCESS${CLEAR}"
fi
