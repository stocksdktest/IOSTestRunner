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

class OHLCSubTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OHLCSubTestCase
    }
    
    func testOHLCSub() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MOHLCRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        if let typeVal = MOHLCPeriod.init(rawValue:param["PERIOD"].uIntValue) {
            mRequest.period = typeVal
        }
        if let typeVal = MOHLCPriceAdjustedMode.init(rawValue:param["PRICEADJUSTEDMODE"].intValue) {
            mRequest.priceAdjustedMode = typeVal
        }
        let resp = self.makeSyncRequest(request: mRequest)
        let oHLCSubResponse = resp as! MOHLCResponse
        XCTAssertNotNil(oHLCSubResponse.fqItems)
        var jsonarr1 = [JSON]()
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
            jsonarr1.append(jsonarr2)
            
        }
        var resultJSON: JSON = [
            "fqItem": jsonarr1
        ]
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}
