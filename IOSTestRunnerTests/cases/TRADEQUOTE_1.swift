//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//交易行情数据接口xx
import XCTest
import os.log
import SwiftyJSON

class TRADEQUOTE_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.TRADEQUOTE_1
    }

    func testTradeQuote() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MTradeQuoteRequest()
        mRequest.code = param["CODE"].stringValue
        
        let resp = self.makeSyncRequest(request: mRequest)
        let tradeQuoteResponse = resp as! MTradeQuoteResponse
        XCTAssertNotNil(tradeQuoteResponse.tradeItem)
        
        if let item = tradeQuoteResponse.tradeItem{
            var resultJSON: JSON = [
                "id": item.code,
                "subtype": item.subtype,
                "name": item.name,
                "lastPrice": item.lastPrice,
                "preClosePrice": item.preClosePrice,
                "limitUp": item.limitUp,
                "limitDown": item.limitDown,
                "change": item.change,
                
//                "changeRate": item.changeRate,
//                "upDownFlag": item.changeState,
                "quantityUnitBuy": item.buyVolumeUnit,
                "quantityUnitSell": item.sellVolumeUnit,
                "pricePosition": item.priceUnit,
                "hkPriceDifferenceCategory": item.priceDiffType,
                "buyPrices": item.buyPrices,
                "buyVolumes":item.buyVolumes,
                "sellPrices":item.sellPrices,
                "sellVolumes":item.sellVolumes,
                ]
            switch item.changeState{
                
            case .flat:
                resultJSON["changeRate"].string = item.changeRate
            case .rise:
                resultJSON["changeRate"].string = "+"+item.changeRate
            case .drop:
                resultJSON["changeRate"].string = "-"+item.changeRate
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
      }
        
   }
}
