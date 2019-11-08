//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//基金财务
import XCTest
import os.log
import SwiftyJSON

class FundFinanceTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.FundFinanceTestCase
    }
    
    func testFundFinance() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFundFinanceRequest()
        mRequest.code = param["CODE"].stringValue
        
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
          mRequest.sourceType = typeVal
          }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let fundFinanceResponse = resp as! MFundFinanceResponse
        XCTAssertNotNil(fundFinanceResponse.record)
        if let item = fundFinanceResponse.record{
            var resultJSON: JSON = [
                "PUBLISHDATE":item["PUBLISHDATE"]!,
                "ENDDATE":item["ENDDATE"]!,
                "UNFDDISTNETINC":item["UNFDDISTNETINC"]!,
                "FINAUNFDASSNAV":item["FINAUNFDASSNAV"]!,
                "FDNETPROPER":item["FDNETPROPER"]!,
                "FINAFDASSETNAV":item["FINAFDASSETNAV"]!,
                "NAVGRORATE":item["NAVGRORATE"]!,
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
}

