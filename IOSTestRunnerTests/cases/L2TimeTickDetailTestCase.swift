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

class L2TimeTickDetailTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.L2TimeTickDetailTestCase
    }
    
    func testL2TimeTickDetail() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = ML2TimeTickDetailRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        mRequest.index = param["INDEX"].stringValue
        mRequest.pageSize = param["PAGESIZE"].uIntValue
        if let typeVal = MTimeTickRequestType.init(rawValue: param["TYPE"].intValue){
            mRequest.type = typeVal
        }
        let resp = self.makeSyncRequest(request: mRequest)
        let timeTickResponse = resp as! ML2TimeTickDetailResponse
        XCTAssertNotNil(timeTickResponse.items)
        for item in timeTickResponse.items{
            var resultJSON:JSON = [
                "type" : item.type.rawValue,
                "time" : item.time,
                "tradeVolume" : item.tradeVolume,
                "tradePrice" : item.tradePrice
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
        
        var ItemsCount = timeTickResponse.items.count
        var EndIndex = timeTickResponse.endIndex!
        
        while ItemsCount == 100{
            
            timeTickNext(index: &EndIndex , count: &ItemsCount)
        }
        
    }
    func timeTickNext( index :  inout String , count : inout Int){
        let param = self.testCaseRoundConfig.getParam()
        let mRequestNext = ML2TimeTickDetailRequest()
        mRequestNext.code = param["CODE"].stringValue
        mRequestNext.subtype = param["SUBTYPE"].stringValue
        mRequestNext.index = index
        mRequestNext.pageSize = param["PAGESIZE"].uIntValue
        if let typeValNext = MTimeTickRequestType.init(rawValue: 1){
            mRequestNext.type = typeValNext
        }
        let resp = self.makeSyncRequest(request: mRequestNext)
        let timeTickResponseNext = resp as! ML2TimeTickDetailResponse
        if timeTickResponseNext.items != nil{
            for item in timeTickResponseNext.items{
                var resultJSON:JSON = [
                    "type" : item.type.rawValue,
                    "time" : item.time,
                    "tradeVolume" : item.tradeVolume,
                    "tradePrice" : item.tradePrice
                ]
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
            index = timeTickResponseNext.endIndex
            count = timeTickResponseNext.items.count
            
        }
        
    }
}
