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

class ExampleTestCase3: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.PlateIndexQuoteREQUEST
    }
    
    func testExample3() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MPlateIndexQuoteRequest()
        mRequest.code = param["QUOTE_NUMBERS"].stringValue
//        mRequest.stockFields = ["-1"]
        let resp = self.makeSyncRequest(request: mRequest)
        let plateIndexQuoteResponse = resp as! MPlateIndexQuoteResponse
        XCTAssertNotNil(plateIndexQuoteResponse.plateIndexItems)
        for item in plateIndexQuoteResponse.plateIndexItems{
            print("\(item)")
            
            onTestResult(param: param, result: JSON())
        }
}

}
