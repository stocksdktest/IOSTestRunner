//
//  IOSTestRunnerTests.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/24.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class QuoteTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.QuoteTestCase
    }
    
    func testQuote() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MQuoteRequest()
        mRequest.code = param["CODE"].stringValue
        var fieldsVal = [String]()
        if let stockFields = param["STOCKFIELDS"].array{
            for field in stockFields{
                fieldsVal.append(field.stringValue)
            }
            mRequest.stockFields = fieldsVal
        }
        if param["FIELDS"].array != nil{
            var fieldVal = [String]()
            if let fields = param["FIELDS"].array{
                for field in fields{
                    fieldVal.append(field.stringValue)
                }
            }
            mRequest.addValueFields = fieldVal
        }
//        mRequest.addValueFields = ["ddz", "largeSellCount", "mediumDiffer"]
        let resp = self.makeSyncRequest(request: mRequest)
        let quoteResponse = resp as! MQuoteResponse
        XCTAssertNotNil(quoteResponse.stockItems)
        for items in quoteResponse.stockItems {
            if items is MOptionItem{
                let item: MOptionItem = items as! MOptionItem
                
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
            }else if items is MFuturesItem{
                let item:MFuturesItem = items as! MFuturesItem
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



                    "exerciseWay": item.exeType,
                    "orderRatio": item.orderRatio,
                    "hk_paramStatus": item.hkInfoStatus.rawValue,
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
                    "totalAsk": item.entrustSellVolume
                    
                ]
                var jsonBuyPrices = [JSON]()
                for i in 0 ..< item.buyPrices.count{
                    let jsonBuyPrice : JSON = [
                        "buyPrice\(i+1)": item.buyPrices[i]
                    ]
                    jsonBuyPrices.append(jsonBuyPrice)
                }
                resultJSON["buyPrices"].arrayObject = jsonBuyPrices
                var jsonBuySingleVolumes = [JSON]()
                for i in 0 ..< item.buyCount.count{
                    let jsonBuySingleVolume : JSON = [
                        "buySingleVolume\(i+1)": item.buyCount[i]
                    ]
                    jsonBuySingleVolumes.append(jsonBuySingleVolume)
                }
                resultJSON["buySingleVolumes"].arrayObject = jsonBuySingleVolumes
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
                var jsonsellSingleVolumes = [JSON]()
                for i in 0 ..< item.sellCount.count{
                    let jsonsellSingleVolume : JSON = [
                        "sellSingleVolume\(i+1)": item.sellCount[i]
                    ]
                    jsonsellSingleVolumes.append(jsonsellSingleVolume)
                }
                resultJSON["sellSingleVolumes"].arrayObject = jsonsellSingleVolumes
                var jsonsellVolumes = [JSON]()
                for i in 0 ..< item.sellVolumes.count{
                    let jsonsellVolume : JSON = [
                        "sellVolume\(i+1)": item.sellVolumes[i]
                    ]
                    jsonsellVolumes.append(jsonsellVolume)
                }
                resultJSON["sellVolumes"].arrayObject = jsonsellVolumes
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
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }else if items is MStockItem{
                let item:MStockItem = items
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

                    "exerciseWay": item.exeType,
                    "orderRatio": item.orderRatio,
                    "hk_paramStatus": item.hkInfoStatus.rawValue,
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
                    "askvol1": item.sellVolume
                    
                ]
                var jsonBuyPrices = [JSON]()
                for i in 0 ..< item.buyPrices.count{
                    let jsonBuyPrice : JSON = [
                        "buyPrice\(i+1)": item.buyPrices[i]
                    ]
                    jsonBuyPrices.append(jsonBuyPrice)
                }
                resultJSON["buyPrices"].arrayObject = jsonBuyPrices
                var jsonBuySingleVolumes = [JSON]()
                for i in 0 ..< item.buyCount.count{
                    let jsonBuySingleVolume : JSON = [
                        "buySingleVolume\(i+1)": item.buyCount[i]
                    ]
                    jsonBuySingleVolumes.append(jsonBuySingleVolume)
                }
                resultJSON["buySingleVolumes"].arrayObject = jsonBuySingleVolumes
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
                var jsonsellSingleVolumes = [JSON]()
                for i in 0 ..< item.sellCount.count{
                    let jsonsellSingleVolume : JSON = [
                        "sellSingleVolume\(i+1)": item.sellCount[i]
                    ]
                    jsonsellSingleVolumes.append(jsonsellSingleVolume)
                }
                resultJSON["sellSingleVolumes"].arrayObject = jsonsellSingleVolumes
                var jsonsellVolumes = [JSON]()
                for i in 0 ..< item.sellVolumes.count{
                    let jsonsellVolume : JSON = [
                        "sellVolume\(i+1)": item.sellVolumes[i]
                    ]
                    jsonsellVolumes.append(jsonsellVolume)
                }
                resultJSON["sellVolumes"].arrayObject = jsonsellVolumes
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
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
    }
}
