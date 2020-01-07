//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//最新机构持股
import XCTest
import os.log
import SwiftyJSON

class F10_TOPSHAREHOLDER_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_TOPSHAREHOLDER_1
    }
    
    func testTopShareHolder() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MTopShareHolderRequest()
        mRequest.code = param["CODE"].stringValue
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let topShareHolderResponse = resp as! MTopShareHolderResponse
        XCTAssertNotNil(topShareHolderResponse.records)
        switch mRequest.sourceType{
            
        case .GA:
            var resultJSON : JSON = [:]
            var i=1
            for records in topShareHolderResponse.records{
                if let record:NSDictionary = records as! NSDictionary{
                    var itemJSON: JSON = [
                        "SHNO_": record["SHNO"]!,
                        "SHNAME_": record["SHNAME"]!,
                        "SHCODE_": record["SHCODE"]!,
                        "PCTTOTALSHAREUR_": record["PCTTOTALSHAREUR"]!,
                        "DIFF_": record["DIFF"]!,
                        "HOLDASHAREUR_": record["HOLDSHARE"]!,
                        "ENDDATE_": record["ENDDATE"]!
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
            for records in topShareHolderResponse.records{
                if let record:NSDictionary = records as! NSDictionary{
                    var itemJSON: JSON = [
                        "SHNAME_": record["SHNAME"]!,
                        "PCTTOTALSHAREUR_": record["PCTTOTALSHAREUR"]!,
                        "DIFF_": record["DIFF"]!,
                        "ENDDATE_": record["ENDDATE"]!,
                        "SHCODE_":record["SHCODE"]!,
                        "HOLDASHAREUR_":record["HOLDASHAREUR"]!
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

