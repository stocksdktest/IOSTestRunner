//
//  TestResultCollector.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/9/3.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol TestResultCollector {
    func beforeAllTests()
    func onTestStart(testName: String)
    func onTestEnd(testName: String)
    func onTestResult(testName: String, param: JSON, result: JSON)
    func onTestError(testName: String, param: JSON, error: JSON)
    func afterAllTests()
}
