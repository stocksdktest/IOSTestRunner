//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//历史分时走势数据
import XCTest
import os.log
import SwiftyJSON

class HISTORYCHART_2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.HISTORYCHART_2
    }
    
    func testHistoryChart() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MHistoryChartRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        mRequest.date = param["DATE"].stringValue
        
        let resp = self.makeSyncRequest(request: mRequest)
        let historyChartResponse = resp as! MHistoryChartResponse
        XCTAssertNotNil(historyChartResponse.ohlcItems)
        var resultJSON : JSON = [:]
        for items in historyChartResponse.ohlcItems{
        var itemJSON: JSON = [
             "datetime": items.datetime + "00",
             "closePrice": items.closePrice,
             "tradeVolume": items.tradeVolume,
             "averagePrice": items.averagePrice,
             "md": items.rgbar,
             "openInterest": items.openInterest,
             "iopv": items.iopv,
             "iopvPre": items.referenceIOPVPrice,
        ]
            resultJSON["\(items.datetime!)00"] = itemJSON
        
 }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
}
}
