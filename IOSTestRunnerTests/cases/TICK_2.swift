//
//  TimeTickTestCase.swift
//  IOSTestRunnerTests
//
//  Created by HW1-MM01 on 2019/9/10.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class TICK_2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.TICK_2
    }
    var i = 0
    var str = ""
    func testTimeTick() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MTimeTickRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        let paramI:NSArray = (param["page"].string?.split(separator: ",") as! NSArray)
        mRequest.pageSize = UInt(paramI[1] as! String)!
        mRequest.index = paramI[0] as? String
        mRequest.type = MTimeTickRequestType.init(rawValue: Int(paramI[2] as! String)!)!
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let timeTickResponse = resp as! MTimeTickResponse
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
            
        }
//        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
    
}
