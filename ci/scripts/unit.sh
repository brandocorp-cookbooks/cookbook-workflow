#!/bin/sh -exc

chef exec rubocop --lint
chef exec foodcritic .
chef exec rspec

