//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//  期权-商品行情
import XCTest
import os.log
import SwiftyJSON

class OptionTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OptionTestCase
    }
   
    func testOption() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MOptionRequest()
        mRequest.stockID = param["CODE"].stringValue
        mRequest.pageIndex = param["PAGEINDEX"].intValue
        if let typeVal = MOptionType.init(rawValue:param["OPTIONTYPE"].uIntValue) {
            mRequest.optionType = typeVal
        }

        
        let resp = self.makeSyncRequest(request: mRequest)
        let optionResponse = resp as! MOptionResponse
        XCTAssertNotNil(optionResponse.optionItems)
        for item in optionResponse.optionItems {
            var resultJSON: JSON = [
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
                "vate":item.voteFlag,
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

