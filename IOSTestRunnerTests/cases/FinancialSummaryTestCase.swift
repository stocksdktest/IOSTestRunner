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
//        switch mRequest.sourceType{
//        case .GA:
//            var resultJSON : JSON = [:]
//            if let dic1: NSDictionary = financialSummaryResponse.jsonObject as? NSDictionary{
//                var itemJSON : JSON = [
//                    "REPORTTITLE_": dic1["REPORTTITLE"]!,
//                    "BasicEPS": dic1["BASICEPS"]!,
//                    "RESERVEPS_": dic1["RESERVEPS"]!,
//                    "BVPS_": dic1["BVPS"]!,
//                    "NETCASHFLOWOPERPS_": dic1["NETCASHFLOWOPERPS"]!,
//                    "WEIGHTEDROE_": dic1["WEIGHTEDROE"]!,
//                    "ROA_": dic1["ROA_EBIT"]!,
//                    "TotalOperRevenue": dic1["TOTALOPERINCOMEPS"]!,
//                    "OperProfit": dic1["EBITPS"]!,
//                    "NetProfit": dic1["RETAINEDEARNINGPS"]!,
//
//
//                ]
//            }
//        case .CH:
//            <#code#>
//        }
    }
}

