//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//财务报表
import XCTest
import os.log
import SwiftyJSON

class FinancialInfoTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.FinancialInfoTestCase
    }
    
    func testFinancialInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFinancialInfoRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        if let paramVal = param["PARAM"].dictionary{
            mRequest.param = paramVal
        }
        let resp = self.makeSyncRequest(request: mRequest)
        let financialInfoResponse = resp as! MFinancialInfoResponse
        XCTAssertNotNil(financialInfoResponse.jsonObject)
        if let dic1:NSDictionary = financialInfoResponse.jsonObject as! NSDictionary{
            print(dic1)
        }
    }
}

