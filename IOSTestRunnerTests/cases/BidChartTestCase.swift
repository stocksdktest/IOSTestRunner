//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//集合竞价走势数据
import XCTest
import os.log
import SwiftyJSON

class BidChartTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.BidChartTestCase
    }
    
    func testBidChart() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MBidChartRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        
        let resp = self.makeSyncRequest(request: mRequest)
        let bidChartResponse = resp as! MBidChartResponse
        print(bidChartResponse)
        XCTAssertNotNil(bidChartResponse.bidItems)
        for items in bidChartResponse.bidItems{
         var resultJSON: JSON = [
              "closePrice":items.lastPrice,
              "referencePrice":items.referencePrice,
              "time":items.datetime,
              "sell1":items.buyVolume1,
              "sell2":items.buyVolume2,
              "buy1":items.sellVolume1,
              "buy2":items.sellVolume2,
            ]
print(resultJSON)
onTestResult(param: param, result: resultJSON)
}
    }
}
