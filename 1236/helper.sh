#!/bin/bash

if [[ $# -ne 1 ]] && [[ $# -ne 2 ]];then
    echo "./helper.sh build"
    echo "./helper.sh build-for-131"
    echo "./helper.sh config"
    echo "./helper.sh run"
    echo "./helper.sh run-for-131"
    echo "./helper.sh log"
elif [[ $1 == "build" ]]; then
    xcodebuild -workspace IOSTestRunner.xcworkspace -scheme IOSTestRunner -sdk iphonesimulator11.2 -configuration Debug -destination "platform=iOS Simulator,name=iPhone 8 Plus" clean build build-for-testing
elif [[ $1 == "build-for-131" ]]; then
    xcodebuild -workspace IOSTestRunner.xcworkspace -scheme IOSTestRunner -sdk iphonesimulator13.1 -configuration Debug -destination "platform=iOS Simulator,name=iPhone 8 Plus" clean build build-for-testing
elif [[ $1 == "config" ]]; then
    if [[ $# -ne 2 ]];then
        echo "need config string"
        exit
    fi
    serializeStr=$2
    PlistBuddy -c "Add :runner_config string \"${serializeStr}\"" ./Build/Products/Debug-iphonesimulator/IOSTestRunner.app/Info.plist
elif [[ $1 == "run" ]]; then
    xctool -workspace IOSTestRunner.xcworkspace -scheme IOSTestRunner -configuration Debug -sdk iphonesimulator11.2 -reporter pretty -destination "platform=iOS Simulator,name=iPhone 8 Plus" run-tests -only IOSTestRunnerTests
elif [[ $1 == "run-for-131" ]]; then
    xctool -workspace IOSTestRunner.xcworkspace -scheme IOSTestRunner -configuration Debug -sdk iphonesimulator13.1 -reporter pretty -destination "platform=iOS Simulator,name=iPhone 8 Plus" run-tests -only IOSTestRunnerTests
elif [[ $1 == "log" ]]; then
    xcrun simctl spawn booted log stream --level=debug
fi
