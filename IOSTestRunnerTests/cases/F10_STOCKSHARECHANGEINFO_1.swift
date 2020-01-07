//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//股本变动
import XCTest
import os.log
import SwiftyJSON

class F10_STOCKSHARECHANGEINFO_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_STOCKSHARECHANGEINFO_1
    }
    
    func testStockShareChangeInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStockShareChangeInfoRequest()
        mRequest.code = param["CODE"].stringValue
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let stockShareChangeInfoResponse = resp as! MStockShareChangeInfoResponse
        XCTAssertNotNil(stockShareChangeInfoResponse.records)
        switch mRequest.sourceType{
            
        case .GA:
            var resultJSON : JSON = [:]
            var i=1
            for records in stockShareChangeInfoResponse.records{
                if let record: NSDictionary = records as! NSDictionary{
                    var itemJSON: JSON = [
                        "totalShare": record["TOTALSHARE"]!,
                        "CONSTDESC_": record["CONSTDESC"]!,
                        "aListedShare": record["ALISTEDSHARE"]!,
                        "lastChangeDate": record["LASTCHANGEDATE"]!
                    ]
                    resultJSON["\(i)"] = itemJSON
                    i=i+1
                }
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        case .CH:
            var resultJSON : JSON = [:]
            var i=1
            for records in stockShareChangeInfoResponse.records{
                if let record: NSDictionary = records as! NSDictionary{
                    var itemJSON: JSON = [
                        "totalShare": record["TOTALSHARE"]!,
                        "CONSTDESC_": record["CONSTDESC"]!,
                        "lastChangeDate": record["LASTCHANGEDATE"]!,
                        "changeamt": record["CHANGEAMT"]!,
                        "changedire": record["CHANGEDIRE"]!
                    ]
                    resultJSON["\(i)"] = itemJSON
                    i=i+1
                }
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
        
        
    }
}

