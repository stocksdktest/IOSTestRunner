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

class F10_TOPLIQUIDSHAREHOLDER_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_TOPLIQUIDSHAREHOLDER_1
    }
    
    func testTopLiquidShareHolder() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MTopLiquidShareHolderRequest()
        mRequest.code = param["CODE"].stringValue
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let topLiquidShareHolderResponse = resp as! MTopLiquidShareHolderResponse
//        XCTAssertNotNil(topLiquidShareHolderResponse.records)
        if (topLiquidShareHolderResponse.records == nil){
            throw BaseTestError.assertFailedError(message: "topLiquidShareHolderResponse records is nil")
        }
        switch mRequest.sourceType{
            
        case .GA:
            var resultJSON : JSON = [:]
            var i=1
            for records in topLiquidShareHolderResponse.records{
                if let record: NSDictionary = records as! NSDictionary{
                    var itemJSON: JSON = [
                        "SHNO_": record["SHNO"]!,
                        "SHNAME_": record["SHNAME"]!,
                        "SHCODE_": record["SHCODE"]!,
                        "PCTTOTALSHAREUR_": record["PCTTOTALSHAREUR"]!,
                        "HOLDASHAREUR_": record["HOLDASHAREUR"]!,
                        "ENDDATE_": record["ENDDATE"]!,
                        "DIFF_": record["DIFF"]!
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
            for records in topLiquidShareHolderResponse.records{
                if let record: NSDictionary = records as! NSDictionary{
                    var itemJSON: JSON = [
                        "SHNAME_": record["SHNAME"]!,
                        "PCTTOTALSHAREUR_": record["PCTTOTALSHAREUR"]!,
                        "ENDDATE_": record["ENDDATE"]!,
                        "DIFF_": record["DIFF"]!,
                        "SHCODE_": record["SHCODE"]!,
                        "HOLDASHAREUR_": record["HOLDASHAREUR"]!
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

