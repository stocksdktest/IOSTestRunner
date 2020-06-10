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
    
    func testAHQuote() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MAHQuoteRequest()
        mRequest.code = param["CODE"].stringValue
       
        let resp = try self.makeSyncRequest(request: mRequest)
        let AHQuoteResponse = resp as! MAHQuoteResponse
//        XCTAssertNotNil(AHQuoteResponse)
//        if (AHQuoteResponse == nil){
//            throw BaseTestError.assertFailedError(message: "AHQuoteResponse  is nil")
//        }
        let resultJSON:JSON = [
                "code" : AHQuoteResponse.linkageCode,
                "name" : AHQuoteResponse.linkageName,
                "lastPrice": AHQuoteResponse.lastPrice,
                "premium": AHQuoteResponse.premiumRate,
                "preClosePrice": AHQuoteResponse.preClosePrice,
//                "premiumHA": AHQuoteResponse.premiumRateHA,
                "changeRate": AHQuoteResponse.changeRate
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
    }
    
}
