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
    func onTestError(testName: String, description: String, filePath: String, lineNumber: Int)
    func afterAllTests()
}

class TestResultLogCollector : TestResultCollector {
    private let jobID: String
    private let runnerID: String
    private var testStartTimeDict: [String : (Int64, Bool)]
    
    init(jobID: String, runnerID: String) {
        self.jobID = jobID
        self.runnerID = runnerID
        self.testStartTimeDict = [String : (Int64, Bool)]()
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
        self.testStartTimeDict.updateValue((Int64(Date().timeIntervalSince1970), true), forKey: testName)
    }
    
    func onTestEnd(testName: String) {
        if let entry = self.testStartTimeDict[testName] {
            var record = buildExecutionRecord()
            record.testcaseID = testName
            record.startTime = entry.0
            record.endTime = Int64(Date().timeIntervalSince1970)
            record.isPass = entry.1
            Utils.log(tag: "TestResultCollector", str: "On test end, encoding record: \(record.textFormatString())")
            do {
                try Utils.record(data: record.serializedData().base64EncodedData())
            } catch {
                Utils.log(tag: "TestResultCollector", str: "On test end, encoding record (\(record.textFormatString())) error: \(error)")
            }
            
        }
    }
    
    func onTestResult(testName: String, param: JSON, result: JSON) {
        if let entry = self.testStartTimeDict[testName] {
            var record = buildExecutionRecord()
            record.testcaseID = testName
            record.startTime = entry.0
            record.endTime = Int64(Date().timeIntervalSince1970)
            record.isPass = true
            record.paramStr = param.rawString([.castNilToNSNull: true])!
            record.resultStr = result.rawString([.castNilToNSNull: true])!
            Utils.log(tag: "TestResultCollector", str: "On test result, encoding record: \(record.textFormatString())")
            do {
                try Utils.record(data: record.serializedData().base64EncodedData())
            } catch {
                Utils.log(tag: "TestResultCollector", str: "On test result, encoding record (\(record.textFormatString())) error: \(error)")
            }
            
        }
    }
    
    func onTestError(testName: String, description: String, filePath: String, lineNumber: Int) {
        if let entry = self.testStartTimeDict[testName] {
            self.testStartTimeDict.updateValue((entry.0, entry.1 && false), forKey: testName)
            var record = buildExecutionRecord()
            record.testcaseID = testName
            record.startTime = entry.0
            record.endTime = Int64(Date().timeIntervalSince1970)
            record.isPass = false
            let errorJSON: JSON = [
                "description": description,
                "location": "\(filePath):\(lineNumber)"
            ]
            record.exceptionStr = errorJSON.rawString([.castNilToNSNull: true])!
            Utils.log(tag: "TestResultCollector", str: "On test error, encoding record: \(record.textFormatString())")
            do {
                try Utils.record(data: record.serializedData().base64EncodedData())
            } catch {
                Utils.log(tag: "TestResultCollector", str: "On test error, encoding record (\(record.textFormatString())) error: \(error)")
            }
            
        }
    }
    
    func afterAllTests() {
        // pass
    }
}
