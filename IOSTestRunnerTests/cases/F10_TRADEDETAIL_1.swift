//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//融资融券
import XCTest
import os.log
import SwiftyJSON

class F10_TRADEDETAIL_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_TRADEDETAIL_1
    }
    
    func testTradeDetailInfo() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MTradeDetailInfoRequest()
        mRequest.code = param["CODE"].stringValue
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let tradeDetailInfoResponse = resp as! MTradeDetailInfoResponse
//        XCTAssertNotNil(tradeDetailInfoResponse.record)
        if (tradeDetailInfoResponse.record == nil){
            throw BaseTestError.assertFailedError(message: "tradeDetailInfoResponse record is nil")
        }
        print("/*sa-da/*\(tradeDetailInfoResponse.record)")
        if let record: NSDictionary = tradeDetailInfoResponse.record as? NSDictionary{
            var resultJSON: JSON = [
                "payVolumeStock": record["PAYVOLSTOCK"] ?? "-",
                "amountFinance": record["AMOUNTFINA"] ?? "-",
                "payAmountFinance": record["PAYAMOUNTFINA"] ?? "-",
                "buyAmountFinance": record["BUYAMOUNTFINA"] ?? "-",
                "sellVolumeStock": record["SELLVOLSTOCK"] ?? "-",
                "amountStock": record["AMOUNTSTOCK"] ?? "-",
                "tradingDay": record["TRADINGDAY"] ?? "-"
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
}

