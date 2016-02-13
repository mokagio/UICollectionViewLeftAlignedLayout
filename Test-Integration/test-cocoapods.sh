#!/bin/bash

set -e
set -o pipefail

cd CocoaPodsTest
bundle exec pod install
cd ..

xcodebuild \
  -workspace CocoaPodsTest/CocoaPodsTest.xcworkspace \
  -scheme CocoaPodsTest \
  -destination "platform=iOS Simulator,name=iPhone 6,OS=latest" \
  build \
	| bundle exec xcpretty
