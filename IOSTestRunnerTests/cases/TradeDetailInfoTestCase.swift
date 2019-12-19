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

class TradeDetailInfoTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.TradeDetailInfoTestCase
    }
    
    func testTradeDetailInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MTradeDetailInfoRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        
        
        let resp = self.makeSyncRequest(request: mRequest)
        let tradeDetailInfoResponse = resp as! MTradeDetailInfoResponse
        XCTAssertNotNil(tradeDetailInfoResponse.record)
        if let record = tradeDetailInfoResponse.record{
            var resultJSON: JSON = [
                "payVolumeStock": record["PAYVOLSTOCK"]!,
                "amountFinance": record["AMOUNTFINA"]!,
                "payAmountFinance": record["PAYAMOUNTFINA"]!,
                "buyAmountFinance": record["BUYAMOUNTFINA"]!,
                "sellVolumeStock": record["SELLVOLSTOCK"]!,
                "amountStock": record["AMOUNTSTOCK"]!,
                "tradingDay": record["TRADINGDAY"]!
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
}

