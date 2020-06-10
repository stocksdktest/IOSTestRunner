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

class BIDCHART_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.BIDCHART_1
    }
    
    func testBidChart() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MBidChartRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let bidChartResponse = resp as! MBidChartResponse
        print(bidChartResponse)
//        XCTAssertNotNil(bidChartResponse.bidItems)
        if (bidChartResponse.bidItems == nil){
            throw BaseTestError.assertFailedError(message: "bidChartResponse bidItems is nil")
        }
        var resultJSON : JSON = [:]
        for item in bidChartResponse.bidItems{
            let itemJSON: JSON = [
              "closePrice":item.lastPrice,
              "referencePrice":item.referencePrice,
              "time":item.datetime,
              "buy1":item.buyVolume1,
              "buy2":item.buyVolume2,
              "sell1":item.sellVolume1,
              "sell2":item.sellVolume2,
            ]
            resultJSON["\(item.datetime!)"] = itemJSON
            
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}
