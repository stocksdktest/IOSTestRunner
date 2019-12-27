//
//  File.swift
//  IOSTestRunnerTests
//
//  Created by HW1-MM01 on 2019/9/10.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class COMPOUNDUPDOWN_1: BaseTestCase{
    
    override var stockTestCaseName: StockTestCaseName{
        return StockTestCaseName.COMPOUNDUPDOWN_1
    }
    
    func testCompoundUpdowns(){
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MCompoundUpdownsRequest()
        mRequest.code = param["MARKET"].stringValue
        mRequest.type = MCompoundUpdownsType(rawValue: param["TYPE"].uIntValue)!
        mRequest.time = param["TIME"].stringValue
        
        let resp = self.makeSyncRequest(request: mRequest)
        let compoundUpdownsResponse = resp as! MCompoundUpdownsResponse
        XCTAssertNotNil(compoundUpdownsResponse)
        var resultJSON : JSON = [:]
        
        for item in compoundUpdownsResponse.items{
            var itemJSON : JSON = [
                "dateTime" : item.dateTime,
                "riseCount": item.riseCount,
                "fallCount": item.fallCount,
                "flatCount": item.flatCount,
                "stopCount": item.stopCount,
                "riseLimitCount": item.riseLimitCount,
                "fallLimitCount": item.fallLimitCount,
                "oneRiseLimitCount": item.oneRiseLimitCount,
                "natureRiseLimitCount": item.natureRiseFallCount,
                "riseFallRange": item.riseFallRange
            ]
            resultJSON["\(item.dateTime!)"] = itemJSON
        }
//        var resultJSON : JSON = [resultDIC]
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
        
    }
}
