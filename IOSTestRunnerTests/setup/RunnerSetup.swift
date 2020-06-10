//
//  RunnerSetup.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/24.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

import Foundation
import XCTest
import os.log

class RunnerSetup {
    public static let RUNNER_CONFIG_ENV = "runner_config"
    enum RunnerSetupError: Error {
        case InvalidConfigInfo(String)
        case SDKSetupError(String)
    }
    
    private static var _sharedInstance: RunnerSetup!
    public static var sharedInstance: RunnerSetup! {
        if _sharedInstance == nil {
            do {
                let instance = try RunnerSetup()
                _sharedInstance = instance
            } catch {
                Utils.log(tag: "RunnerSetup", str: error.localizedDescription)
                return nil
            }
        }
        return _sharedInstance
    }
    
    public let runnerConfig: StockTesting_RunnerConfig
    public let resultCollector: TestResultCollector
    
    private init() throws {
        var infoDict: [String: Any]
        if Bundle.main.infoDictionary == nil {
            throw RunnerSetupError.InvalidConfigInfo("infoDictionary is nil")
        } else {
            infoDict = Bundle.main.infoDictionary!
            if infoDict[RunnerSetup.RUNNER_CONFIG_ENV] == nil
                || !(infoDict[RunnerSetup.RUNNER_CONFIG_ENV] is String) {
                throw RunnerSetupError.InvalidConfigInfo("runner_config value is nil or invalid")
            }
        }
        let cfgStr = infoDict[RunnerSetup.RUNNER_CONFIG_ENV]! as! String
//        let cfgStr = "CgRUSi0xEipSVU4tQS1lZmJjM2YzMy00Y2M0LTRhN2EtOGMzNS1kMmRmNTg3ZThlMTYazwYKLEo2SVBsazVBRVUrMi9ZaTU5cmZZbnNGUXRkdE9nQW85R0F6eXN4OGNpT009EixWVlcwRm5vN0JFWnQxYS95NktMTTM2dWo5cWNqdzdDQUhEd1daS0RsV0RzPRolCgRoa2R6Eh0KG2h0dHA6Ly8xMTQuODAuMTU1LjEzOToyMjAxNhojCgJnZhIdChtodHRwOi8vMTE0LjgwLjE1NS4xMzQ6MjIwMTMaJAoCbmYSHgocaHR0cDovLzE0MC4yMDcuMjQxLjE5NzoyMjAxMxokCgNjZmYSHQobaHR0cDovLzExNC44MC4xNTUuMTM0OjIyMDE2GiQKA2hrMRIdChtodHRwOi8vMTE0LjgwLjE1NS4xMzM6MjIwMTYaJQoEaGthMRIdChtodHRwOi8vMTE0LjgwLjE1NS4xMzM6MjIwMTYaIwoCcGISHQobaHR0cDovLzExNC44MC4xNTUuMTM0OjIyMDE2GiQKA2hrNRIdChtodHRwOi8vMTE0LjgwLjE1NS4xMzM6MjIwMTYaJQoFdGNwc3oSHAoadGNwOi8vMTE0LjgwLjE1NS4xMzQ6MjIwMTcaIwoCYmoSHQobaHR0cDovLzExNC44MC4xNTUuMTM0OjIyMDE2GiMKAmNmEh0KG2h0dHA6Ly8xMTQuODAuMTU1LjEzNDoyMjAxNhoiCgJzehIcChpodHRwOi8vMTE0LjgwLjE1NS41ODoyMjAxNholCgRoa2F6Eh0KG2h0dHA6Ly8xMTQuODAuMTU1LjEzMzoyMjAxNhokCgRzaGwyEhwKGmh0dHA6Ly8xMTQuODAuMTU1LjYyOjIyMDE2GiQKBHN6bDISHAoaaHR0cDovLzExNC44MC4xNTUuNDc6MjIwMTYaJQoEaGtkMRIdChtodHRwOi8vMTE0LjgwLjE1NS4xMzk6MjIwMTYaJQoEaGsxMBIdChtodHRwOi8vMTE0LjgwLjE1NS4xMzM6MjIwMTYaJQoFdGNwc2gSHAoadGNwOi8vMTE0LjgwLjE1NS4xMzQ6MjIwMTcaPwoCc2gSOQobaHR0cDovLzExNC44MC4xNTUuMTM0OjIyMDE2Chp0Y3A6Ly8xMTQuODAuMTU1LjEzNDoyMjAxNyIDCgExImIKDVFVT1RFREVUQUlMXzEQARgDIk17IkNPREUiOiAiNjAwMDAwLnNoIiwgIlRJQ0tDT1VOVCI6ICIxMCIsICJTVE9DS0ZJRUxEUyI6ICItMSIsICJGSUVMRFMiOiAiLTEifSpxCh1tb25nb2RiOi8vMjIxLjIyOC42Ni44MzozMDYxNxIMc3RvY2tTZGtUZXN0Ggt0ZXN0X3Jlc3VsdCI1aHR0cDovL21vbmdvLXB5dGhvbi1ldmUuc2RrLXRlc3Quc3ZjLmNsdXN0ZXIubG9jYWw6ODA="
        do {
            runnerConfig = try StockTesting_RunnerConfig(serializedData: Data(base64Encoded: cfgStr)!)
        } catch {
            Utils.log(tag: "RunnerSetup", str: "Protobuf deserialize error: \(error)")
            throw RunnerSetupError.InvalidConfigInfo(error.localizedDescription)
        }
        Utils.log(tag: "RunnerSetup", str: "\(runnerConfig)")
        do {
            try SDKSetup.setup(sdkConfig: runnerConfig.sdkConfig)
        } catch {
            Utils.log(tag: "RunnerSetup", str: "SDK setup error: \(error)")
            throw RunnerSetupError.SDKSetupError(error.localizedDescription)
        }
        // Setup has done
        // self.resultCollector = TestResultLogCollector(jobID: runnerConfig.jobID, runnerID: runnerConfig.runnerID)
        do {
            if runnerConfig.hasStoreConfig {
                self.resultCollector = try TestResultMongoDBCollector(jobID: runnerConfig.jobID, runnerID: runnerConfig.runnerID, storeConf: runnerConfig.storeConfig)
            } else {
                self.resultCollector = TestResultLogCollector(jobID: runnerConfig.jobID, runnerID: runnerConfig.runnerID)
            }
        } catch {
            Utils.log(tag: "RunnerSetup", str: "Init TestResultCollector error: \(error)")
            throw RunnerSetupError.SDKSetupError(error.localizedDescription)
        }
        XCTestObservationCenter.shared.addTestObserver(StockTestObservation(collector: self.resultCollector))
    }
    
    public func getTestcaseNames() -> [StockTestCaseName] {
        var names = [StockTestCaseName]()
        for item in runnerConfig.casesConfig {
            if let name = StockTestCaseName.fromString(item.testcaseID) {
                names.append(name)
            }
        }
        Utils.log(tag: "names", str: "\(names)")
        return names
    }
    
    public func getTestCaseConfigDict() -> [StockTestCaseName: StockTesting_TestcaseConfig] {
        var cfgDict = [StockTestCaseName: StockTesting_TestcaseConfig]()
        for caseCfg in runnerConfig.casesConfig {
            if let name = StockTestCaseName.fromString(caseCfg.testcaseID) {
                cfgDict[name] = caseCfg
            }
        }
        return cfgDict
    }
}
