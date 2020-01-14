//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//期权-标的行情
import XCTest
import os.log
import SwiftyJSON

class OPTIONLIST_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OPTIONLIST_1
    }
    
    func testUnderlyingStock() {
    let param = self.testCaseRoundConfig.getParam()
    let mRequest = MUnderlyingStockRequest()
    let resp = self.makeSyncRequest(request: mRequest)
    let underlyingStockResponse = resp as! MUnderlyingStockResponse
    XCTAssertNotNil(underlyingStockResponse.stockItems)
        var resultJSON : JSON = [:]
        for item in underlyingStockResponse.stockItems{
            var itemJSON: JSON = [
                "status": "\(item.status.rawValue)" + "\(item.stage.rawValue)",
                "id": item.id,
                "name": item.name,
                "datetime": item.datetime,
                "market": item.market,
                "subtype": item.subtype,
            ]
            let update1: JSON = [
                "limitPriceUpperLimit": item.plSubscribeLimit,
                "limitPriceLowerLimit": item.plSubscribeLowerLimit,
                "bidpx1": item.buyPrice,
                "askpx1": item.sellPrice,
                "bidvol1": item.buyVolume,
                "askvol1": item.sellVolume,
                "buyPrices": item.buyPrices,
                "buyVolumes":item.buyVolumes,
                "sellPrices":item.sellPrices,
                "sellVolumes":item.sellVolumes,
            ]
            do {
                try itemJSON.merge(with: update1)
            } catch {
                // ignore
            }
            let update2: JSON = [
                "sumSell": item.totalSellVolume,
                "averageBuy": item.averageBuyPrice,
                "averageSell": item.averageSellPrice,

                "buy_cancel_count": item.withdrawBuyCount,
                "buy_cancel_num": item.withdrawBuyVolume,
                "buy_cancel_amount": item.withdrawBuyAmount,
                "sell_cancel_count": item.withdrawSellCount,
                "sell_cancel_num": item.withdrawSellVolume,
                "sell_cancel_amount": item.withdrawSellAmount,

                "change2": item.change2,
            ]
            do {
                try itemJSON.merge(with: update2)
            } catch {
                // ignore
            }
            let update3: JSON = [
                "buyVolume": item.buyVolume,
                "sellVolume": item.sellVolume,
                "totalValue": item.totalValue,

                "capitalization": item.capitalization,
                "circulatingShares": item.circulatingShare,

                "amplitudeRate": item.amplitudeRate,
                "receipts": item.receipts,

                "orderRatio": item.orderRatio,
                "hk_paramStatus": item.hkInfoStatus.rawValue,

                "sumBuy": item.totalBuyVolume,
            ]
            do {
                try itemJSON.merge(with: update3)
            } catch {
                // ignore
            }
            let update4: JSON = [
                "nowVolume": item.nowVolume,
                "turnoverRate": item.turnoverRate,

                "limitUP": item.limitUp,
                "limitDown": item.limitDown,
                "averageValue": item.averagePrice,
                "change": item.change,
                "amount": item.amount,
                "volumeRatio": item.volumeRatio,
                "buyPrice": item.buyPrice,
                "sellPrice": item.sellPrice,
            ]
            do {
                try itemJSON.merge(with: update4)
            } catch {
                // ignore
            }
            let update5: JSON = [
                "lastPrice": item.lastPrice,
                "highPrice": item.highPrice,
                "lowPrice": item.lowPrice,
                "openPrice": item.openPrice,
                "preClosePrice": item.preClosePrice,
                "volume": item.volume,
            ]
            do {
                try itemJSON.merge(with: update5)
            } catch {
                // ignore
            }
            

            
            switch item.changeState{
                
            case .flat:
                resultJSON["changeRate"].string = item.changeRate
            case .rise:
                resultJSON["changeRate"].string = "+"+item.changeRate
            case .drop:
                resultJSON["changeRate"].string = "-"+item.changeRate
            }
            var itemID: String = item.id.replacingOccurrences(of: ".", with: "_")
            
            resultJSON["\(itemID)"] = itemJSON
            
        }
    print(resultJSON)
    onTestResult(param: param, result: resultJSON)
    }
}

