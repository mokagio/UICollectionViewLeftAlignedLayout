#!/bin/bash

bundle

if [ ! which carthage > /dev/null ]; then
  brew update
  brew install carthage
fi

