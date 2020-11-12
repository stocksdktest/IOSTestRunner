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

class TICK_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.TICK_1
    }
    var i = 0
    var str = ""
    func testTimeTick() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MTimeTickRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        mRequest.pageSize = 100
        mRequest.index = "0"
        mRequest.type = MTimeTickRequestType.init(rawValue: -1)!
        
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
        
        var ItemsCount = timeTickResponse.items.count
        var EndIndex = timeTickResponse.endIndex!
        if ItemsCount != 100{
//            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
            while ItemsCount == 100{

                try timeTickNext(index: &EndIndex , count: &ItemsCount , result: &resultJSON)
                if ItemsCount != 100{
//                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
            }
    }
    func timeTickNext( index :  inout String , count : inout Int , result : inout JSON) throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequestNext = MTimeTickRequest()
        mRequestNext.code = param["CODE"].stringValue
        mRequestNext.subtype = param["SUBTYPE"].stringValue
        mRequestNext.index = index
        mRequestNext.pageSize = 100
        mRequestNext.type = MTimeTickRequestType.init(rawValue: 1)!
        let resp = try self.makeSyncRequest(request: mRequestNext)
        let timeTickResponseNext = resp as! MTimeTickResponse
        if (timeTickResponseNext.items == nil){
            throw BaseTestError.assertFailedError(message: "timeTickResponseNext items is nil")
        }
        if timeTickResponseNext.items != nil{
//            print(timeTickResponseNext)
//            print(timeTickResponseNext.items.count)
            for item in timeTickResponseNext.items{
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
                    result["\(item.time!)\(i)"] = itemJSON
                    i=i+1
                }else{
                    result["\(item.time!)"] = itemJSON
                    i = 1
                }
                
            }
            index = timeTickResponseNext.endIndex
            count = timeTickResponseNext.items.count

        }
        
    }
}
