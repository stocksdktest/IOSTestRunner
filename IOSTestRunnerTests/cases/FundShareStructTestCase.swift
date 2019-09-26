//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//份额结构
import XCTest
import os.log
import SwiftyJSON

class FundShareStructTestCase: BaseTestCase {    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.FundShareStructTestCase
    }
    
    func testFundShareStruct() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFundShareStructRequest()
        mRequest.code = param["CODE"].stringValue
        
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
    mRequest.sourceType = typeVal
     }
        let resp = self.makeSyncRequest(request: mRequest)
        let fundShareStructResponse = resp as! MFundShareStructResponse
        XCTAssertNotNil(fundShareStructResponse.records)
        for items in fundShareStructResponse.records{
        if let item: NSDictionary = items as! NSDictionary{
        var resultJSON: JSON = [
                    "ENDDATE":item["ENDDATE"]!,
                    "ENDFDSHARE":item["ENDFDSHARE"]!,
                    "SUBSHARETOT":item["SUBSHARETOT"]!,
                    "REDTOTSHARE":item["REDTOTSHARE"]!,
                ]
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
    }
}


