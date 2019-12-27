//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//市场交易日接口
import XCTest
import os.log
import SwiftyJSON

class TRADEDATE_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.TRADEDATE_1
    }
    
    func testTradeDate() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MTradeDateRequest()
        mRequest.market = param["MARKET"].stringValue
       
        let resp = self.makeSyncRequest(request: mRequest)
        let tradeDateResponse = resp as! MTradeDateResponse
        XCTAssertNotNil(tradeDateResponse.dates)
        var resultJSON : JSON = [:]
        for dates in tradeDateResponse.dates{
            var jsonarr2: JSON = [
                "date": dates.date,
                "isTrade": dates.type.rawValue,
                "description": dates.desc
            ]
            resultJSON["\(dates.date!)"] = jsonarr2
            
            
        }
        
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
//        var jsonarr1 = [JSON]()
//        for dates in tradeDateResponse.dates{
//            var jsonarr2 : JSON = [
//                "date": dates.date,
//                "isTrade": dates.type.rawValue,
//                "description": dates.desc
//            ]
//            jsonarr1.append(jsonarr2)
//        }
//        var resultJSON: JSON = [
//            "tradeDates": jsonarr1
//        ]
//        print(resultJSON)
//        onTestResult(param: param, result: resultJSON)
//
    }
}


