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

class TradeQuoteTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.TradeQuoteTestCase
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
//                "buyPrices": item.buyPrices,
//                "buyVolumes": item.buyVolumes,
//                "sellPrices": item.sellPrices,
//                "sellVolumes": item.sellVolumes,
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
                "hkPriceDifferenceCategory": item.priceDiffType
                ]
            var jsonBuyPrices = [JSON]()
            for i in 0 ..< item.buyPrices.count{
                let jsonBuyPrice : JSON = [
                    "buyPrice\(i+1)": item.buyPrices[i]
                ]
                jsonBuyPrices.append(jsonBuyPrice)
            }
            resultJSON["buyPrices"].arrayObject = jsonBuyPrices
            
            var jsonBuyVolumes = [JSON]()
            for i in 0 ..< item.buyVolumes.count{
                let jsonBuyVolume : JSON = [
                    "buyVolume\(i+1)": item.buyVolumes[i]
                ]
                jsonBuyVolumes.append(jsonBuyVolume)
            }
            resultJSON["buyVolumes"].arrayObject = jsonBuyVolumes
            
            var jsonsellPrices = [JSON]()
            for i in 0 ..< item.sellPrices.count{
                let jsonsellPrice : JSON = [
                    "sellPrice\(i+1)": item.sellPrices[i]
                ]
                jsonsellPrices.append(jsonsellPrice)
            }
            resultJSON["sellPrices"].arrayObject = jsonsellPrices
            
            var jsonsellVolumes = [JSON]()
            for i in 0 ..< item.sellVolumes.count{
                let jsonsellVolume : JSON = [
                    "sellVolume\(i+1)": item.sellVolumes[i]
                ]
                jsonsellVolumes.append(jsonsellVolume)
            }
            resultJSON["sellVolumes"].arrayObject = jsonsellVolumes
    
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
