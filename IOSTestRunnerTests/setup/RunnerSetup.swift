//
//  RunnerSetup.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/24.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

import os.log

class RunnerSetup {
    public static let RUNNER_CONFIG_ENV = "runner_config"
    enum SetupError: Error {
        case InvalidConfigInfo(String)
        case SDKSetup
    }
    
    private static var _sharedInstance: RunnerSetup!
    public static var sharedInstance: RunnerSetup! {
        if _sharedInstance == nil {
            do {
                let instance = try RunnerSetup()
                _sharedInstance = instance
            } catch {
                os_log("An error occured during RunnerSetup init: %{public}@", error.localizedDescription)
                return nil
            }
        }
        return _sharedInstance
    }
    
    public let runnerConfig: StockTesting_RunnerConfig
    
    private init() throws {
        #if DEBUG
        let cfgStr = "CgRUSi0xEipSVU4tQS0xY2Y1MDVkZC00ZGY1LTQ1NDQtYTNjNC0xYmJiN2RmNGQ3ZmEaNQosSjZJUGxrNUFFVSsyL1lpNTlyZlluc0ZRdGR0T2dBbzlHQXp5c3g4Y2lPTT0QARgBIgECIi4KClRFU1RDQVNFXzAQASIeeyJRVU9URV9OVU1CRVJTIjogIjYwMDAwMC5zaCJ9"
        #else
            var infoDict: [String: Any]
            if Bundle.main.infoDictionary == nil {
                throw SetupError.InvalidConfigInfo("infoDictionary is nil")
            } else {
                infoDict = Bundle.main.infoDictionary!
                if infoDict[RunnerSetup.RUNNER_CONFIG_ENV] == nil
                    || !(infoDict[RunnerSetup.RUNNER_CONFIG_ENV] is String) {
                    throw SetupError.InvalidConfigInfo("runner_config value is nil or invalid")
                }
            }
            let cfgStr = infoDict[RunnerSetup.RUNNER_CONFIG_ENV]! as! String
        #endif
        do {
            runnerConfig = try StockTesting_RunnerConfig(serializedData: Data(base64Encoded: cfgStr)!)
        } catch {
            throw SetupError.InvalidConfigInfo(error.localizedDescription)
        }
        os_log("config: %{public}@", log: OSLog.default, type: OSLogType.error, runnerConfig.textFormatString())
    }
    
    public func getTestcaseNames() -> [StockTestCaseName] {
        var names = [StockTestCaseName]()
        for caseCfg in runnerConfig.casesConfig {
            if let name = StockTestCaseName.fromString(caseCfg.testcaseID) {
                names.append(name)
            }
        }
        return names
    }
}
