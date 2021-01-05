//
//  Root.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/26.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

import XCTest
import SwiftyJSON

class BaseTestCaseRun : XCTestCaseRun {
    override func start() {
        super.start()
        print("XCTestRun start")
    }
    
    override func stop() {
        super.stop()
        print("XCTestRun end")
    }
    
    override func recordFailure(withDescription description: String, inFile filePath: String?, atLine lineNumber: Int, expected: Bool) {
        super.recordFailure(withDescription: description, inFile: filePath, atLine: lineNumber, expected: expected)
    }
}

enum BaseTestError: LocalizedError {
    case _assertFailedError(message: String, file: StaticString, line: UInt)
    private init(message: String, file: StaticString, line: UInt) {
        self = ._assertFailedError(message: message, file: file, line: line)
    }
    static func assertFailedError(message: String = "", file: StaticString = #file, line: UInt = #line) -> BaseTestError {
        return BaseTestError.init(message: message, file: file, line: line)
    }
    var errorDescription: String? {
        switch self {
        case let ._assertFailedError(message, file, line):
            return "AssertFailedError: \(message), at \(file): \(line)"
        }
    }
}

class BaseTestCase : ParametrizedTestCase {
    static var allowedTestNames: [_SelectedTestCase] = RunnerSetup.sharedInstance.getTestcaseNames().map{ item in
        return _SelectedTestCase(name: item.rawValue)
    }
    static var testCaseConfigDict: [StockTestCaseName: StockTesting_TestcaseConfig] = RunnerSetup.sharedInstance.getTestCaseConfigDict()
    
    internal var stockTestCaseName: StockTestCaseName {
        fatalError("Must be overridden by subclasses.")
    }
    
    override var testName: String {
        get {
            return self.stockTestCaseName.rawValue
        }
        set {
            fatalError("Must be overridden by subclasses.")
        }
    }
    
    override var testRunClass: AnyClass? {
        return BaseTestCaseRun.self
    }
    
    override func _allowedTestNames() -> [_SelectedTestCase] {
        return BaseTestCase.allowedTestNames
    }
    
    internal func makeSyncRequest(request: MRequest) throws -> MResponse {
        var reqResponse: MResponse? = nil
        let runLoop = CFRunLoopGetCurrent()
        print("当前SDK版本为：\(MApi.version() ?? "未获取到SDK版本信息")")
        MApi.send(request, completionHandler: { resp in
            reqResponse = resp
            CFRunLoopStop(runLoop)
        })
        let result = CFRunLoopRunInMode(CFRunLoopMode.defaultMode, CFTimeInterval(5.0), false)
        if (result != .stopped) {
            throw BaseTestError.assertFailedError(message: "MApi request timeout")
        }
        if (reqResponse == nil) {
            throw BaseTestError.assertFailedError(message: "MApi response is nil")
        }
        return reqResponse!
    }
    
    internal var testCaseRoundConfig: TestCaseRoundConfig = TestCaseRoundConfig()

    override func invokeTest() {
        if let cfg = BaseTestCase.testCaseConfigDict[self.stockTestCaseName] {
            testCaseRoundConfig = TestCaseRoundConfig(caseCfg: cfg)
            while testCaseRoundConfig.shouldRun() {
                super.invokeTest()
                testCaseRoundConfig.nextRound()
                sleep(testCaseRoundConfig.sleepIntervalSec)
            }
        }
    }
    
    internal func onTestResult(param: JSON, result: JSON) {
        RunnerSetup.sharedInstance.resultCollector.onTestResult(testName: self.testName, param: param, result: result)
    }
}
