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

class OPTIONQUOTE_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OPTIONQUOTE_1
    }
   
    func testOption() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MOptionRequest()
        if param["STOCKID"].string!.contains("_"){
            let codeI:NSArray = (param["STOCKID"].string?.split(separator: "_") as! NSArray)
            mRequest.stockID = codeI[0] as! String
            let codeStr : String = codeI[1] as! String
            if codeStr == "CALL"{
                mRequest.optionType = MOptionType(rawValue: 1)!
            }else if codeStr == "PUT"{
                mRequest.optionType = MOptionType(rawValue: 2)!
            }
        }else{
            mRequest.stockID = param["STOCKID"].stringValue
            mRequest.optionType = MOptionType(rawValue: 0)!
        }
        mRequest.pageIndex = param["PAGEINDEX"].intValue

        
        let resp = self.makeSyncRequest(request: mRequest)
        let optionResponse = resp as! MOptionResponse
        XCTAssertNotNil(optionResponse.optionItems)
        
        var resultJSON : JSON = [:]
        for items in optionResponse.optionItems {
            let item : MOptionItem = items as! MOptionItem
//            print(item)
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
                "vega": item.vega,
                "realLeverage": item.leverage,
                "theoreticalPrice": item.theoreticalPrice,
                "buyPrices": item.buyPrices,
                "buyVolumes":item.buyVolumes,
                "sellPrices":item.sellPrices,
                "sellVolumes":item.sellVolumes,
                "buySingleVolumes":item.buyCount,
                "sellSingleVolumes":item.sellCount
            ]
            do {
                try itemJSON.merge(with: update1)
            } catch {
                // ignore
            }
            let update2: JSON = [
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
            ]
            do {
                try itemJSON.merge(with: update2)
            } catch {
                // ignore
            }
            let update3: JSON = [
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
            ]
            do {
                try itemJSON.merge(with: update3)
            } catch {
                // ignore
            }
            let update4: JSON = [
                "askvol1": item.sellVolume,
                "upf": item.unprofitableFlag.rawValue,
                "contractID": item.contractID,
                "objectID": item.stockID,
                "stockSymble": item.stockSymble,
                "stockType": item.stockType,
                "stockUnit": item.unit,
                "exePrice": item.exePrice,
                "startDate": item.startDate,
            ]
            do {
                try itemJSON.merge(with: update4)
            } catch {
                // ignore
            }
            let update5: JSON = [
                "vote":item.voteFlag.rawValue,
                "change2": item.change2,
                "earningsPerShare" :item.eps,
                "earningsPerShareReportingPeriod": item.epsType,
                "limitPriceUpperLimit": item.plSubscribeLimit,
                "limitPriceLowerLimit": item.plSubscribeLowerLimit,
                "bidpx1": item.buyPrice,
                "askpx1": item.sellPrice,
                "bidvol1": item.buyVolume,
            ]
            do {
                try itemJSON.merge(with: update5)
            } catch {
                // ignore
            }
            let update6: JSON = [
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
            ]
            do {
                try itemJSON.merge(with: update6)
            } catch {
                // ignore
            }
            let update7: JSON = [
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
            ]
            do {
                try itemJSON.merge(with: update7)
            } catch {
                // ignore
            }
            let update8: JSON = [
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
            ]
            do {
                try itemJSON.merge(with: update8)
            } catch {
                // ignore
            }
            var update9: JSON = [
                "lowPrice": item.lowPrice,
                "openPrice": item.openPrice,
                "preClosePrice": item.preClosePrice,
                "volume": item.volume,
                "nowVolume": item.nowVolume,
                "turnoverRate": item.turnoverRate,
                "optionType":item.optionType.rawValue,
                "limitUP": item.limitUp,
                "limitDown": item.limitDown,
            ]
            switch String(item.optionType.rawValue) {
            case "1":
                update9["optionType"] = "C"
            case "2":
                update9["optionType"] = "P"
            default:
                update9["optionType"] = "-"
            }
            do {
                try itemJSON.merge(with: update9)
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
//        print(resultJSONarr)
        
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

