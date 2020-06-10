//
//  OHLCSub.swift
//  IOSTestRunnerTests
//
//  Created by 俞建斌 on 2019/9/20.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class OHLCSUB_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OHLCSUB_1
    }
    
    func testOHLCSub() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MOHLCRequestV2()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        mRequest.period = MOHLCPeriod.init(rawValue:0)!
        mRequest.priceAdjustedMode = MOHLCPriceAdjustedMode.init(rawValue:0)!
        let resp = try self.makeSyncRequest(request: mRequest)
        let oHLCSubResponse = resp as! MOHLCResponse
//        XCTAssertNotNil(oHLCSubResponse.fqItems)
        if (oHLCSubResponse.fqItems == nil){
            throw BaseTestError.assertFailedError(message: "oHLCSubResponse fqItems is nil")
        }
        var resultJSON : JSON = [:]
        for items in oHLCSubResponse.fqItems{
            var jsonarr2: JSON = [
                "dateTime":items.dateTime,
                "increasePrice":items.increasePrice,
                "allotmentPrice":items.allotmentPrice,
                "bonusAmount":items.bonusAmount,
                "bonusProportion":items.bonusProportion,
                "increaseProportion":items.increaseProportion,
                "increaseVolume":items.increaseVolume,
                "allotmentProportion":items.allotmentProportion,
            ]
            resultJSON["\(items.dateTime!)"] = jsonarr2
            
        }
        
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}
