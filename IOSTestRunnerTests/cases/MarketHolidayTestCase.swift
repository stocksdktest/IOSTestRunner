//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//假日黑名单
import XCTest
import os.log
import SwiftyJSON

class MarketHolidayTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.MarketHolidayTestCase
    }
   
    func testMarketHoliday() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MMarketHolidayRequest()
        
        let resp = self.makeSyncRequest(request: mRequest)
        let mMarketHolidayResponse = resp as! MMarketHolidayResponse
        XCTAssertNotNil(mMarketHolidayResponse.jsonObject)
        let objects = mMarketHolidayResponse.jsonObject["hk"]
            let items: NSArray = objects as! NSArray
            var jsonarr1 = [String]()
            for item in items{
                let dic1:NSDictionary = item as! NSDictionary
                jsonarr1.append(dic1["date"]! as! String)
            }
        var resultJSON: JSON = [
            "date": jsonarr1
        ]
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
        }
    
}

