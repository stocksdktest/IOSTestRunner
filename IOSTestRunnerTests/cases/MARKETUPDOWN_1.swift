//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//沪深当日涨跌统计数据
import XCTest
import os.log
import SwiftyJSON

class MARKETUPDOWN_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.MARKETUPDOWN_1
    }
    
    func testMarketUpdowns() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MMarketUpdownsRequest()
        
        let resp = self.makeSyncRequest(request: mRequest)
        let marketUpdownsResponse = resp as! MMarketUpdownsResponse
        XCTAssertNotNil(marketUpdownsResponse)
        var resultJSON: JSON = [
            "tUp":marketUpdownsResponse.advanceCount,
            "tDown":marketUpdownsResponse.declineCount,
            "tEqual":marketUpdownsResponse.equalCount,
            "tLimitUp":marketUpdownsResponse.limitUpCount,
            "tLimitDown":marketUpdownsResponse.limitDownCount,
            "yUp":marketUpdownsResponse.preAdvanceCount,
            "yDown":marketUpdownsResponse.preDeclineCount,
            
            ]
        let update1: JSON = [
            "yEqual":marketUpdownsResponse.preEqualCount,
            "yLimitUp":marketUpdownsResponse.preLimitUpCount,
            "yLimitDown":marketUpdownsResponse.preLimitDownCount,
            "yTime":marketUpdownsResponse.preDatetime,
            "tTime":marketUpdownsResponse.datetime,
            "list":marketUpdownsResponse.list,
        ]
        do {
            try resultJSON.merge(with: update1)
        } catch {
            // ignore
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}
