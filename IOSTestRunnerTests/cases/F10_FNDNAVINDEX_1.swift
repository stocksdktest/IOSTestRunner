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

class F10_FNDNAVINDEX_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_FNDNAVINDEX_1
    }
    
    func testFundValue() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFundValueRequest()
        mRequest.code = param["CODE"].stringValue
       
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }

        let resp = self.makeSyncRequest(request: mRequest)
        let fundValueResponse = resp as! MFundValueResponse
        XCTAssertNotNil(fundValueResponse.items)
        var resultJSON : JSON = [:]
        for items in fundValueResponse.items{
            if let item: NSDictionary = items as! NSDictionary{
                var itemJSON: JSON = [
                    "UnitNAV_": item["UnitNAV"]!,
                    "ENDDATE_": item["ENDDATE"]!
                ]
                resultJSON["\(item["ENDDATE"]!)"] = itemJSON
                
            }
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

