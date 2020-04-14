//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//股东变动
import XCTest
import os.log
import SwiftyJSON

class F10_SHAREHOLDERHISTORYINFO_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_SHAREHOLDERHISTORYINFO_1
    }
    
    func testShareHolderHistoryInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MShareHolderHistoryInfoRequest()
        mRequest.code = param["CODE"].stringValue
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let shareHolderHistoryInfoResponse = resp as! MShareHolderHistoryInfoResponse
        XCTAssertNotNil(shareHolderHistoryInfoResponse.records)
        switch mRequest.sourceType{
            
        case .GA:
            var resultJSON : JSON = [:]
            var i=1
            for records in shareHolderHistoryInfoResponse.records{
                if let record: NSDictionary = records as! NSDictionary{
                    var itemJSON: JSON = [
                        "AVGSHAREM_": record["AVGSHAREM"]!,
                        "CLOSINGPRICE_": record["CLOSINGPRICE"]!,
                        "AVGSHARE_": record["AVGSHARE"]!,
                        "PCTOFTOTALSH_": record["PCTOFTOTALSH"]!,
                        "TOTALSH_": record["TOTALSH"]!,
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
            for records in shareHolderHistoryInfoResponse.records{
                if let record: NSDictionary = records as! NSDictionary{
                    var itemJSON: JSON = [
                        "CLOSINGPRICE_": record["CLOSINGPRICE"]!,
                        "PCTOFTOTALSH_": record["PCTOFTOTALSH"]!,
                        "TOTALSH_": record["TOTALSH"]!,
                        "ENDDATE_": record["ENDDATE"]!
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

