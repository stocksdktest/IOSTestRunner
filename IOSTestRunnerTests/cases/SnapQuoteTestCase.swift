//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class SnapQuoteTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.SnapQuoteTestCase
    }
    
    func testSnapQuote() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MSnapQuoteRequest()
        mRequest.code = param["CODE"].stringValue
        var fieldsVal = [String]()
        if let stockFields = param["STOCKFIELDS"].array{
            for field in stockFields{
                fieldsVal.append(field.stringValue)
            }
            mRequest.stockFields = fieldsVal
        }
        mRequest.tickCount = param["TICKCOUNT"].intValue
        if param["FIELDS"].array != nil{
            var fieldVal = [String]()
            if let fields = param["FIELDS"].array{
                for field in fields{
                    fieldVal.append(field.stringValue)
                }
            }
            mRequest.addValueFields = fieldVal
        }
        
//        mRequest.stockFields = ["-1"]
//        mRequest.addValueFields = []
        let resp = self.makeSyncRequest(request: mRequest)
        let snapQuoteResponse = resp as! MSnapQuoteResponse
        XCTAssertNotNil(snapQuoteResponse.stockItem)

        if snapQuoteResponse.stockItem is MOptionItem{
            let item: MOptionItem = snapQuoteResponse.stockItem as! MOptionItem
            
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
                "buyPrices": item.buyPrices,
                "buyVolumes":item.buyVolumes,
                "sellPrices":item.sellPrices,
                "sellVolumes":item.sellVolumes,
                "buySingleVolumes":item.buyCount,
                "sellSingleVolumes":item.sellCount,
                "blockChg":item.weightedChange,
                "averageChg":item.averageChange,
                "indexChg5":item.changeRate5,
                "indexChg10":item.changeRate10
            ]
            //            var jsonSubtypes = [JSON]()
            //            for i in 0 ..< item.subtypes.count{
            //                let jsonSubtype : JSON = [
            //                    "st\(i+1)": item.subtypes[i]
            //                ]
            //                jsonSubtypes.append(jsonSubtype)
            //            }
            //            resultJSON["st"].arrayObject = jsonSubtypes
            
            switch item.changeState{
                
            case .flat:
                resultJSON["changeRate"].string = item.changeRate
            case .rise:
                resultJSON["changeRate"].string = "+"+item.changeRate
            case .drop:
                resultJSON["changeRate"].string = "-"+item.changeRate
            }
            if let anyItems = item.tickItems{
                var jsonarray2 = [JSON]()
                for anyItem in anyItems{
                    if !(anyItem is MTickItem){
                        continue
                    }
                    
                    let tickitem:MTickItem = anyItem as! MTickItem
                    let jsonarray1: JSON = [
                        "type": tickitem.type.rawValue,
                        "time": tickitem.time,
                        "tradeVolume": tickitem.tradeVolume,
                        "tradePrice": tickitem.tradePrice
                    ]
                    jsonarray2.append(jsonarray1)
                }
                resultJSON["tradeTick"].arrayObject = jsonarray2
            }
            if item.orderQuantityBuyItems != nil{
                let orderQuantityBuyItems: NSArray = snapQuoteResponse.orderQuantityBuyItems! as NSArray
                var JSONarr = [JSON]()
                    for orderQuantityBuyItem in orderQuantityBuyItems{
                        let OQBItem:MOrderQuantityItem = orderQuantityBuyItem as! MOrderQuantityItem

                        var itemJSON: JSON = ["QUANTITY": OQBItem.volume]
                        JSONarr.append(itemJSON)
                    }
                resultJSON["buylist"].arrayObject = JSONarr
            }
            if item.orderQuantitySellItems != nil{
                let orderQuantitySellItems: NSArray = snapQuoteResponse.orderQuantitySellItems! as NSArray
                var JSONarr = [JSON]()
                    for orderQuantitySellItem in orderQuantitySellItems{
                        let OQSItem:MOrderQuantityItem = orderQuantitySellItem as! MOrderQuantityItem

                        var itemJSON: JSON = ["QUANTITY": OQSItem.volume]
                        JSONarr.append(itemJSON)
                    }
                resultJSON["selllist"].arrayObject = JSONarr
            }
            if item.brokerSeatBuyItems != nil{
                let brokerSeatBuyItems: NSArray = item.brokerSeatBuyItems! as NSArray
                var i = 1
                    for brokerSeatBuyItem in brokerSeatBuyItems{
                        let BSBItem:MBrokerSeatItem = brokerSeatBuyItem as! MBrokerSeatItem

                        var itemJSON: JSON = [
                            "corp": BSBItem.name,
                            "corporation": BSBItem.fullName,
                            "state": "1"
                        ]
                        resultJSON["1_\(i)"] = itemJSON
                        i = i + 1
                    }
                
            }
            if item.brokerSeatSellItems != nil{
                let brokerSeatSellItems: NSArray = item.brokerSeatSellItems! as NSArray
                var i = 1
                    for brokerSeatSellItem in brokerSeatSellItems{
                        let BSSItem:MBrokerSeatItem = brokerSeatSellItem as! MBrokerSeatItem

                        var itemJSON: JSON = [
                            "corp": BSSItem.name,
                            "corporation": BSSItem.fullName,
                            "state": "0"
                        ]
                        resultJSON["0_\(i)"] = itemJSON
                        i = i + 1
                    }
                
            }
            if item.addValueItem != nil{
                let addValueitem: MAddValueItem = item.addValueItem!
                var itemJSON: JSON = [
                    "code" : addValueitem.code,
                    "date" : addValueitem.date,
                    "time" : addValueitem.time,
                    "ultraLargeBuyVolume" : addValueitem.ultraLargeBuyVolume,
                    "ultraLargeSellVolume" : addValueitem.ultraLargeSellVolume,
                    "ultraLargeBuyAmount" : addValueitem.ultraLargeBuyAmount,
                    "ultraLargeSellAmount" : addValueitem.ultraLargeSellAmount,
                    "largeBuyVolume" : addValueitem.largeBuyVolume,
                    "largeSellVolume" : addValueitem.largeSellVolume,
                    "largeBuyAmount" : addValueitem.largeBuyAmount,
                    "largeSellAmount" : addValueitem.largeSellAmount,
                    "mediumBuyVolume" : addValueitem.mediumBuyVolume,
                    "mediumSellVolume" : addValueitem.mediumSellVolume,
                    "mediumBuyAmount" : addValueitem.mediumBuyAmount,
                    "mediumSellAmount" : addValueitem.mediumSellAmount,
                    "smallBuyVolume" : addValueitem.smallBuyVolume,
                    "smallSellVolume" : addValueitem.smallSellVolume,
                    "smallBuyAmount" : addValueitem.smallBuyAmount,
                    "smallSellAmount" : addValueitem.smallSellAmount,
                    "ultraLargeNetInflow" : addValueitem.ultraLargeNetInflow,
                    "largeNetInflow" : addValueitem.largeNetInflow,
                    "netCapitalInflow" : addValueitem.netCapitalInflow,
                    "mediumNetInflow" : addValueitem.mediumNetInflow,
                    "smallNetInflow" : addValueitem.smallNetInflow,
                    "fundsInflows" : addValueitem.fundsInflows,
                    "fundsOutflows" : addValueitem.fundsOutflows,
                    "ultraLargeDiffer" : addValueitem.ultraLargeDiffer,
                    "largeDiffer" : addValueitem.largeDiffer,
                    "mediumDiffer" : addValueitem.mediumDiffer,
                    "smallDiffer" : addValueitem.smallDiffer,
                    "largeBuyDealCount" : addValueitem.largeBuyDealCount,
                    "largeSellDealCount" : addValueitem.largeSellDealCount,
                    "dealCountMovingAverage" : addValueitem.dealCountMovingAverage,
                    "buyCount" : addValueitem.buyCount,
                    "sellCount" : addValueitem.sellCount,
                    "BBD" : addValueitem.bbd,
                    "BBD5" : addValueitem.bbd5,
                    "BBD10" : addValueitem.bbd10,
                    "DDX" : addValueitem.ddx,
                    "DDX5" : addValueitem.ddx5,
                    "DDX10" : addValueitem.ddx10,
                    "DDY" : addValueitem.ddy,
                    "DDY5" : addValueitem.ddy5,
                    "DDY10" : addValueitem.ddy10,
                    "DDZ" : addValueitem.ddz,
                    "RatioBS" : addValueitem.ratioBS,
                    "othersFundsInflows" : addValueitem.othersFundsInflows,
                    "othersFundsOutflows" : addValueitem.othersFundsOutflows,
                    "fiveMinutesChangeRate" : addValueitem.fiveMinRise,
                    "largeOrderNumB" : addValueitem.ultraLargeBuyCount,
                    "largeOrderNumS" : addValueitem.ultraLargeSellCount,
                    "bigOrderNumB" : addValueitem.largeBuyCount,
                    "bigOrderNumS" : addValueitem.largeSellCount,
                    "midOrderNumB" : addValueitem.mediumBuyCount,
                    "midOrderNumS" : addValueitem.mediumSellCount,
                    "smallOrderNumB" : addValueitem.smallBuyCount,
                    "smallOrderNumS" : addValueitem.smallSellCount,
                    "mainforceMoneyNetInflow5" : addValueitem.netInflow5,
                    "mainforceMoneyNetInflow10" : addValueitem.netInflow10,
                    "mainforceMoneyNetInflow20" : addValueitem.netInflow20,
                    "ratioMainforceMoneyNetInflow5" : addValueitem.netInflowRate5,
                    "ratioMainforceMoneyNetInflow10" : addValueitem.netInflowRate10,
                    "ratioMainforceMoneyNetInflow5" : addValueitem.netInflowRate20
                ]
                resultJSON["addValue"] = itemJSON
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }else if snapQuoteResponse.stockItem is MFuturesItem{
            let item:MFuturesItem = snapQuoteResponse.stockItem as! MFuturesItem
            
            var resultJSON: JSON = [
                "status": "\(item.status.rawValue)" + "\(item.stage.rawValue)",
                "id": item.id,
                "preInterest":item.preOpenInterest,
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
                "upDownLimitType": item.udFlag,
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
                "HKTotalValue": item.hkValue,
                "flowValue": item.flowValue,
                "netAsset": item.netAsset,
                "pe": item.pe,
                "pe2": item.spe,
                "pb": item.roe,
                "capitalization": item.capitalization,
                "circulatingShares": item.circulatingShare,
                "optionType":item.optionType.rawValue,
                "earningsPerShare" :item.eps,
                "earningsPerShareReportingPeriod": item.epsType,
                
                //
                //                "buyPrices": item.buyPrices,
                //                "buySingleVolumes": item.buyCount,
                //                "buyVolumes": item.buyVolumes,
                //                "sellPrices": item.sellPrices,
                //                "sellSingleVolumes": item.sellCount,
                //                "sellVolumes": item.sellVolumes,
                //
                "amplitudeRate": item.amplitudeRate,
                "receipts": item.receipts,
                "upCount": item.advanceCount,
                "sameCount": item.equalCount,
                "downCount": item.declineCount,
                "exerciseWay": item.exeType,
                "orderRatio": item.orderRatio,
                "hk_paramStatus": item.hkInfoStatus.rawValue,
                "fundType": item.subtype2,
                "sumBuy": item.totalBuyVolume,
                "sumSell": item.totalSellVolume,
                "averageBuy": item.averageBuyPrice,
                "averageSell": item.averageSellPrice,
                "zh": item.sFlag.rawValue,
                "hh": item.hFlag.rawValue,
                
                "st": item.subtypes,
                
                "bu": item.financeFlag.rawValue,
                "su": item.securityFlag.rawValue,
                "hs": item.hkCapital,
                "ac": item.authorisedCapital,
                "qf": item.investorRequirementsFlag.rawValue,
                "qc": item.investorRequirementsType.rawValue,
                "ah": item.ahFlag.rawValue,
                "VCMFlag": item.vcmFlag.rawValue,
                "CASFlag": item.casFlag.rawValue,
                "rp": item.termRepo,
                "cd": item.takeUpDays,
                "hg": item.hgFlag.rawValue,
                "sg": item.sgFlag.rawValue,
                "fx": item.fxFlag.rawValue,
                "ts": item.tsFlag.rawValue,
                "add_option_avg_price": item.weightedAveragePrice,
                "add_option_avg_pb": item.bp,
                "add_option_avg_close": item.weightedAveragePreClosePrice,
                "hk_volum_for_every_hand": item.hkMinTradeUnit,
                "buy_cancel_count": item.withdrawBuyCount,
                "buy_cancel_num": item.withdrawBuyVolume,
                "buy_cancel_amount": item.withdrawBuyAmount,
                "sell_cancel_count": item.withdrawSellCount,
                "sell_cancel_num": item.withdrawSellVolume,
                "sell_cancel_amount": item.withdrawSellAmount,
                "IOPV": item.iopv,
                "preIOPV": item.preIOPV,
                "stateOfTransfer": item.zrzt,
                "typeOfTransfer": item.zrlx,
                "exRighitDividend": item.cqcx,
                "securityLevel": item.zqjb,
                "rpd": item.fundAvailableDate,
                "cdd": item.fundReceiptedDate,
                "change2": item.change2,
                "hkTExchangeFlag": item.tradeType.rawValue,
                "vote": item.voteFlag.rawValue,
                "upf": item.unprofitableFlag.rawValue,
                "DRCurrentShare": item.drCurrentShare,
                "DRPreviousClosingShare": item.drPreviousClosingShare,
                "DRConversionBase": item.drConversionBase,
                "DRDepositoryInstitutionCode": item.drDepositoryInstitutionCode,
                "DRDepositoryInstitutionName": item.drDepositoryInstitutionName,
                "DRSubjectClosingReferencePrice": item.drSubjectClosingReferencePrice,
                "DR": item.dr,
                "GDR": item.gdr,
                "DRStockCode": item.drStockCode,
                "DRStockName": item.drStockName,
                "DRSecuritiesConversionBase": item.drSecuritiesConversionBase,
                "DRListingDate": item.drListingDate,
                "DRFlowStartDate": item.drFlowStartDate,
                "DRFlowEndDate": item.drFlowEndDate,
                "changeBP": item.changeBP,
                "subscribeUpperLimit": item.subscribeLimit,
                "subscribeLowerLimit": item.subscribeLowerLimit,
                "afterHoursVolume": item.afterHoursVolume,
                "afterHoursAmount": item.afterHoursAmount,
                "afterHoursTransactionNumber": item.afterHoursTransactionNumber,
                "afterHoursWithdrawBuyCount": item.afterHoursWithdrawBuyCount,
                "afterHoursWithdrawBuyVolume": item.afterHoursWithdrawBuyVolume,
                "afterHoursWithdrawSellCount": item.afterHoursWithdrawSellCount,
                "afterHoursWithdrawSellVolume": item.afterHoursWithdrawSellVolume,
                "afterHoursBuyVolume": item.afterHoursBuyVolume,
                "afterHoursSellVolume": item.afterHoursSellVolume,
                "issuedCapital": item.regCapital,
                "limitPriceUpperLimit": item.plSubscribeLimit,
                "limitPriceLowerLimit": item.plSubscribeLowerLimit,
                "longName": item.longName,
                "bidpx1": item.buyPrice,
                "askpx1": item.sellPrice,
                "bidvol1": item.buyVolume,
                "askvol1": item.sellVolume,
                //
                "tradingDay": item.tradingDay,
                "settlementID": item.settlementID,
                "settlementGroupID": item.settlementGroupID,
                "preSettlement": item.preSettlement,
                "position_chg": item.positionChg,
                "close": item.close,
                "settlement": item.settlement,
                "preDelta": item.preDelta,
                "currDelta": item.currDelta,
                "updateMillisec": item.updateMillisec,
                "entrustDiff": item.entrustDiff,
                "posDiff": item.posDiff,
                "currDiff": item.currDiff,
                "underlyingType": item.underlyingType,
                "underlyingLastPx": item.underlyingLastPx,
                "underlyingPreClose": item.underlyingPreClose,
                "underlyingchg": item.underlyingChange,
                "underlyingSymbol": item.underlyingSymbol,
                "deliveryDay": item.deliveryDay,
                "riskFreeInterestRate": item.riskFreeInterestRate,
                "intersectionNum": item.intersectionNum,
                "change1": item.change1,
                "totalBid": item.entrustBuyVolume,
                "totalAsk": item.entrustSellVolume,
                "buyPrices": item.buyPrices,
                "buyVolumes":item.buyVolumes,
                "sellPrices":item.sellPrices,
                "sellVolumes":item.sellVolumes,
                "buySingleVolumes":item.buyCount,
                "sellSingleVolumes":item.sellCount,
                "blockChg":item.weightedChange,
                "averageChg":item.averageChange,
                "indexChg5":item.changeRate5,
                "indexChg10":item.changeRate10
            ]
//            var jsonSubtypes = [JSON]()
//            for i in 0 ..< item.subtypes.count{
//                let jsonSubtype : JSON = [
//                    "st\(i+1)": item.subtypes[i]
//                ]
//                jsonSubtypes.append(jsonSubtype)
//            }
//            resultJSON["st"].arrayObject = jsonSubtypes
            
            switch item.changeState{
                
            case .flat:
                resultJSON["changeRate"].string = item.changeRate
            case .rise:
                resultJSON["changeRate"].string = "+"+item.changeRate
            case .drop:
                resultJSON["changeRate"].string = "-"+item.changeRate
            }
            if let anyItems = item.tickItems{
                var jsonarray2 = [JSON]()
                for anyItem in anyItems{
                    if !(anyItem is MTickItem){
                        continue
                    }
                    
                    let tickitem:MTickItem = anyItem as! MTickItem
                    let jsonarray1: JSON = [
                        "type": tickitem.type.rawValue,
                        "time": tickitem.time,
                        "tradeVolume": tickitem.tradeVolume,
                        "tradePrice": tickitem.tradePrice
                    ]
                    jsonarray2.append(jsonarray1)
                }
                resultJSON["tradeTick"].arrayObject = jsonarray2
            }
            if item.orderQuantityBuyItems != nil{
                let orderQuantityBuyItems: NSArray = snapQuoteResponse.orderQuantityBuyItems! as NSArray
                var JSONarr = [JSON]()
                    for orderQuantityBuyItem in orderQuantityBuyItems{
                        let OQBItem:MOrderQuantityItem = orderQuantityBuyItem as! MOrderQuantityItem

                        var itemJSON: JSON = ["QUANTITY": OQBItem.volume]
                        JSONarr.append(itemJSON)
                    }
                resultJSON["buylist"].arrayObject = JSONarr
            }
            if item.orderQuantitySellItems != nil{
                let orderQuantitySellItems: NSArray = snapQuoteResponse.orderQuantitySellItems! as NSArray
                var JSONarr = [JSON]()
                    for orderQuantitySellItem in orderQuantitySellItems{
                        let OQSItem:MOrderQuantityItem = orderQuantitySellItem as! MOrderQuantityItem

                        var itemJSON: JSON = ["QUANTITY": OQSItem.volume]
                        JSONarr.append(itemJSON)
                    }
                resultJSON["selllist"].arrayObject = JSONarr
            }
            if item.brokerSeatBuyItems != nil{
                let brokerSeatBuyItems: NSArray = item.brokerSeatBuyItems! as NSArray
                var i = 1
                    for brokerSeatBuyItem in brokerSeatBuyItems{
                        let BSBItem:MBrokerSeatItem = brokerSeatBuyItem as! MBrokerSeatItem

                        var itemJSON: JSON = [
                            "corp": BSBItem.name,
                            "corporation": BSBItem.fullName,
                            "state": "1"
                        ]
                        resultJSON["1_\(i)"] = itemJSON
                        i = i + 1
                    }
                
            }
            if item.brokerSeatSellItems != nil{
                let brokerSeatSellItems: NSArray = item.brokerSeatSellItems! as NSArray
                var i = 1
                    for brokerSeatSellItem in brokerSeatSellItems{
                        let BSSItem:MBrokerSeatItem = brokerSeatSellItem as! MBrokerSeatItem

                        var itemJSON: JSON = [
                            "corp": BSSItem.name,
                            "corporation": BSSItem.fullName,
                            "state": "0"
                        ]
                        resultJSON["0_\(i)"] = itemJSON
                        i = i + 1
                    }
            }
            if item.addValueItem != nil{
                let addValueitem: MAddValueItem = item.addValueItem!
                var itemJSON: JSON = [
                    "code" : addValueitem.code,
                    "date" : addValueitem.date,
                    "time" : addValueitem.time,
                    "ultraLargeBuyVolume" : addValueitem.ultraLargeBuyVolume,
                    "ultraLargeSellVolume" : addValueitem.ultraLargeSellVolume,
                    "ultraLargeBuyAmount" : addValueitem.ultraLargeBuyAmount,
                    "ultraLargeSellAmount" : addValueitem.ultraLargeSellAmount,
                    "largeBuyVolume" : addValueitem.largeBuyVolume,
                    "largeSellVolume" : addValueitem.largeSellVolume,
                    "largeBuyAmount" : addValueitem.largeBuyAmount,
                    "largeSellAmount" : addValueitem.largeSellAmount,
                    "mediumBuyVolume" : addValueitem.mediumBuyVolume,
                    "mediumSellVolume" : addValueitem.mediumSellVolume,
                    "mediumBuyAmount" : addValueitem.mediumBuyAmount,
                    "mediumSellAmount" : addValueitem.mediumSellAmount,
                    "smallBuyVolume" : addValueitem.smallBuyVolume,
                    "smallSellVolume" : addValueitem.smallSellVolume,
                    "smallBuyAmount" : addValueitem.smallBuyAmount,
                    "smallSellAmount" : addValueitem.smallSellAmount,
                    "ultraLargeNetInflow" : addValueitem.ultraLargeNetInflow,
                    "largeNetInflow" : addValueitem.largeNetInflow,
                    "netCapitalInflow" : addValueitem.netCapitalInflow,
                    "mediumNetInflow" : addValueitem.mediumNetInflow,
                    "smallNetInflow" : addValueitem.smallNetInflow,
                    "fundsInflows" : addValueitem.fundsInflows,
                    "fundsOutflows" : addValueitem.fundsOutflows,
                    "ultraLargeDiffer" : addValueitem.ultraLargeDiffer,
                    "largeDiffer" : addValueitem.largeDiffer,
                    "mediumDiffer" : addValueitem.mediumDiffer,
                    "smallDiffer" : addValueitem.smallDiffer,
                    "largeBuyDealCount" : addValueitem.largeBuyDealCount,
                    "largeSellDealCount" : addValueitem.largeSellDealCount,
                    "dealCountMovingAverage" : addValueitem.dealCountMovingAverage,
                    "buyCount" : addValueitem.buyCount,
                    "sellCount" : addValueitem.sellCount,
                    "BBD" : addValueitem.bbd,
                    "BBD5" : addValueitem.bbd5,
                    "BBD10" : addValueitem.bbd10,
                    "DDX" : addValueitem.ddx,
                    "DDX5" : addValueitem.ddx5,
                    "DDX10" : addValueitem.ddx10,
                    "DDY" : addValueitem.ddy,
                    "DDY5" : addValueitem.ddy5,
                    "DDY10" : addValueitem.ddy10,
                    "DDZ" : addValueitem.ddz,
                    "RatioBS" : addValueitem.ratioBS,
                    "othersFundsInflows" : addValueitem.othersFundsInflows,
                    "othersFundsOutflows" : addValueitem.othersFundsOutflows,
                    "fiveMinutesChangeRate" : addValueitem.fiveMinRise,
                    "largeOrderNumB" : addValueitem.ultraLargeBuyCount,
                    "largeOrderNumS" : addValueitem.ultraLargeSellCount,
                    "bigOrderNumB" : addValueitem.largeBuyCount,
                    "bigOrderNumS" : addValueitem.largeSellCount,
                    "midOrderNumB" : addValueitem.mediumBuyCount,
                    "midOrderNumS" : addValueitem.mediumSellCount,
                    "smallOrderNumB" : addValueitem.smallBuyCount,
                    "smallOrderNumS" : addValueitem.smallSellCount,
                    "mainforceMoneyNetInflow5" : addValueitem.netInflow5,
                    "mainforceMoneyNetInflow10" : addValueitem.netInflow10,
                    "mainforceMoneyNetInflow20" : addValueitem.netInflow20,
                    "ratioMainforceMoneyNetInflow5" : addValueitem.netInflowRate5,
                    "ratioMainforceMoneyNetInflow10" : addValueitem.netInflowRate10,
                    "ratioMainforceMoneyNetInflow5" : addValueitem.netInflowRate20
                ]
                resultJSON["addValue"] = itemJSON
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }else if snapQuoteResponse.stockItem is MStockItem{
            let item:MStockItem = snapQuoteResponse.stockItem
            
//            let orderQuantitySellItems: NSArray = snapQuoteResponse.orderQuantitySellItems! as NSArray
//            let buyBrokerSeatItems: NSArray = snapQuoteResponse.buyBrokerSeatItems! as NSArray
//            let sellBrokerSeatItems: NSArray = snapQuoteResponse.sellBrokerSeatItems! as NSArray
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
                            "upDownLimitType": item.udFlag,
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
                            "HKTotalValue": item.hkValue,
                            "flowValue": item.flowValue,
                            "netAsset": item.netAsset,
                            "pe": item.pe,
                            "pe2": item.spe,
                            "pb": item.roe,
                            "capitalization": item.capitalization,
                            "circulatingShares": item.circulatingShare,
                            "earningsPerShare" :item.eps,
                            "earningsPerShareReportingPeriod": item.epsType,
            //
            //                "buyPrices": item.buyPrices,
            //                "buySingleVolumes": item.buyCount,
            //                "buyVolumes": item.buyVolumes,
            //                "sellPrices": item.sellPrices,
            //                "sellSingleVolumes": item.sellCount,
            //                "sellVolumes": item.sellVolumes,
            //
                            "amplitudeRate": item.amplitudeRate,
                            "receipts": item.receipts,
                            "upCount": item.advanceCount,
                            "sameCount": item.equalCount,
                            "downCount": item.declineCount,
                            "exerciseWay": item.exeType,
                            "orderRatio": item.orderRatio,
                            "hk_paramStatus": item.hkInfoStatus.rawValue,
                            "fundType": item.subtype2,
                            "sumBuy": item.totalBuyVolume,
                            "sumSell": item.totalSellVolume,
                            "averageBuy": item.averageBuyPrice,
                            "averageSell": item.averageSellPrice,
                            "zh": item.sFlag.rawValue,
                            "hh": item.hFlag.rawValue,
            
                            "st": item.subtypes,
            
                            "bu": item.financeFlag.rawValue,
                            "su": item.securityFlag.rawValue,
                            "hs": item.hkCapital,
                            "ac": item.authorisedCapital,
                            "qf": item.investorRequirementsFlag.rawValue,
                            "qc": item.investorRequirementsType.rawValue,
                            "ah": item.ahFlag.rawValue,
                            "VCMFlag": item.vcmFlag.rawValue,
                            "CASFlag": item.casFlag.rawValue,
                            "rp": item.termRepo,
                            "cd": item.takeUpDays,
                            "hg": item.hgFlag.rawValue,
                            "sg": item.sgFlag.rawValue,
                            "fx": item.fxFlag.rawValue,
                            "ts": item.tsFlag.rawValue,
                            "add_option_avg_price": item.weightedAveragePrice,
                            "add_option_avg_pb": item.bp,
                            "add_option_avg_close": item.weightedAveragePreClosePrice,
                            "hk_volum_for_every_hand": item.hkMinTradeUnit,
                            "buy_cancel_count": item.withdrawBuyCount,
                            "buy_cancel_num": item.withdrawBuyVolume,
                            "buy_cancel_amount": item.withdrawBuyAmount,
                            "sell_cancel_count": item.withdrawSellCount,
                            "sell_cancel_num": item.withdrawSellVolume,
                            "sell_cancel_amount": item.withdrawSellAmount,
                            "IOPV": item.iopv,
                            "preIOPV": item.preIOPV,
                            "stateOfTransfer": item.zrzt,
                            "typeOfTransfer": item.zrlx,
                            "exRighitDividend": item.cqcx,
                            "securityLevel": item.zqjb,
                            "rpd": item.fundAvailableDate,
                            "cdd": item.fundReceiptedDate,
                            "change2": item.change2,
                            "hkTExchangeFlag": item.tradeType.rawValue,
                            "vote": item.voteFlag.rawValue,
                            "upf": item.unprofitableFlag.rawValue,
                            "DRCurrentShare": item.drCurrentShare,
                            "DRPreviousClosingShare": item.drPreviousClosingShare,
                            "DRConversionBase": item.drConversionBase,
                            "DRDepositoryInstitutionCode": item.drDepositoryInstitutionCode,
                            "DRDepositoryInstitutionName": item.drDepositoryInstitutionName,
                            "DRSubjectClosingReferencePrice": item.drSubjectClosingReferencePrice,
                            "DR": item.dr,
                            "GDR": item.gdr,
                            "DRStockCode": item.drStockCode,
                            "DRStockName": item.drStockName,
                            "DRSecuritiesConversionBase": item.drSecuritiesConversionBase,
                            "DRListingDate": item.drListingDate,
                            "DRFlowStartDate": item.drFlowStartDate,
                            "DRFlowEndDate": item.drFlowEndDate,
                            "changeBP": item.changeBP,
                            "subscribeUpperLimit": item.subscribeLimit,
                            "subscribeLowerLimit": item.subscribeLowerLimit,
                            "afterHoursVolume": item.afterHoursVolume,
                            "afterHoursAmount": item.afterHoursAmount,
                            "afterHoursTransactionNumber": item.afterHoursTransactionNumber,
                            "afterHoursWithdrawBuyCount": item.afterHoursWithdrawBuyCount,
                            "afterHoursWithdrawBuyVolume": item.afterHoursWithdrawBuyVolume,
                            "afterHoursWithdrawSellCount": item.afterHoursWithdrawSellCount,
                            "afterHoursWithdrawSellVolume": item.afterHoursWithdrawSellVolume,
                            "afterHoursBuyVolume": item.afterHoursBuyVolume,
                            "afterHoursSellVolume": item.afterHoursSellVolume,
                            "issuedCapital": item.regCapital,
                            "limitPriceUpperLimit": item.plSubscribeLimit,
                            "limitPriceLowerLimit": item.plSubscribeLowerLimit,
                            "longName": item.longName,
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
                            "blockChg":item.weightedChange,
                            "averageChg":item.averageChange,
                            "indexChg5":item.changeRate5,
                            "indexChg10":item.changeRate10
                        ]
//                        var jsonSubtypes = [JSON]()
//                        for i in 0 ..< item.subtypes.count{
//                            let jsonSubtype : JSON = [
//                                "st\(i+1)": item.subtypes[i]
//                            ]
//                            jsonSubtypes.append(jsonSubtype)
//                        }
//                        resultJSON["st"].arrayObject = jsonSubtypes
            
                        switch item.changeState{
            
                        case .flat:
                            resultJSON["changeRate"].string = item.changeRate
                        case .rise:
                            resultJSON["changeRate"].string = "+"+item.changeRate
                        case .drop:
                            resultJSON["changeRate"].string = "-"+item.changeRate
                        }
                        if let anyItems = item.tickItems{
                            var jsonarray2 = [JSON]()
                            for i in 0 ..< mRequest.tickCount{
                                let anyItem = anyItems[i]
                                if !(anyItem is MTickItem){
                                    continue
                                }
            
                                let tickitem:MTickItem = anyItem as! MTickItem
                                let jsonarray1: JSON = [
                                    "type": tickitem.type.rawValue,
                                    "time": tickitem.time,
                                    "tradeVolume": tickitem.tradeVolume,
                                    "tradePrice": tickitem.tradePrice
                                ]
                                jsonarray2.append(jsonarray1)
                            }
                            resultJSON["tradeTick"].arrayObject = jsonarray2
                        }
            if item.orderQuantityBuyItems != nil{
                let orderQuantityBuyItems: NSArray = item.orderQuantityBuyItems! as NSArray
                var JSONarr = [JSON]()
                    for orderQuantityBuyItem in orderQuantityBuyItems{
                        let OQBItem:MOrderQuantityItem = orderQuantityBuyItem as! MOrderQuantityItem

                        var itemJSON: JSON = ["QUANTITY": OQBItem.volume]
                        JSONarr.append(itemJSON)
                    }
                resultJSON["buylist"].arrayObject = JSONarr
            }
            if item.orderQuantitySellItems != nil{
                let orderQuantitySellItems: NSArray = item.orderQuantitySellItems! as NSArray
                var JSONarr = [JSON]()
                    for orderQuantitySellItem in orderQuantitySellItems{
                        let OQSItem:MOrderQuantityItem = orderQuantitySellItem as! MOrderQuantityItem

                        var itemJSON: JSON = ["QUANTITY": OQSItem.volume]
                        JSONarr.append(itemJSON)
                    }
                resultJSON["selllist"].arrayObject = JSONarr
            }
            if item.brokerSeatBuyItems != nil{
                let brokerSeatBuyItems: NSArray = item.brokerSeatBuyItems! as NSArray
                var i = 1
                    for brokerSeatBuyItem in brokerSeatBuyItems{
                        let BSBItem:MBrokerSeatItem = brokerSeatBuyItem as! MBrokerSeatItem

                        var itemJSON: JSON = [
                            "corp": BSBItem.name,
                            "corporation": BSBItem.fullName,
                            "state": "1"
                        ]
                        resultJSON["1_\(i)"] = itemJSON
                        i = i + 1
                    }
                
            }
            if item.brokerSeatSellItems != nil{
                let brokerSeatSellItems: NSArray = item.brokerSeatSellItems! as NSArray
                var i = 1
                    for brokerSeatSellItem in brokerSeatSellItems{
                        let BSSItem:MBrokerSeatItem = brokerSeatSellItem as! MBrokerSeatItem

                        var itemJSON: JSON = [
                            "corp": BSSItem.name,
                            "corporation": BSSItem.fullName,
                            "state": "0"
                        ]
                        resultJSON["0_\(i)"] = itemJSON
                        i = i + 1
                    }
                
            }
            if item.addValueItem != nil{
                let addValueitem: MAddValueItem = item.addValueItem!
                var itemJSON: JSON = [
                    "code" : addValueitem.code,
                    "date" : addValueitem.date,
                    "time" : addValueitem.time,
                    "ultraLargeBuyVolume" : addValueitem.ultraLargeBuyVolume,
                    "ultraLargeSellVolume" : addValueitem.ultraLargeSellVolume,
                    "ultraLargeBuyAmount" : addValueitem.ultraLargeBuyAmount,
                    "ultraLargeSellAmount" : addValueitem.ultraLargeSellAmount,
                    "largeBuyVolume" : addValueitem.largeBuyVolume,
                    "largeSellVolume" : addValueitem.largeSellVolume,
                    "largeBuyAmount" : addValueitem.largeBuyAmount,
                    "largeSellAmount" : addValueitem.largeSellAmount,
                    "mediumBuyVolume" : addValueitem.mediumBuyVolume,
                    "mediumSellVolume" : addValueitem.mediumSellVolume,
                    "mediumBuyAmount" : addValueitem.mediumBuyAmount,
                    "mediumSellAmount" : addValueitem.mediumSellAmount,
                    "smallBuyVolume" : addValueitem.smallBuyVolume,
                    "smallSellVolume" : addValueitem.smallSellVolume,
                    "smallBuyAmount" : addValueitem.smallBuyAmount,
                    "smallSellAmount" : addValueitem.smallSellAmount,
                    "ultraLargeNetInflow" : addValueitem.ultraLargeNetInflow,
                    "largeNetInflow" : addValueitem.largeNetInflow,
                    "netCapitalInflow" : addValueitem.netCapitalInflow,
                    "mediumNetInflow" : addValueitem.mediumNetInflow,
                    "smallNetInflow" : addValueitem.smallNetInflow,
                    "fundsInflows" : addValueitem.fundsInflows,
                    "fundsOutflows" : addValueitem.fundsOutflows,
                    "ultraLargeDiffer" : addValueitem.ultraLargeDiffer,
                    "largeDiffer" : addValueitem.largeDiffer,
                    "mediumDiffer" : addValueitem.mediumDiffer,
                    "smallDiffer" : addValueitem.smallDiffer,
                    "largeBuyDealCount" : addValueitem.largeBuyDealCount,
                    "largeSellDealCount" : addValueitem.largeSellDealCount,
                    "dealCountMovingAverage" : addValueitem.dealCountMovingAverage,
                    "buyCount" : addValueitem.buyCount,
                    "sellCount" : addValueitem.sellCount,
                    "BBD" : addValueitem.bbd,
                    "BBD5" : addValueitem.bbd5,
                    "BBD10" : addValueitem.bbd10,
                    "DDX" : addValueitem.ddx,
                    "DDX5" : addValueitem.ddx5,
                    "DDX10" : addValueitem.ddx10,
                    "DDY" : addValueitem.ddy,
                    "DDY5" : addValueitem.ddy5,
                    "DDY10" : addValueitem.ddy10,
                    "DDZ" : addValueitem.ddz,
                    "RatioBS" : addValueitem.ratioBS,
                    "othersFundsInflows" : addValueitem.othersFundsInflows,
                    "othersFundsOutflows" : addValueitem.othersFundsOutflows,
                    "fiveMinutesChangeRate" : addValueitem.fiveMinRise,
                    "largeOrderNumB" : addValueitem.ultraLargeBuyCount,
                    "largeOrderNumS" : addValueitem.ultraLargeSellCount,
                    "bigOrderNumB" : addValueitem.largeBuyCount,
                    "bigOrderNumS" : addValueitem.largeSellCount,
                    "midOrderNumB" : addValueitem.mediumBuyCount,
                    "midOrderNumS" : addValueitem.mediumSellCount,
                    "smallOrderNumB" : addValueitem.smallBuyCount,
                    "smallOrderNumS" : addValueitem.smallSellCount,
                    "mainforceMoneyNetInflow5" : addValueitem.netInflow5,
                    "mainforceMoneyNetInflow10" : addValueitem.netInflow10,
                    "mainforceMoneyNetInflow20" : addValueitem.netInflow20,
                    "ratioMainforceMoneyNetInflow5" : addValueitem.netInflowRate5,
                    "ratioMainforceMoneyNetInflow10" : addValueitem.netInflowRate10,
                    "ratioMainforceMoneyNetInflow5" : addValueitem.netInflowRate20
                ]
                resultJSON["addValue"] = itemJSON
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
    
}
