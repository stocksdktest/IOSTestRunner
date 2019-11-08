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

class AHQuoteTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.AHQuoteTestCase
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
                "lastPrice": AHQuoteResponse.lastPrice,
                "premiun": AHQuoteResponse.premiumRate,
                "preClosePrice": AHQuoteResponse.preClosePrice,
                "changeRate": AHQuoteResponse.changeRate
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
    }
    
}
