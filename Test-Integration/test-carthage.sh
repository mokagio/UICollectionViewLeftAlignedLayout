#!/bin/bash

set -e
set -o pipefail

cd CarthageTest
carthage bootstrap
cd ..

xcodebuild \
  -project CarthageTest/CarthageTest.xcodeproj \
  -scheme CarthageTest \
  -destination "platform=iOS Simulator,name=iPhone 6,OS=latest" \
  build \
	| bundle exec xcpretty
