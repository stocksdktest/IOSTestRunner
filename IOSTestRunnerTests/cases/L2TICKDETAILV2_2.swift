//
//  L2TimeTickDetailTestCase.swift
//  IOSTestRunnerTests
//
//  Created by 俞建斌 on 2019/9/20.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class L2TICKDETAILV2_2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.L2TICKDETAILV2_2
    }
    
    func testL2TimeTickDetail() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = ML2TimeTickDetailRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        
        let paramI:NSArray = (param["page"].string?.split(separator: ",") as! NSArray)
        mRequest.pageSize = UInt(paramI[1] as! String)!
        mRequest.index = paramI[0] as! String
        mRequest.type = MTimeTickRequestType.init(rawValue: Int(paramI[2] as! String)!)!
        
        
        let resp = self.makeSyncRequest(request: mRequest)
        let timeTickResponse = resp as! ML2TimeTickDetailResponse
        XCTAssertNotNil(timeTickResponse.items)
        var resultJSON : JSON = [:]
        for item in timeTickResponse.items{
            var itemJSON:JSON = [
                "type" : item.type.rawValue,
                "time" : item.time,
                "tradeVolume" : item.tradeVolume,
                "tradePrice" : item.tradePrice
            ]
            resultJSON["\(item.time!)"] = itemJSON
            
        }
        
        
        
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
    
}
