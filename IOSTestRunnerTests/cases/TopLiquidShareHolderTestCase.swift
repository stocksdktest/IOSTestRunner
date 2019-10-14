//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//最新自然人持股
import XCTest
import os.log
import SwiftyJSON

class TopLiquidShareHolderTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.TopLiquidShareHolderTestCase
    }
    
    func testTopLiquidShareHolder() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MTopLiquidShareHolderRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let topLiquidShareHolderResponse = resp as! MTopLiquidShareHolderResponse
        XCTAssertNotNil(topLiquidShareHolderResponse.records)
        switch mRequest.sourceType{
            
        case .GA:
            for records in topLiquidShareHolderResponse.records{
                if let record: NSDictionary = records as! NSDictionary{
                    var resultJSON: JSON = [
                        "SHNO_": record["SHNO"]!,
                        "SHNAME_": record["SHNAME"]!,
                        "SHCODE_": record["SHCODE"]!,
                        "PCTTOTALSHAREUR_": record["PCTTOTALSHAREUR"]!,
                        "HOLDASHAREUR_": record["HOLDASHAREUR"]!,
                        "ENDDATE_": record["ENDDATE"]!,
                        "DIFF_": record["DIFF"]!
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
            }
        case .CH:
            for records in topLiquidShareHolderResponse.records{
                if let record: NSDictionary = records as! NSDictionary{
                    var resultJSON: JSON = [
                        "SHNAME_": record["SHNAME"]!,
                        "PCTTOTALSHAREUR_": record["PCTTOTALSHAREUR"]!,
                        "ENDDATE_": record["ENDDATE"]!,
                        "DIFF_": record["DIFF"]!,
                        "SHCODE_": record["SHCODE"]!,
                        "HOLDASHAREUR_": record["HOLDASHAREUR"]!
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
            }
        }
        
        
    }
}

