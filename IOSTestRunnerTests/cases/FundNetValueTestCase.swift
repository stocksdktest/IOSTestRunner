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

class FundNetValueTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.FundNetValueTestCase
    }
    
    func testFundNetValue() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFundNetValueRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        let resp = self.makeSyncRequest(request: mRequest)
        let fundNetValueResponse = resp as! MFundNetValueResponse
        XCTAssertNotNil(fundNetValueResponse.records)
        for records in fundNetValueResponse.records{
            if let record: NSDictionary = records as! NSDictionary{
                var resultJSON: JSON = [
                    "ACCUNITNAV": record["ACCUNITNAV"]!,
                    "UNITNAV": record["UNITNAV"]!,
                    "NAVDATE": record["NAVDATE"]!,
                    "GROWRATE": record["GROWRATE"]!
                ]
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
    }
}

