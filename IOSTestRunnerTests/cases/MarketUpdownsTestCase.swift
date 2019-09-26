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

class MarketUpdownsTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.MarketUpdownsTestCase
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
            "yEqual":marketUpdownsResponse.preEqualCount,
            "yLimitUp":marketUpdownsResponse.preLimitUpCount,
            "yLimitDown":marketUpdownsResponse.preLimitDownCount,
            "yTime":marketUpdownsResponse.preDatetime,
            "tTime":marketUpdownsResponse.datetime
           // "list":marketUpdownsResponse.list,
            ]
        var jsonlist = [JSON]()
        for i in 0 ..< marketUpdownsResponse.list.count{
            let jsonlists : JSON = [
                "\(-10+i)%": marketUpdownsResponse.list[i]
            ]
            jsonlist.append(jsonlists)
        }
        resultJSON["list"].arrayObject = jsonlist
print(resultJSON)
onTestResult(param: param, result: resultJSON)
}
}
