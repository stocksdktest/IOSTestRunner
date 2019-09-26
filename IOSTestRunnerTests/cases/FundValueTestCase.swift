//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//基金净值(12个月)
import XCTest
import os.log
import SwiftyJSON

class FundValueTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.FundValueTestCase
    }
    
    func testFundValue() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFundValueRequest()
        mRequest.code = param["CODE"].stringValue
       
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }

        let resp = self.makeSyncRequest(request: mRequest)
        let fundValueResponse = resp as! MFundValueResponse
        XCTAssertNotNil(fundValueResponse.items)
        for items in fundValueResponse.items{
            if let item: NSDictionary = items as! NSDictionary{
                var resultJSON: JSON = [
                    "UnitNAV_": item["UnitNAV"]!,
                    "ENDDATE_": item["ENDDATE"]!
                ]
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        
    }
}

