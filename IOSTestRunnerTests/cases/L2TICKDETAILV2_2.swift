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
    var i = 1
    var str = ""
    func testL2TimeTickDetail() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = ML2TimeTickDetailRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        
        let paramI:NSArray = (param["page"].string?.split(separator: ",") as! NSArray)
        mRequest.pageSize = UInt(paramI[1] as! String)!
        mRequest.index = paramI[0] as! String
        mRequest.type = MTimeTickRequestType.init(rawValue: Int(paramI[2] as! String)!)!
        
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let timeTickResponse = resp as! ML2TimeTickDetailResponse
//        XCTAssertNotNil(timeTickResponse.items)
        if (timeTickResponse.items == nil){
            throw BaseTestError.assertFailedError(message: "timeTickResponse items is nil")
        }
        var resultJSON : JSON = [:]
        for item in timeTickResponse.items{
            var itemJSON:JSON = [
                "type" : item.type.rawValue,
                "time" : item.time,
                "tradeVolume" : item.tradeVolume,
                "tradePrice" : item.tradePrice
            ]
            switch String(item.type.rawValue) {
            case "1":
                itemJSON["type"] = "B"
            case "2":
                itemJSON["type"] = "S"
            default:
                itemJSON["type"] = "-"
            }
            if(str == "\(item.time!)"){
                resultJSON["\(item.time!)\(i)"] = itemJSON
                i=i+1
            }else{
                resultJSON["\(item.time!)"] = itemJSON
                i = 1
            }
            str = "\(item.time!)"
            
        }
        
        
        
//        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
    
}
