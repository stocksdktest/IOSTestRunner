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
        for dates in tradeDateResponse.dates! as NSArray{
            
            if let date : NSArray = dates as? NSArray{
                for items in date {
                    if let item : MTradeDateItem = items as? MTradeDateItem{
                        let jsonarr2: JSON = [
                            "date": item.date,
                            "isTrade": String(item.type.rawValue),
                            "description": item.desc
                        ]
                        resultJSON["\(item.date!)"] = jsonarr2
                    }
                    
                }
            }
            
            
            
            
        }
        
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)

    }
}


