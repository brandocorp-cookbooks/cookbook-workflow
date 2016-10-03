#!/bin/bash -e
cd cookbook-workflow && chef exec rubocop --lint
