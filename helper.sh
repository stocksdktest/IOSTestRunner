#!/bin/bash

if [[ $# -ne 1 ]];then
    echo "./helper.sh build"
    echo "./helper.sh config"
    echo "./helper.sh run"
    echo "./helper.sh log"
elif [[ $1 == "build" ]]; then
    xcodebuild -workspace IOSTestRunner.xcworkspace -scheme IOSTestRunner -sdk iphonesimulator11.2 -configuration Release -destination "platform=iOS Simulator,name=iPhone 8 Plus" build-for-testing
elif [[ $1 == "config" ]]; then
    PlistBuddy -c 'Add :runner_config string "CgRUSi0xEipSVU4tQS1kNWRmM2IxYy03YmNiLTQ1M2UtODE1NS1jNDg3Mzc0YTQ2MmEaMwosVlZXMEZubzdCRVp0MWEveTZLTE0zNnVqOXFjanc3Q0FIRHdXWktEbFdEcz0aAwoBMiJOCgpURVNUQ0FTRV8wGAMiHnsiUVVPVEVfTlVNQkVSUyI6ICI2MDAwMDAuc2gifSIeeyJRVU9URV9OVU1CRVJTIjogIjYwMDAyOC5zaCJ9"' ./Build/Products/Release-iphonesimulator/IOSTestRunner.app/Info.plist
elif [[ $1 == "run" ]]; then
    xctool -workspace IOSTestRunner.xcworkspace -scheme IOSTestRunner -configuration Release -sdk iphonesimulator11.2 -reporter pretty -destination "platform=iOS Simulator,name=iPhone 8 Plus" run-tests -only IOSTestRunnerTests
elif [[ $1 == "log" ]]; then
    xcrun simctl spawn booted log stream --level=debug
fi
