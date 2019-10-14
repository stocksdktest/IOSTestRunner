//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//债券回购
import XCTest
import os.log
import SwiftyJSON

class BondBuyBacksTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.BondBuyBacksTestCase
    }
    
    func testBondBuyBacks() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MBondBuyBacksRequest()
        mRequest.code = param["CODE"].stringValue
        
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
         mRequest.sourceType = typeVal
         }
        let resp = self.makeSyncRequest(request: mRequest)
        let bondBuyBacksResponse = resp as! MBondBuyBacksResponse
        XCTAssertNotNil(bondBuyBacksResponse.record)
        if let item = bondBuyBacksResponse.record{
        var resultJSON: JSON = [
        "BONDNAME":item["BONDNAME"]!,
        "BONDSNAME":item["BONDSNAME"]!,
        "SYMBOL":item["SYMBOL"]!,
        "EXERENDDATE":item["EXERENDDATE"]!,
        "PARVALUE":item["PARVALUE"]!,
        "CONVERTRATE":item["CONVERTRATE"]!,
        "CONVERTPRC":item["CONVERTPRC"]!,
        "REPAYDATE":item["REPAYDATE"]!,
             ]
print(resultJSON)
onTestResult(param: param, result: resultJSON)
            
}
}
}

