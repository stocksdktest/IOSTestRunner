//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//历史K线数据
import XCTest
import os.log
import SwiftyJSON

class OHLCV2TestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OHLCV2TestCase
    }
    
    func testOHLCV2() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MOHLCRequestV2()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        if let typeVal = MOHLCPeriod.init(rawValue:param["PERIOD"].uIntValue) {
            mRequest.period = typeVal
        }
        mRequest.date = param["DATE"].stringValue
        if let typeVal = MRequestType.init(rawValue:param["REQUESTTYPE"].uIntValue) {
            mRequest.requestType = typeVal
        }
        if let typeVal = MOHLCPriceAdjustedMode.init(rawValue:param["PRICEADJUSTEDMODE"].intValue) {
             mRequest.priceAdjustedMode = typeVal
        }
   
        let resp = self.makeSyncRequest(request: mRequest)
        let oHLCResponse = resp as! MOHLCResponse
        XCTAssertNotNil(oHLCResponse.ohlcItems)
        XCTAssertNotNil(oHLCResponse.fqItems)
        for item in oHLCResponse.ohlcItems {
            var resultJSON: JSON = [
                "datetime": item.datetime,
                "openPrice": item.openPrice,
                "highPrice": item.highPrice,
                "lowPrice": item.lowPrice,
                "closePrice": item.closePrice,
                "tradeVolume": item.tradeVolume,
                "averagePrice": item.averagePrice,
                "reference_price": item.referencePrice,
                "transaction_price": item.amount,
                "openInterest": item.openInterest,
                "fp_volume": item.afterHoursVolume,
                "fp_amount": item.afterHoursAmount
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
        for item in oHLCResponse.fqItems{
            var resultJSON: JSON = [
                "dateTime": item.dateTime,
                "increasePrice": item.increasePrice,
                "allotmentPrice": item.allotmentPrice,
                "bonusAmount": item.bonusAmount,
                "bonusProportion": item.bonusProportion,
                "increaseProportion": item.increaseProportion,
                "increaseVolume": item.increaseVolume,
                "allotmentProportion": item.allotmentProportion
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
}

