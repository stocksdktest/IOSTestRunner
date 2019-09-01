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
    
    func testExample1() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MQuoteRequest()
        mRequest.code = param["QUOTE_NUMBERS"].stringValue
        mRequest.stockFields = ["-1"]
        mRequest.addValueFields = ["ddz", "largeSellCount", "mediumDiffer"]
        let resp = self.makeSyncRequest(request: mRequest)
        let quoteResponse = resp as! MQuoteResponse
        XCTAssertNotNil(quoteResponse.stockItems)
        for item in quoteResponse.stockItems! {
            Utils.log(tag: "ExampleTestCase1", str: "\(item.id),\(item.name),\(item.lastPrice),\(item.openPrice),\(item.highPrice),\(item.lowPrice),\(item.preClosePrice),\(item.averagePrice),\(item.volume),\(item.amount)")
            Utils.log(tag: "ExampleTestCase1", str: "最新价：\(item.lastPrice),最高价：\(item.highPrice)")
        }
//        Utils.log(tag: "ExampleTestCase1", str: "response: \(resp)")
    }
}
