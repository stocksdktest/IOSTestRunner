//
//  TestCaseRoundConfig.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

import SwiftyJSON

class TestCaseRoundConfig {
    private var curRound: Int
    private var params: [JSON]
    public var sleepIntervalSec: UInt32
    public var continueWhenFailed: Bool
    init() {
        self.curRound = 0
        self.sleepIntervalSec = 0
        self.continueWhenFailed = false
        self.params = [JSON]()
    }
    
    init(caseCfg: StockTesting_TestcaseConfig) {
        self.curRound = 0
        self.sleepIntervalSec = UInt32(caseCfg.roundIntervalSec)
        self.continueWhenFailed = caseCfg.continueWhenFailed
        self.params = caseCfg.paramStrs.map{ item in JSON(parseJSON: item) }
    }
    
    open func shouldRun() -> Bool {
        return curRound < self.params.count
    }
    
    open func nextRound() {
        if (curRound < self.params.count) {
            curRound += 1
        }
    }
    
    open func getParam() -> JSON {
        return self.params[self.curRound]
    }
}
