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
    public let resultCollector: TestResultCollector
    
    private init() throws {
//        var infoDict: [String: Any]
//        if Bundle.main.infoDictionary == nil {
//            throw RunnerSetupError.InvalidConfigInfo("infoDictionary is nil")
//        } else {
//            infoDict = Bundle.main.infoDictionary!
//            if infoDict[RunnerSetup.RUNNER_CONFIG_ENV] == nil
//                || !(infoDict[RunnerSetup.RUNNER_CONFIG_ENV] is String) {
//                throw RunnerSetupError.InvalidConfigInfo("runner_config value is nil or invalid")
//            }
//        }
//        let cfgStr = infoDict[RunnerSetup.RUNNER_CONFIG_ENV]! as! String
        let cfgStr = "CgRUSi0xEipSVU4tQS0wMThjZWY2YS01OTU3LTRkYTktYjI5MS00MTMzZDBlMDRkY2EanAUKLEo2SVBsazVBRVUrMi9ZaTU5cmZZbnNGUXRkdE9nQW85R0F6eXN4OGNpT009EixWVlcwRm5vN0JFWnQxYS95NktMTTM2dWo5cWNqdzdDQUhEd1daS0RsV0RzPRolCgRoa2ExEh0KG2h0dHA6Ly8xMTQuODAuMTU1LjEzMzoyMjAxNhoiCgJwYhIcChpodHRwOi8vMTE0LjgwLjE1NS42MToyMjAxNhoiCgJiahIcChpodHRwOi8vMTE0LjgwLjE1NS42MToyMjAxNhokCgNoazUSHQobaHR0cDovLzExNC44MC4xNTUuMTMzOjIyMDE2GiIKAmNmEhwKGmh0dHA6Ly8xMTQuODAuMTU1LjYxOjIyMDE2GiIKAnN6EhwKGmh0dHA6Ly8xMTQuODAuMTU1LjYxOjIyMDE2GiUKBGhrYXoSHQobaHR0cDovLzExNC44MC4xNTUuMTMzOjIyMDE2GiUKBXNoc3p2EhwKGmh0dHA6Ly8xMTQuODAuMTU1LjYxOjIyMDE2GiUKBGhrZDESHQobaHR0cDovLzExNC44MC4xNTUuMTMzOjIyMDE2GiUKBGhrMTASHQobaHR0cDovLzExNC44MC4xNTUuMTMzOjIyMDE2GiIKAnNoEhwKGmh0dHA6Ly8xMTQuODAuMTU1LjYxOjIyMDE2GiUKBGhrZHoSHQobaHR0cDovLzExNC44MC4xNTUuMTMzOjIyMDE2GiIKAmdmEhwKGmh0dHA6Ly8xMTQuODAuMTU1LjYxOjIyMDEzGiIKAm5mEhwKGmh0dHA6Ly8xMTQuODAuMTU1LjU4OjIyMDEzGiQKA2hrMRIdChtodHRwOi8vMTE0LjgwLjE1NS4xMzM6MjIwMTYiDEoEaGsxMEoEaGthMSLDBAoQQWRkVmFsdWVUZXN0Q2FzZRgDIjZ7IkNPREUiOiAiNjAwMDAwLnNoIiwgIlNVQlRZUEUiOiAiMTAwMSIsICJGSUVMRFMiOiAiIn0iNnsiQ09ERSI6ICI2MDAwMDAuc2giLCAiU1VCVFlQRSI6ICIxMDAxIiwgIkZJRUxEUyI6ICIifSI2eyJDT0RFIjogIjkwMDkyOC5zaCIsICJTVUJUWVBFIjogIjEwMDIiLCAiRklFTERTIjogIiJ9IjZ7IkNPREUiOiAiMzAwNzk5LnN6IiwgIlNVQlRZUEUiOiAiMTAwMSIsICJGSUVMRFMiOiAiIn0iNnsiQ09ERSI6ICIyMDA1OTYuc3oiLCAiU1VCVFlQRSI6ICIxMDAyIiwgIkZJRUxEUyI6ICIifSI2eyJDT0RFIjogIjAwMjUwOS5zeiIsICJTVUJUWVBFIjogIjEwMDMiLCAiRklFTERTIjogIiJ9IjZ7IkNPREUiOiAiMzAwMDY3LnN6IiwgIlNVQlRZUEUiOiAiMTAwNCIsICJGSUVMRFMiOiAiIn0iNnsiQ09ERSI6ICI2MDA2MzQuc2giLCAiU1VCVFlQRSI6ICIxMDA0IiwgIkZJRUxEUyI6ICIifSI1eyJDT0RFIjogIjYwMDc0Ny5zaCIsICJTVUJUWVBFIjogIlNIUCIsICJGSUVMRFMiOiAiIn0iNnsiQ09ERSI6ICI2MDM2MTAuc2giLCAiU1VCVFlQRSI6ICIxMDA1IiwgIkZJRUxEUyI6ICIifSJ1Cg9PcHRpb25UVGVzdENhc2UYAyIveyJTVE9DS0lEIjogIjE1OTkxNS5zeiIsICJFWFBJUkVNT05USCI6ICIxOTExIn0iL3siU1RPQ0tJRCI6ICI1MTAwNTAuc2giLCAiRVhQSVJFTU9OVEgiOiAiMTkxMSJ9"
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
        self.resultCollector = TestResultLogCollector(jobID: runnerConfig.jobID, runnerID: runnerConfig.runnerID)
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
