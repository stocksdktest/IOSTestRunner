//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//财务指标
import XCTest
import os.log
import SwiftyJSON

class FinancialSummaryTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.FinancialSummaryTestCase
    }
    
    func testFinancialSummary() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFinancialSummaryRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        if let param = param["PARAM"].dictionary{
            mRequest.param = param
        }
        let resp = self.makeSyncRequest(request: mRequest)
        let financialSummaryResponse = resp as! MFinancialSummaryResponse
        XCTAssertNotNil(financialSummaryResponse.jsonObject)
        
    }
}

