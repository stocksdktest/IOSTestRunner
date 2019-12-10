//
//  MongoCollector.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 12/6/19.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import Foundation
import SwiftyJSON
import MongoSwift

class TestResultMongoDBCollector : TestResultCollector {
    private let jobID: String
    private let runnerID: String
    private var testStartTimeDict: [String : (Int64, Bool)]
    
    private let mongoClient: MongoClient
    private let recordCollection: MongoCollection<Document>
    
    init(jobID: String, runnerID: String, storeConf: StockTesting_StoreConfig) throws {
        self.jobID = jobID
        self.runnerID = runnerID
        self.testStartTimeDict = [String : (Int64, Bool)]()
        
        self.mongoClient = try MongoClient(connectionString: storeConf.mongoUri)
        let db = self.mongoClient.db(storeConf.dbName)
        self.recordCollection = try db.collection(storeConf.collectionName)
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
                try self.recordCollection.insertOne(Document.init(fromJSON: record.rawData()))
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
                try self.recordCollection.insertOne(Document.init(fromJSON: record.rawData()))
            } catch {
                Utils.log(tag: "TestResultCollector", str: "On test result, encoding record (\(record)) error: \(error)")
            }
        }
    }
    
    func onTestError(testName: String, description: String, filePath: String, lineNumber: Int) {
        if let entry = self.testStartTimeDict[testName] {
            self.testStartTimeDict.updateValue((entry.0, entry.1 && false), forKey: testName)
            var record = buildExecutionRecord()
            record["testcaseID"].string = testName
            record["startTime"].int64 = entry.0
            record["endTime"].int64 = Int64(Date().timeIntervalSince1970)
            record["isPass"].bool = false
            let errorJSON: JSON = [
                "description": description,
                "location": "\(filePath):\(lineNumber)"
            ]
            do {
                record["exceptionData"].object = errorJSON
                Utils.log(tag: "TestResultCollector", str: "On test error, encoding record: \(record)")
                try self.recordCollection.insertOne(Document.init(fromJSON: record.rawData()))
            } catch {
                Utils.log(tag: "TestResultCollector", str: "On test error, encoding record (\(record)) error: \(error)")
            }
        }
    }
    
    func afterAllTests() {
        // pass
    }
}

