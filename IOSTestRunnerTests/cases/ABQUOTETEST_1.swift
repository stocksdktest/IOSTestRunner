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

class ABQUOTETEST_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.ABQUOTETEST_1
    }
    
    func testABQuote() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MABQuoteRequet()
        mRequest.code = param["CODE"].stringValue
       
        let resp = try self.makeSyncRequest(request: mRequest)
        let MABQuoteResponse = resp as! MABQuoteResponse
//        XCTAssertNotNil(AHQuoteResponse)
        if (MABQuoteResponse.code == nil){
            throw BaseTestError.assertFailedError(message: "MABQuoteResponse.code  is nil")
        }
        let resultJSON:JSON = [
                "code" : MABQuoteResponse.code,
                "name" : MABQuoteResponse.name,
                "subtype" : MABQuoteResponse.subtype,
                "lastPrice": MABQuoteResponse.lastPrice,
                "change": MABQuoteResponse.change,
                "changeRate": MABQuoteResponse.changeRate,
                "premiumRateAB": MABQuoteResponse.premiumRateAB,
                "premiumRateBA": MABQuoteResponse.premiumRateBA,
                
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
    }
    
}
