#!/bin/bash -e
pwd
ls

if [ -f bootstrap.json ]; then
  cat bootstrap.json
fi

cd cookbook-workflow && echo 'Func'
