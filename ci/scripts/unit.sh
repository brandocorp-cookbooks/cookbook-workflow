#!/bin/bash -e
cd cookbook-workflow && chef exec rspec -f doc --color
