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

class HOLIDAY_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.HOLIDAY_1
    }
   
    func testMarketHoliday() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MMarketHolidayRequest()
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let mMarketHolidayResponse = resp as! MMarketHolidayResponse
//        XCTAssertNotNil(mMarketHolidayResponse.jsonObject)
        if (mMarketHolidayResponse.jsonObject == nil){
            throw BaseTestError.assertFailedError(message: "mMarketHolidayResponse jsonObject is nil")
        }
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

