//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//科创板盘后交易数据
import XCTest
import os.log
import SwiftyJSON

class AFTERHOURSCHART_2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.AFTERHOURSCHART_2
    }
    
    func testAfterHoursChart() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MAfterHoursChartRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let afterHoursChartResponse = resp as! MAfterHoursChartResponse
//        XCTAssertNotNil(afterHoursChartResponse.ohlcItems)
        if (afterHoursChartResponse.ohlcItems == nil){
            throw BaseTestError.assertFailedError(message: "afterHoursChartResponse ohlcItems is nil")
        }
        var resultJSON : JSON = [:]
        for item in afterHoursChartResponse.ohlcItems {
            let itemJSON: JSON = [
                "tickCount": afterHoursChartResponse.tickCount,
                "datetime": item.datetime,
                "openPrice": item.openPrice,
                "highPrice": item.highPrice,
                "lowPrice": item.lowPrice,
                "closePrice": item.closePrice,
                "tradeVolume": item.tradeVolume,
                "reference_price": item.referencePrice,
                "fp_volume": item.afterHoursVolume,
                "volRatio": item.volumeRatio,
                "fp_amount": item.afterHoursAmount
            ]
            resultJSON["\(item.datetime!)"] = itemJSON

        }
        
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
        
    }
}

