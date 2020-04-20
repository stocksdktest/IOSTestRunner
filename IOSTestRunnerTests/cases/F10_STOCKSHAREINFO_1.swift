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

class F10_STOCKSHAREINFO_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_STOCKSHAREINFO_1
    }
    
    func testStockShareInfo() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStockShareInfoRequest()
        mRequest.code = param["CODE"].stringValue
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let stockShareInfoResponse = resp as! MStockShareInfoResponse
//        XCTAssertNotNil(stockShareInfoResponse.record)
        if (stockShareInfoResponse.record == nil){
            throw BaseTestError.assertFailedError(message: "stockShareInfoResponse record is nil")
        }
        if let record: NSDictionary = stockShareInfoResponse.record as! NSDictionary{
            var resultJSON: JSON = [
                "totalShareUL": record["TOTALSHAREUL"]!,
                "HRatio": record["HRATIO"]!,
                "ARatio": record["ARATIO"]!,
                "AListedShare": record["ALISTEDSHARE"]!,
                "BListedShare": record["BLISTEDSHARE"]!,
                "BRatio": record["BRATIO"]!,
                "totalShareUR": record["TOTALSHAREUR"]!,
                
            ]
            let update1: JSON = [
                "URRatio": record["URRATIO"]!,
                "totalShare": record["TOTALSHARE"]!,
                "totalShareL": record["TOTALSHAREL"]!,
                "LRatio": record["LRATIO"]!,
                "ULRatio": record["ULRATIO"]!,
                "HTotalShare": record["HTOTALSHARE"]!
            ]
            do {
                try resultJSON.merge(with: update1)
            } catch {
                // ignore
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
}

