//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//付息情况
import XCTest
import os.log
import SwiftyJSON

class BondInterestPayTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.BondInterestPayTestCase
    }
    
    func testBondInterestPay() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MBondInterestPayRequest()
        mRequest.code = param["CODE"].stringValue
        
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
      mRequest.sourceType = typeVal
      }
        let resp = self.makeSyncRequest(request: mRequest)
        let bondInterestPayResponse = resp as! MBondInterestPayResponse
        XCTAssertNotNil(bondInterestPayResponse.record)
        if let item = bondInterestPayResponse.record{
            var resultJSON: JSON = [
                "BONDNAME":item["BONDNAME"]!,
                "BONDSNAME":item["BONDSNAME"]!,
                "SYMBOL":item["SYMBOL"]!,
                "EXERENDDATE":item["PERPAYDATEYEAR"]!,
                "PRETAXINT":item["PRETAXINT"]!,
                "IPRATE":item["IPRATE"]!,
                "EQURECORDDATE":item["EQURECORDDATE"]!,
                "PERPAYDATE":item["PERPAYDATE"]!,
                "XDRDATE":item["XDRDATE"]!,
                "REPAYDATE":item["REPAYDATE"]!,
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
            
        }
    }
}

