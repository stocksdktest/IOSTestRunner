//
//  BaseTestObervation.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/9/3.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

import XCTest
import SwiftyJSON

class StockTestObservation : NSObject, XCTestObservation {
    private let collector: TestResultCollector
    
    init(collector: TestResultCollector) {
        self.collector = collector
        super.init()
    }
    
    internal func castToBaseClass(_ testCase: XCTestCase) -> BaseTestCase? {
        if testCase.isKind(of: BaseTestCase.self) {
            return testCase as! BaseTestCase
        } else {
            return nil
        }
    }
    
    func testBundleWillStart(_ testBundle: Bundle) {
        // pass
        print("Tests start")
    }
    
    func testBundleDidFinish(_ testBundle: Bundle) {
        // pass
        print("Tests end")
    }
    
    func testCaseWillStart(_ testCase: XCTestCase) {
        if let baseClass = castToBaseClass(testCase) {
            collector.onTestStart(testName: baseClass.testName)
            print("Test case start: \(baseClass.testName)")
        }
    }
    
    func testCaseDidFinish(_ testCase: XCTestCase) {
        if let baseClass = castToBaseClass(testCase) {
            collector.onTestEnd(testName: baseClass.testName)
            print("Test case start: \(baseClass.testName)")
        }
    }
    
    func testCase(_ testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: Int) {
        if let baseClass = castToBaseClass(testCase) {
            let paramObj = baseClass.testCaseRoundConfig.getParam()
            let errorObj: JSON = [
                "description": description,
                "location": "\(filePath):\(lineNumber)"
            ]
            collector.onTestError(testName: baseClass.testName, param: paramObj, error: errorObj)
            print("Test case error: \(baseClass.testName)")
        }
    }
}
