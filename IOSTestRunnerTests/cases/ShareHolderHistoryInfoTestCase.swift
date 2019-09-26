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

class ShareHolderHistoryInfoTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.ShareHolderHistoryInfoTestCase
    }
    
    func testShareHolderHistoryInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MShareHolderHistoryInfoRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let shareHolderHistoryInfoResponse = resp as! MShareHolderHistoryInfoResponse
        XCTAssertNotNil(shareHolderHistoryInfoResponse.records)
        switch mRequest.sourceType{
            
        case .GA:
            for records in shareHolderHistoryInfoResponse.records{
                if let record: NSDictionary = records as! NSDictionary{
                    var resultJSON: JSON = [
                        "AVGSHAREM_": record["AVGSHAREM"]!,
                        "CLOSINGPRICE_": record["CLOSINGPRICE"]!,
                        "AVGSHARE_": record["AVGSHARE"]!,
                        "PCTOFTOTALSH_": record["PCTOFTOTALSH"]!,
                        "TOTALSH_": record["TOTALSH"]!,
                        "ENDDATE_": record["ENDDATE"]!
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
            }
        case .CH:
            for records in shareHolderHistoryInfoResponse.records{
                if let record: NSDictionary = records as! NSDictionary{
                    var resultJSON: JSON = [
                        "CLOSINGPRICE_": record["CLOSINGPRICE"]!,
                        "PCTOFTOTALSH_": record["PCTOFTOTALSH"]!,
                        "TOTALSH_": record["TOTALSH"]!,
                        "ENDDATE_": record["ENDDATE"]!
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
            }
        }
        
        
    }
}

