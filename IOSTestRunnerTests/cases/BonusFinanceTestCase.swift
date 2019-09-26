//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//分红配送
import XCTest
import os.log
import SwiftyJSON

class BonusFinanceTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.BonusFinanceTestCase
    }
    
    func testBonusFinance() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MBonusFinanceRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        
        
        let resp = self.makeSyncRequest(request: mRequest)
        let bonusFinanceResponse = resp as! MBonusFinanceResponse
        XCTAssertNotNil(bonusFinanceResponse.records)
        for record in bonusFinanceResponse.records{
            
                if let BFrecord:NSDictionary = record as? NSDictionary{
                var resultJSON: JSON = [
                    "ExDiviDate": BFrecord["EXDIVIDATE"]!,
                    "DiviScheme": BFrecord["DIVISCHEME"]!,
                    "NoticeDate": BFrecord["NOTICEDATE"]!
                ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
            
        }
    }
}

