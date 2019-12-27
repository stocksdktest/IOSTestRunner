//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//两市港股通数据
import XCTest
import os.log
import SwiftyJSON

class HKMARINFO_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.HKMARINFO_1
    }
   
    func testHKMarketInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MHKMarketInfoRequest()
        
        let resp = self.makeSyncRequest(request: mRequest)
        let hKMarketInfoResponse = resp as! MHKMarketInfoResponse
        XCTAssertNotNil(hKMarketInfoResponse)
        var resultJSON: JSON = [
            "shInitialQuota": hKMarketInfoResponse.shInitialQuota,
            "shRemainQuota": hKMarketInfoResponse.shRemainQuota,
            "shStatus": hKMarketInfoResponse.shStatus,
            "szInitialQuota": hKMarketInfoResponse.szInitialQuota,
            "szRemainQuota": hKMarketInfoResponse.szRemainQuota,
            "szStatus": hKMarketInfoResponse.szStatus
        ]
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

