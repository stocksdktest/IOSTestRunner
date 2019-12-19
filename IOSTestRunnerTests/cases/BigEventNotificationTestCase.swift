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

class BigEventNotificationTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.BigEventNotificationTestCase
    }
    
    func testBigEventNotification() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MBigEventNotificationRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        
        
        let resp = self.makeSyncRequest(request: mRequest)
        let bigEventNotificationResponse = resp as! MBigEventNotificationResponse
        XCTAssertNotNil(bigEventNotificationResponse.records)
        var resultJSON : JSON = [:]
        for record in bigEventNotificationResponse.records{
            if let BENrecord:NSDictionary = record as? NSDictionary{
                var itemJSON: JSON = [
                    "PUBDATE_": BENrecord["PUBDATE"]!,
                    "diviScheme": BENrecord["DIVISCHEME"]!
                ]
                resultJSON["\(BENrecord["PUBDATE"]!)"] = itemJSON
                
            }
            
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

