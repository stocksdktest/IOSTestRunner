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

class TopShareHolderTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.TopShareHolderTestCase
    }
    
    func testTopShareHolder() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MTopShareHolderRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let topShareHolderResponse = resp as! MTopShareHolderResponse
        XCTAssertNotNil(topShareHolderResponse.records)
        switch mRequest.sourceType{
            
        case .GA:
            for records in topShareHolderResponse.records{
                if let record:NSDictionary = records as! NSDictionary{
                    var resultJSON: JSON = [
                        "SHNO_": record["SHNO"]!,
                        "SHNAME_": record["SHNAME"]!,
                        "SHCODE_": record["SHCODE"]!,
                        "PCTTOTALSHAREUR_": record["PCTTOTALSHAREUR"]!,
                        "DIFF_": record["DIFF"]!,
                        "HOLDASHAREUR_": record["HOLDSHARE"]!
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
            }
        case .CH:
            for records in topShareHolderResponse.records{
                if let record:NSDictionary = records as! NSDictionary{
                    var resultJSON: JSON = [
                        "SHNAME_": record["SHNAME"]!,
                        "PCTTOTALSHAREUR_": record["PCTTOTALSHAREUR"]!,
                        "DIFF_": record["DIFF"]!,
                        "ENDDATE_": record["ENDDATE"]!,
                        "SHCODE_":record["SHCODE"]!,
                        "HOLDASHAREUR_":record["HOLDASHAREUR"]!
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
            }
        }
    }
}

