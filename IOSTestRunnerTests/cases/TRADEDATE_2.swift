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

class TRADEDATE_2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.TRADEDATE_2
    }
    
    func testTradeDate() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MTradeDateRequest()
        mRequest.market = param["MARKET"].stringValue
        mRequest.date = param["DATE"].stringValue
       
        let resp = try self.makeSyncRequest(request: mRequest)
        let tradeDateResponse = resp as! MTradeDateResponse
//        XCTAssertNotNil(tradeDateResponse.dates)
        if (tradeDateResponse.dates == nil){
            throw BaseTestError.assertFailedError(message: "tradeDateResponse dates is nil")
        }
        var resultJSON : JSON = [:]
        for date in tradeDateResponse.dates{
            let dates : MTradeDateItem = date as! MTradeDateItem
            let jsonarr2: JSON = [
                "date": dates.date,
                "isTrade": String(dates.type.rawValue),
                "description": dates.desc
            ]
            resultJSON["\(dates.date!)"] = jsonarr2
            
            
        }
        
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)

    }
}


