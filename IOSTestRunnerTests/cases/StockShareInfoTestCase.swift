//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//股本结构
import XCTest
import os.log
import SwiftyJSON

class StockShareInfoTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.StockShareInfoTestCase
    }
    
    func testStockShareInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStockShareInfoRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let stockShareInfoResponse = resp as! MStockShareInfoResponse
        XCTAssertNotNil(stockShareInfoResponse.record)
        if let record: NSDictionary = stockShareInfoResponse.record as! NSDictionary{
            var resultJSON: JSON = [
                "totalShareUL": record["TOTALSHAREUL"]!,
                "HRatio": record["HRATIO"]!,
                "ARatio": record["ARATIO"]!,
                "AListedShare": record["ALISTEDSHARE"]!,
                "BListedShare": record["BLISTEDSHARE"]!,
                "BRatio": record["BRATIO"]!,
                "totalShareUR": record["TOTALSHAREUR"]!,
                "URRatio": record["URRATIO"]!,
                "TotalShare": record["TOTALSHARE"]!,
                "TotalShareL": record["TOTALSHAREL"]!,
                "LRatio": record["LRATIO"]!,
                "ULRatio": record["ULRATIO"]!,
                "HTotalShare": record["HTOTALSHARE"]!
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
}

