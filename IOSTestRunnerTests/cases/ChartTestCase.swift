//
//  ChartTestCase.swift
//  IOSTestRunnerTests
//
//  Created by HW1-MM01 on 2019/9/10.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class ChartTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.ChartTestCase
    }
    
    func testChart() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MChartRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        if let typeVal = MChartType.init(rawValue: param["TYPE"].uIntValue) {
            mRequest.chartType = typeVal
        }
        mRequest.returnAFData = param["RETURNAFDATA"].boolValue

        let resp = self.makeSyncRequest(request: mRequest)
        let chartResponse = resp as! MChartResponse
        XCTAssertNotNil(chartResponse.ohlcItems)
        var resultJSON : JSON = [:]
        for item in chartResponse.ohlcItems{
            var itemJSON:JSON = [
                "datetime" : item.datetime,
                "closePrice": item.closePrice,
                "tradeVolume": item.tradeVolume,
                "averagePrice": item.averagePrice,
                "md": item.rgbar,
                "openInterest": item.openInterest,
                "iopv": item.iopv,
                "iopvPre": item.referenceIOPVPrice,
                
            ]
            resultJSON["\(item.datetime!)"] = itemJSON
            
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
    
}

