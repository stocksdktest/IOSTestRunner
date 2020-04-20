//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//指数成分股及沪深市场涨跌平家数
import XCTest
import os.log
import SwiftyJSON

class UPDOWNS_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.UPDOWNS_1
    }
    
    func testIndexUpdowns() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MIndexUpdownsRequest()
        mRequest.code = param["UDCODE"].stringValue
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let indexUpdownsResponse = resp as! MIndexUpdownsResponse
//        XCTAssertNotNil(indexUpdownsResponse)
        let resultJSON: JSON = [
            "upCount":indexUpdownsResponse.advanceCount,
            "downCount":indexUpdownsResponse.declineCount,
            "sameCount":indexUpdownsResponse.equalCount,
        ]
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}
