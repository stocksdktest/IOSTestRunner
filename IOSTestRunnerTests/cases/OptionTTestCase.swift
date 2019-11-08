//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//期权T型报价行情
import XCTest
import os.log
import SwiftyJSON

class OptionTTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OptionTTestCase
    }
   
    func testOptionT() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MOptionTRequest()
        mRequest.stockID = param["STOCKID"].stringValue
        mRequest.expireMonth = param["EXPIREMONTH"].stringValue
        
        let resp = self.makeSyncRequest(request: mRequest)
        let optionResponse = resp as! MOptionResponse
        XCTAssertNotNil(optionResponse.optionItems)
        var resultJSON : JSON = [:]
        for item in optionResponse.optionItems {
            var itemJSON: JSON = [
                "status": "\(item.status.rawValue)" + "\(item.stage.rawValue)",
                "id": item.id,
                "name": item.name,
                "datetime": item.datetime,
                "market": item.market,
                "subtype": item.subtype,
                "lastPrice": item.lastPrice,
                "highPrice": item.highPrice,
                "lowPrice": item.lowPrice,
                "openPrice": item.openPrice,
                "preClosePrice": item.preClosePrice,
                "volume": item.volume,
                "nowVolume": item.nowVolume,
                "turnoverRate": item.turnoverRate,
                "optionType":item.optionType.rawValue,
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
                "totalValue": item.totalValue,
                "flowValue": item.flowValue,
                "netAsset": item.netAsset,
                "pe": item.pe,
                "pe2": item.spe,
                "pb": item.roe,
                "capitalization": item.capitalization,
                "circulatingShares": item.circulatingShare,
                
                "amplitudeRate": item.amplitudeRate,
                "receipts": item.receipts,
                
                "orderRatio": item.orderRatio,
                "hk_paramStatus": item.hkInfoStatus.rawValue,
                
                "sumBuy": item.totalBuyVolume,
                "sumSell": item.totalSellVolume,
                "averageBuy": item.averageBuyPrice,
                "averageSell": item.averageSellPrice,
                
                "buy_cancel_count": item.withdrawBuyCount,
                "buy_cancel_num": item.withdrawBuyVolume,
                "buy_cancel_amount": item.withdrawBuyAmount,
                "sell_cancel_count": item.withdrawSellCount,
                "sell_cancel_num": item.withdrawSellVolume,
                "sell_cancel_amount": item.withdrawSellAmount,
                "vote":item.voteFlag.rawValue,
                "change2": item.change2,
                "earningsPerShare" :item.eps,
                "earningsPerShareReportingPeriod": item.epsType,
                "limitPriceUpperLimit": item.plSubscribeLimit,
                "limitPriceLowerLimit": item.plSubscribeLowerLimit,
                "bidpx1": item.buyPrice,
                "askpx1": item.sellPrice,
                "bidvol1": item.buyVolume,
                "askvol1": item.sellVolume,
                "upf": item.unprofitableFlag.rawValue,
                "contractID": item.contractID,
                "objectID": item.stockID,
                "stockSymble": item.stockSymble,
                "stockType": item.stockType,
                "stockUnit": item.unit,
                "exePrice": item.exePrice,
                "startDate": item.startDate,
                "endDate": item.endDate,
                "exeDate": item.exeDate,
                "delDate": item.deliDate,
                "expDate": item.expDate,
                "version": item.version,
                "presetPrice": item.presetPrice,
                "stockClose": item.stockClose,
                "stockLast": item.stockLast,
                "isLimit": item.isLimit,
                "inValue": item.inValue,
                "timeValue": item.timeValue,
                "openInterest": item.openInterest,
                "remainDate": item.remainDate,
                "leverageRatio": item.leverageRatio,
                "premiumRate": item.premiumRate,
                "impliedVolatility": item.impliedVolatility,
                "delta": item.delta,
                "gramma": item.gamma,
                "theta": item.theta,
                "rho": item.rho,
                "vega": item.vega,
                "realLeverage": item.leverage,
                "theoreticalPrice": item.theoreticalPrice,
                "buyPrices": item.buyPrices,
                "buyVolumes":item.buyVolumes,
                "sellPrices":item.sellPrices,
                "sellVolumes":item.sellVolumes,
                ]
            
            
            switch item.changeState{
                
            case .flat:
                itemJSON["changeRate"].string = item.changeRate
            case .rise:
                itemJSON["changeRate"].string = "+"+item.changeRate
            case .drop:
                itemJSON["changeRate"].string = "-"+item.changeRate
            }
            resultJSON["\(item.datetime!)"] = itemJSON
        }
        
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

