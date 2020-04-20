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

class F10_SHARESTRUCTURE_1: BaseTestCase {
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_SHARESTRUCTURE_1
    }
    
    func testFundShareStruct() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFundShareStructRequest()
        mRequest.code = param["CODE"].stringValue
        
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        let resp = try self.makeSyncRequest(request: mRequest)
        let fundShareStructResponse = resp as! MFundShareStructResponse
//        XCTAssertNotNil(fundShareStructResponse.records)
        if (fundShareStructResponse.records == nil){
            throw BaseTestError.assertFailedError(message: "fundShareStructResponse records is nil")
        }
        var resultJSON : JSON = [:]
        var i=1
        for items in fundShareStructResponse.records{
        if let item: NSDictionary = items as! NSDictionary{
        var itemJSON: JSON = [
                    "ENDDATE":item["ENDDATE"]!,
                    "ENDFDSHARE":item["ENDFDSHARE"]!,
                    "SUBSHARETOT":item["SUBSHARETOT"]!,
                    "REDTOTSHARE":item["REDTOTSHARE"]!,
                ]
            resultJSON["\(i)"] = itemJSON
                i=i+1
            }
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}


