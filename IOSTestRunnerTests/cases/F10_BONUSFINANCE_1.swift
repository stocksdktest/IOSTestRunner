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

class F10_BONUSFINANCE_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_BONUSFINANCE_1
    }
    
    func testBonusFinance() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MBonusFinanceRequest()
        mRequest.code = param["CODE"].stringValue
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        let resp = self.makeSyncRequest(request: mRequest)
        let bonusFinanceResponse = resp as! MBonusFinanceResponse
        XCTAssertNotNil(bonusFinanceResponse.records)
        var resultJSON : JSON = [:]
        for record in bonusFinanceResponse.records{
            
                if let BFrecord:NSDictionary = record as? NSDictionary{
                var itemJSON: JSON = [
                    "ExDiviDate": BFrecord["EXDIVIDATE"]!,
                    "DiviScheme": BFrecord["DIVISCHEME"]!,
                    "NoticeDate": BFrecord["NOTICEDATE"]!
                ]
                    resultJSON["\(BFrecord["NOTICEDATE"]!)"] = itemJSON
                    
                }
            
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

