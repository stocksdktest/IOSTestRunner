//
//  File.swift
//  IOSTestRunnerTests
//
//  Created by 俞建斌 on 2019/9/5.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class AHQUOTE_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.AHQUOTE_1
    }
    
    func testAHQuote() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MAHQuoteRequest()
        mRequest.code = param["CODE"].stringValue
       
        let resp = self.makeSyncRequest(request: mRequest)
        let AHQuoteResponse = resp as! MAHQuoteResponse
        XCTAssertNotNil(AHQuoteResponse)
            var resultJSON:JSON = [
                "code" : AHQuoteResponse.linkageCode,
                "name" : AHQuoteResponse.linkageName,
                "lastPrice": AHQuoteResponse.lastPrice,
                "premium": AHQuoteResponse.premiumRate,
                "preClosePrice": AHQuoteResponse.preClosePrice,
                "changeRate": AHQuoteResponse.changeRate
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
    }
    
}
