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

class F10_BNDINTERESTPAY_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_BNDINTERESTPAY_1
    }
    
    func testBondInterestPay() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MBondInterestPayRequest()
        mRequest.code = param["CODE"].stringValue
        
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        let resp = try self.makeSyncRequest(request: mRequest)
        let bondInterestPayResponse = resp as! MBondInterestPayResponse
//        XCTAssertNotNil(bondInterestPayResponse.record)
        if (bondInterestPayResponse.record == nil){
                   throw BaseTestError.assertFailedError(message: "bondInterestPayResponse record is nil")
               }
        if let item = bondInterestPayResponse.record{
            var resultJSON: JSON = [
                "BONDNAME":item["BONDNAME"]!,
                "BONDSNAME":item["BONDSNAME"]!,
                "SYMBOL":item["SYMBOL"]!,
                "PERPAYDATEYEAR":item["PERPAYDATEYEAR"]!,
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

