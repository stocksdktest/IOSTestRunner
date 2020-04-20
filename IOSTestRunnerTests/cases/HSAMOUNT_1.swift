//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//沪股通和深股通额度数据接口
import XCTest
import os.log
import SwiftyJSON

class HSAMOUNT_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.HSAMOUNT_1
    }
    func testSAmount() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MHSAmountRequest()
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let hSAmountResponse = resp as! MHSAmountResponse
//        XCTAssertNotNil(hSAmountResponse)
        var resultJSON: JSON = [
            "shInitialQuota":hSAmountResponse.shInitialAmount,
            "shRemainQuota":hSAmountResponse.shRemainingAmount,
            "szInitialQuota":hSAmountResponse.szInitialAmount,
            "szRemainQuota":hSAmountResponse.szRemainingAmount,
        ]
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

