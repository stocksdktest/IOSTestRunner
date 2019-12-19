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

class StockShareChangeInfoTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.StockShareChangeInfoTestCase
    }
    
    func testStockShareChangeInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStockShareChangeInfoRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let stockShareChangeInfoResponse = resp as! MStockShareChangeInfoResponse
        XCTAssertNotNil(stockShareChangeInfoResponse.records)
        switch mRequest.sourceType{
            
        case .GA:
            var resultJSON : JSON = [:]
            for records in stockShareChangeInfoResponse.records{
                if let record: NSDictionary = records as! NSDictionary{
                    var itemJSON: JSON = [
                        "totalShare": record["TOTALSHARE"]!,
                        "CONSTDESC_": record["CONSTDESC"]!,
                        "aListedShare": record["ALISTEDSHARE"]!,
                        "lastChangeDate": record["LASTCHANGEDATE"]!
                    ]
                    resultJSON["\(record["LASTCHANGEDATE"]!)"] = itemJSON
                    
                }
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        case .CH:
            var resultJSON : JSON = [:]
            for records in stockShareChangeInfoResponse.records{
                if let record: NSDictionary = records as! NSDictionary{
                    var itemJSON: JSON = [
                        "totalShare": record["TOTALSHARE"]!,
                        "CONSTDESC_": record["CONSTDESC"]!,
                        "lastChangeDate": record["LASTCHANGEDATE"]!,
                        "changeamt": record["CHANGEAMT"]!,
                        "changedire": record["CHANGEDIRE"]!
                    ]
                    resultJSON["\(record["LASTCHANGEDATE"]!)"] = itemJSON
                    
                }
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
        
        
    }
}

