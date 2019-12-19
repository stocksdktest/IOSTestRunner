//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//基金分红
import XCTest
import os.log
import SwiftyJSON

class FundDividendTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.FundDividendTestCase
    }
    
    func testFundDividend() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFundDividendRequest()
        mRequest.code = param["CODE"].stringValue
        
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
         mRequest.sourceType = typeVal
         }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let fundDividendResponse = resp as! MFundDividendResponse
        XCTAssertNotNil(fundDividendResponse.record)
      
        if let item = fundDividendResponse.record{
       
            var resultJSON: JSON = [
                "DEFSHAREMODE":item["DEFSHAREMODE"]!,
                "INNERDEVDATE":item["INNERDEVDATE"]!,
                "INNERDEVPSETDATE":item["INNERDEVPSETDATE"]!,
                "INNERRIGHTDATE":item["INNERRIGHTDATE"]!,
                "ISBONUS":item["ISBONUS"]!,
                "PUBLISHDATE":item["PUBLISHDATE"]!,
                "RECORDDATE":item["RECORDDATE"]!,
                "UNITPTAXDEV":item["UNITPTAXDEV"]!,
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
}

