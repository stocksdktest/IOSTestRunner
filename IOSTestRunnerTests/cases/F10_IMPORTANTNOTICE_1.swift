//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//大事提醒
import XCTest
import os.log
import SwiftyJSON

class F10_IMPORTANTNOTICE_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_IMPORTANTNOTICE_1
    }
    
    func testBigEventNotification() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MBigEventNotificationRequest()
        mRequest.code = param["CODE"].stringValue
        
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let bigEventNotificationResponse = resp as! MBigEventNotificationResponse
        XCTAssertNotNil(bigEventNotificationResponse.records)
        var resultJSON : JSON = [:]
        var i = 1
        for record in bigEventNotificationResponse.records{
            if let BENrecord:NSDictionary = record as? NSDictionary{
                var itemJSON: JSON = [
                    "PUBDATE_": BENrecord["PUBDATE"]!,
                    "diviScheme": BENrecord["DIVISCHEME"]!
                ]
                resultJSON["\(i)"] = itemJSON
                i = i + 1
            }
            
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

