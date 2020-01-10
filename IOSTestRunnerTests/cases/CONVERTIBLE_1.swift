//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//可转债与正股联动行情
import XCTest
import os.log
import SwiftyJSON

class CONVERTIBLE_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.CONVERTIBLE_1
    }
   
    func testLinkQuote() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MLinkQuoteRequet()
        mRequest.code = param["CODE"].stringValue
    
        let resp = self.makeSyncRequest(request: mRequest)
        let linkQuoteResponse = resp as! MLinkQuoteResponse
        XCTAssertNotNil(linkQuoteResponse.items)
        var resultJSON : JSON = [:]
        for items in linkQuoteResponse.items{
            let itemJSON: JSON = [
            "code":items.code,
            "name":items.name,
            "lastPrice":items.lastPrice,
            "premium":items.premiumRate,
            "changeRate":items.changeRate,
            "change":items.change,
         ]
            resultJSON["\(items.code!)"] = itemJSON
 
     }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
  }
}
