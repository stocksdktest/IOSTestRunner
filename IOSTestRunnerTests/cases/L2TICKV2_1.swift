//
//  L2TimeTickTestCase.swift
//  IOSTestRunnerTests
//
//  Created by 俞建斌 on 2019/9/20.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class L2TICKV2_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.L2TICKV2_1
    }
    
    func testL2TimeTick() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = ML2TimeTickRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        mRequest.pageSize = 100
//        mRequest.index = "0"
        mRequest.type = MTimeTickRequestType.init(rawValue: -1)!
        let resp = self.makeSyncRequest(request: mRequest)
        let timeTickResponse = resp as! ML2TimeTickResponse
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
        
        var ItemsCount = timeTickResponse.items.count
        var EndIndex = timeTickResponse.endIndex!
        if ItemsCount != 100{
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
        while ItemsCount == 100{
            
            timeTickNext(index: &EndIndex , count: &ItemsCount , result: &resultJSON)
            if ItemsCount != 100{
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        
    }
    func timeTickNext( index :  inout String , count : inout Int , result : inout JSON){
        let param = self.testCaseRoundConfig.getParam()
        let mRequestNext = ML2TimeTickRequest()
        mRequestNext.code = param["CODE"].stringValue
        mRequestNext.subtype = param["SUBTYPE"].stringValue
        mRequestNext.index = index
        mRequestNext.pageSize = 100
        if let typeValNext = MTimeTickRequestType.init(rawValue: 1){
            mRequestNext.type = typeValNext
        }
        let resp = self.makeSyncRequest(request: mRequestNext)
        let timeTickResponseNext = resp as! ML2TimeTickResponse
        if timeTickResponseNext.items != nil{
            for item in timeTickResponseNext.items{
                var itemJSON:JSON = [
                    "type" : item.type.rawValue,
                    "time" : item.time,
                    "tradeVolume" : item.tradeVolume,
                    "tradePrice" : item.tradePrice
                ]
                result["\(item.time!)"] = itemJSON
            }
            index = timeTickResponseNext.endIndex
            count = timeTickResponseNext.items.count
            
        }
        
    }
}
