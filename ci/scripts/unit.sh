#!/bin/bash -e
chef exec rubocop --lint
chef exec foodcritic .
chef exec rspec

