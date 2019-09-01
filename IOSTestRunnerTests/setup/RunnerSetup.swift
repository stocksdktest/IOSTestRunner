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
    
    private init() throws {
        #if DEBUG
        let cfgStr = "CgRUSi0xEipSVU4tQS01NTQ2MTBiOS02MjI2LTQ2M2MtYmJjOS01MmMyODU2ZTNiYjMaYQosSjZJUGxrNUFFVSsyL1lpNTlyZlluc0ZRdGR0T2dBbzlHQXp5c3g4Y2lPTT0SLFZWVzBGbm83QkVadDFhL3k2S0xNMzZ1ajlxY2p3N0NBSER3V1pLRGxXRHM9IgMKATIiLgoKVEVTVENBU0VfMBgDIh57IlFVT1RFX05VTUJFUlMiOiAiNjAwMDI4LnNoIn0="
        #else
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
        #endif
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
