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
    func onTestSuccess(testName: String)
    func onTestResult(testName: String, param: JSON, result: JSON)
    func onTestError(testName: String, errorDesc: String)
    func afterAllTests()
}

class TestResultLogCollector : TestResultCollector {
    private let jobID: String
    private let runnerID: String
    private var testStartTimeDict: [String : Int64]
    
    init(jobID: String, runnerID: String) {
        self.jobID = jobID
        self.runnerID = runnerID
        self.testStartTimeDict = [String : Int64]()
    }
    
    private func buildExecutionRecord() -> StockTesting_TestExecutionRecord {
        var record = StockTesting_TestExecutionRecord()
        record.jobID = self.jobID
        record.runnerID = self.runnerID
        record.recordID = UUID().uuidString
        return record
    }
    
    func beforeAllTests() {
        // pass
    }
    
    func onTestStart(testName: String) {
        self.testStartTimeDict.updateValue(Int64(Date().timeIntervalSince1970), forKey: testName)
    }
    
    func onTestSuccess(testName: String) {
        if let startTime = self.testStartTimeDict[testName] {
            var record = buildExecutionRecord()
            record.testcaseID = testName
            record.startTime = startTime
            record.endTime = Int64(Date().timeIntervalSince1970)
            record.isPass = true
            do {
                try Utils.record(data: record.serializedData().base64EncodedData())
            } catch {
                Utils.log(tag: "TestResultCollector", str: "Encoding record (\(record.textFormatString())) error: \(error)")
            }
            
        }
    }
    
    func onTestResult(testName: String, param: JSON, result: JSON) {
        if let startTime = self.testStartTimeDict[testName] {
            var record = buildExecutionRecord()
            record.testcaseID = testName
            record.startTime = startTime
            record.endTime = Int64(Date().timeIntervalSince1970)
            record.isPass = true
            record.paramStr = param.rawString()!
            record.resultStr = result.rawString()!
            do {
                try Utils.record(data: record.serializedData().base64EncodedData())
            } catch {
                Utils.log(tag: "TestResultCollector", str: "Encoding record (\(record.textFormatString())) error: \(error)")
            }
            
        }
    }
    
    func onTestError(testName: String, errorDesc: String) {
        if let startTime = self.testStartTimeDict[testName] {
            var record = buildExecutionRecord()
            record.testcaseID = testName
            record.startTime = startTime
            record.endTime = Int64(Date().timeIntervalSince1970)
            record.isPass = false
            record.exceptionStr = errorDesc
            do {
                try Utils.record(data: record.serializedData().base64EncodedData())
            } catch {
                Utils.log(tag: "TestResultCollector", str: "Encoding record (\(record.textFormatString())) error: \(error)")
            }
            
        }
    }
    
    func afterAllTests() {
        // pass
    }
}
