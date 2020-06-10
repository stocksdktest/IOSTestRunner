//
//  MongoCollector.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 12/6/19.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import Foundation
import SwiftyJSON

class TestResultMongoDBCollector : TestResultCollector {
    private let jobID: String
    private let runnerID: String
    private var testStartTimeDict: [String : (Int64, Bool)]
    
    private let mongoRESTEndpoint: String
    
    init(jobID: String, runnerID: String, storeConf: StockTesting_StoreConfig) throws {
        self.jobID = jobID
        self.runnerID = runnerID
        self.testStartTimeDict = [String : (Int64, Bool)]()
        
        self.mongoRESTEndpoint = storeConf.restEndpoint
    }
    
    private func buildExecutionRecord() -> JSON {
        var record: JSON = [
            "jobID": String(),
            "runnerID": String(),
            "recordID": String(),
            "isPass": false,
            "startTime": 0,
            "endTime": 0,
            "paramData": JSON(),
            "resultData": JSON(),
            "exceptionData": JSON()
        ]
        record["jobID"].string = self.jobID
        record["runnerID"].string = self.runnerID
        record["recordID"].string = UUID().uuidString
        return record
    }
    
    private func insertExecutionRecord(data: JSON) throws {
        let url = URL(string: "\(self.mongoRESTEndpoint)/test_result")!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try data.rawData()
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    Utils.log(tag: "TestResultCollector", str: "POST request success: \(json)")
                }
            } catch let error {
                Utils.log(tag: "TestResultCollector", str: "POST request error: \(error)")
            }
        })
        task.resume()
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
            record["testcaseID"].string = testName
            record["startTime"].int64 = entry.0
            record["endTime"].int64 = Int64(Date().timeIntervalSince1970)
            record["isPass"].bool = entry.1
            Utils.log(tag: "TestResultCollector", str: "On test end, encoding record: \(record)")
            do {
                try self.insertExecutionRecord(data: record)
            } catch {
                Utils.log(tag: "TestResultCollector", str: "On test end, encoding record (\(record)) error: \(error)")
            }
        }
    }
    
    func onTestResult(testName: String, param: JSON, result: JSON) {
        if let entry = self.testStartTimeDict[testName] {
            var record = buildExecutionRecord()
            record["testcaseID"].string = testName
            record["startTime"].int64 = entry.0
            record["endTime"].int64 = Int64(Date().timeIntervalSince1970)
            record["isPass"].bool = true
            do {
                record["paramData"].object = param
                record["resultData"].object = result
                Utils.log(tag: "TestResultCollector", str: "On test result, encoding record: \(record)")
                try self.insertExecutionRecord(data: record)
            } catch {
                Utils.log(tag: "TestResultCollector", str: "On test result, encoding record (\(record)) error: \(error)")
            }
        }
    }
    
    func onTestError(testName: String, param: JSON, error: JSON) {
        if let entry = self.testStartTimeDict[testName] {
            self.testStartTimeDict.updateValue((entry.0, entry.1 && false), forKey: testName)
            var record = buildExecutionRecord()
            record["testcaseID"].string = testName
            record["startTime"].int64 = entry.0
            record["endTime"].int64 = Int64(Date().timeIntervalSince1970)
            record["isPass"].bool = false
            do {
                record["paramData"].object = param
                record["exceptionData"].object = error
                Utils.log(tag: "TestResultCollector", str: "On test error, encoding record: \(record)")
                try self.insertExecutionRecord(data: record)
            } catch {
                Utils.log(tag: "TestResultCollector", str: "On test error, encoding record (\(record)) error: \(error)")
            }
        }
    }
    
    func afterAllTests() {
        // pass
    }
}

