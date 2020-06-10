//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//版块类股票行情
import XCTest
import os.log
import SwiftyJSON

class CATEQUOTE_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.CATEQUOTE_1
    }
    
    func testCategoryQuoteList() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MCategoryQuoteListRequest()
        mRequest.categoryID = param["CATEGORYID"].stringValue
        mRequest.pageIndex = param["PAGEINDEX"].intValue
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let categoryQuoteListResponse = resp as! MCategoryQuoteListResponse
//        XCTAssertNotNil(categoryQuoteListResponse.categoryQuoteItems)
        if (categoryQuoteListResponse.categoryQuoteItems == nil){
            throw BaseTestError.assertFailedError(message: "categoryQuoteListResponse categoryQuoteItems is nil")
        }
        var resultJSON : JSON = [:]
        for item in categoryQuoteListResponse.categoryQuoteItems {
            var itemJSON: JSON = [
                "status": "\(item.status.rawValue)" + "\(item.stage.rawValue)",
                "id": item.id,
                "name": item.name,
                "datetime": item.datetime,
                "market": item.market,
                "subtype": item.subtype,
                "lastPrice": item.lastPrice,
                "highPrice": item.highPrice,
                ]
            let update1: JSON = [
                "bidpx1": item.buyPrice,
                "askpx1": item.sellPrice,
                "bidvol1": item.buyVolume,
                "askvol1": item.sellVolume,
                "buyPrices": item.buyPrices,
                "buyVolumes":item.buyVolumes,
                "sellPrices":item.sellPrices,
                "sellVolumes":item.sellVolumes,
                "buySingleVolumes":item.buyCount,
                "sellSingleVolumes":item.sellCount,
            ]
            do {
                try itemJSON.merge(with: update1)
            } catch {
                // ignore
            }
            let update2: JSON = [
                "averageSell": item.averageSellPrice,
                
                "buy_cancel_count": item.withdrawBuyCount,
                "buy_cancel_num": item.withdrawBuyVolume,
                "buy_cancel_amount": item.withdrawBuyAmount,
                "sell_cancel_count": item.withdrawSellCount,
                "sell_cancel_num": item.withdrawSellVolume,
                "sell_cancel_amount": item.withdrawSellAmount,
                
                "change2": item.change2,
                
                "limitPriceUpperLimit": item.plSubscribeLimit,
                "limitPriceLowerLimit": item.plSubscribeLowerLimit,
            ]
            do {
                try itemJSON.merge(with: update2)
            } catch {
                // ignore
            }
            let update3: JSON = [
                "totalValue": item.totalValue,
                
                "capitalization": item.capitalization,
                "circulatingShares": item.circulatingShare,
                
                "amplitudeRate": item.amplitudeRate,
                "receipts": item.receipts,
                
                "orderRatio": item.orderRatio,
                "hk_paramStatus": String(item.hkInfoStatus.rawValue),
                
                "sumBuy": item.totalBuyVolume,
                "sumSell": item.totalSellVolume,
                "averageBuy": item.averageBuyPrice,
            ]
            do {
                try itemJSON.merge(with: update3)
            } catch {
                // ignore
            }
            let update4: JSON = [
                "limitUP": item.limitUp,
                "limitDown": item.limitDown,
                "averageValue": item.averagePrice,
                "change": item.change,
                "amount": item.amount,
                "volumeRatio": item.volumeRatio,
                "buyPrice": item.buyPrice,
                "sellPrice": item.sellPrice,
                "buyVolume": item.buyVolume,
                "sellVolume": item.sellVolume,
            ]
            do {
                try itemJSON.merge(with: update4)
            } catch {
                // ignore
            }
            let update5: JSON = [
                "lowPrice": item.lowPrice,
                "openPrice": item.openPrice,
                "preClosePrice": item.preClosePrice,
                "volume": item.volume,
                "nowVolume": item.nowVolume,
                "turnoverRate": item.turnoverRate,
            ]
            do {
                try itemJSON.merge(with: update5)
            } catch {
                // ignore
            }
            var itemJSON2 : JSON = [:]
            var itemDic : Dictionary = [String:String]()
                                        for itemKey in itemJSON.dictionaryValue.keys{
                                            
                                            itemDic[itemKey] = itemJSON[itemKey].stringValue
                                            if itemDic[itemKey] != ""{
                                                itemJSON2[itemKey].stringValue = itemDic[itemKey]!
                                            }else{
                                                itemJSON2[itemKey].stringValue = "-"
                                            }
                                            
                                        }
            
            switch item.changeState{
                
            case .flat:
                itemJSON2["changeRate"].string = item.changeRate
            case .rise:
                itemJSON2["changeRate"].string = "+"+item.changeRate
            case .drop:
                itemJSON2["changeRate"].string = "-"+item.changeRate
            }
            var itemID: String = item.id.replacingOccurrences(of: ".", with: "_")
            
            resultJSON["\(itemID)"] = itemJSON2
            
        }
        
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
        
    }
}

