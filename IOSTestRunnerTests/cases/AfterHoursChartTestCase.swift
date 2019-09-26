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

class AfterHoursChartTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.AfterHoursChartTestCase
    }
    
    func testAfterHoursChart() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MAfterHoursChartRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        
        let resp = self.makeSyncRequest(request: mRequest)
        let afterHoursChartResponse = resp as! MAfterHoursChartResponse
        XCTAssertNotNil(afterHoursChartResponse.ohlcItems)
        for item in afterHoursChartResponse.ohlcItems {
            var resultJSON: JSON = [
                "tradeTimes": afterHoursChartResponse.tickCount,
                "datetime": item.datetime,
                "openPrice": item.openPrice,
                "highPrice": item.highPrice,
                "lowPrice": item.lowPrice,
                "closePrice": item.closePrice,
                "tradeVolume": item.tradeVolume,
                "reference_price": item.referencePrice,
                "fp_volume": item.afterHoursVolume,
                "fp_amount": item.afterHoursAmount
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)

        }
        
        //            var resultJSON: JSON = [
        //                "lastPrice": item.lastPrice,
        //                "highPrice": item.highPrice
        //            ]
        //            if let anyItems = item.tickItems{
        //                var jsonarray2 = [JSON]()
        //                for anyItem in anyItems{
        //                    if !(anyItem is MTickItem){
        //                        continue
        //                    }
        //
        //                    let tickitem:MTickItem = anyItem as! MTickItem
        //                    let jsonarray1: JSON = [
        //                        "amsflag": tickitem.tradeVolume,
        //                        "aaa": tickitem.amsFlag.rawValue
        //                    ]
        //                    jsonarray2.append(jsonarray1)
        //                }
        //                resultJSON["tickitem"].arrayObject = jsonarray2
        //            }
        //            print(resultJSON)
        //            onTestResult(param: param, result: resultJSON)
        //        }
        //    }
        //
    }
}

