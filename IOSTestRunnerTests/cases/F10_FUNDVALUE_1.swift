//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//基金净值（5日）
import XCTest
import os.log
import SwiftyJSON

class F10_FUNDVALUE_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_FUNDVALUE_1
    }
    
    func testFundNetValue() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFundNetValueRequest()
        mRequest.code = param["CODE"].stringValue
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        let resp = self.makeSyncRequest(request: mRequest)
        let fundNetValueResponse = resp as! MFundNetValueResponse
        XCTAssertNotNil(fundNetValueResponse.records)
        var resultJSON : JSON = [:]
        var i=1
        for records in fundNetValueResponse.records{
            if let record: NSDictionary = records as! NSDictionary{
                var itemJSON: JSON = [
                    "ACCUNITNAV": record["ACCUNITNAV"]!,
                    "UNITNAV": record["UNITNAV"]!,
                    "NAVDATE": record["NAVDATE"]!,
                    "GROWRATE": record["GROWRATE"]!
                ]
                resultJSON["\(i)"] = itemJSON
                i=i+1
            }
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

