//
//  IOSTestRunnerTests.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/24.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class ExampleTestCase1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.QUOTE_REQUEST_EXAMPLE
    }
    
    func testExample1() throws {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MQuoteRequest()
        mRequest.code = param["QUOTE_NUMBERS"].stringValue
        mRequest.stockFields = ["-1"]
        mRequest.addValueFields = ["ddz", "largeSellCount", "mediumDiffer"]
        let resp = try self.makeSyncRequest(request: mRequest)
        let quoteResponse = resp as! MQuoteResponse
        if (quoteResponse.stockItems == nil) {
            throw BaseTestError.assertFailedError(message: "NQuoteResponse stockItems is nil")
        }
        for item in quoteResponse.stockItems! {
            if (item.lastPrice == nil) {
                throw BaseTestError.assertFailedError(message: "StockItem lastPrice is nil")
            }
            var resultJSON: JSON = [
                "lastPrice": item.lastPrice
            ]
            onTestResult(param: param, result: resultJSON)
        }
//        Utils.log(tag: "ExampleTestCase1", str: "response: \(resp)")
    }
}
