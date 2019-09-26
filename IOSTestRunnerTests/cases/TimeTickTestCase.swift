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

class TimeTickTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.TimeTickTestCase
    }
    
    func testTimeTick() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MTimeTickRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        mRequest.index = param["INDEX"].stringValue
        mRequest.pageSize = param["PAGESIZE"].uIntValue
        if let typeVal = MTimeTickRequestType.init(rawValue: param["TYPE"].intValue){
            mRequest.type = typeVal
        }
        let resp = self.makeSyncRequest(request: mRequest)
        let timeTickResponse = resp as! MTimeTickResponse
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
        let mRequestNext = MTimeTickRequest()
        mRequestNext.code = param["CODE"].stringValue
        mRequestNext.subtype = param["SUBTYPE"].stringValue
        mRequestNext.index = index
        mRequestNext.pageSize = param["PAGESIZE"].uIntValue
        if let typeValNext = MTimeTickRequestType.init(rawValue: 1){
            mRequestNext.type = typeValNext
        }
        let resp = self.makeSyncRequest(request: mRequestNext)
        let timeTickResponseNext = resp as! MTimeTickResponse
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
