//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//期权-交割月列表
import XCTest
import os.log
import SwiftyJSON

class ExpireMonthTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.ExpireMonthTestCase
    }
    
    func testExpireMonth() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MExpireMonthRequest()
        mRequest.stockID = param["STOCKID"].stringValue
     
        let resp = self.makeSyncRequest(request: mRequest)
        let expireMonthResponse = resp as! MExpireMonthResponse
        XCTAssertNotNil(expireMonthResponse.expireMonths)
        for item in expireMonthResponse.expireMonths{
            
            var resultJSON: JSON = [
                "date": item
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
        
    }
}

