//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//分类排行_2
//beginIndex、endIndex 按指定条目范围返回结果 (新三板 不支持)
import XCTest
import os.log
import SwiftyJSON

class CATESORTING_3: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.CATESORTING_3
    }
    
    func testCategorySorting() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MCategorySortingRequest()
        mRequest.code = param["CateType"].stringValue
        
        let paramI:NSArray = (param["param"].string?.split(separator: ",") as! NSArray)
        mRequest.endIndex = Int(paramI[1] as! String)!
        mRequest.beginIndex = Int(paramI[0] as! String)!
        if paramI[3] as! String == "0"{
            mRequest.ascending = ("1" as NSString).boolValue
        }else if paramI[3] as! String == "1"{
            mRequest.ascending = ("0" as NSString).boolValue
        }
        mRequest.field = MCategorySortingField.init(rawValue: Int(paramI[2] as! String)!)!
        mRequest.includeSuspension = (paramI[4] as! NSString).boolValue
        print(mRequest.endIndex,paramI[1])
        if param["STOCKFIELDS"].stringValue == "NULL" || param["STOCKFIELDS"].stringValue == "-1"{
            mRequest.stockFields = nil
        }else{
            if let fields = param["STOCKFIELDS"].array{
            var fieldVal = [String]()
            for field in fields{
                fieldVal.append(field.stringValue)
                }
            mRequest.stockFields = fieldVal
            }
        }
        
        if let fields = param["ADDVALUEFIELDS"].array{
            var fieldVal = [String]()
            for field in fields{
                fieldVal.append(field.stringValue)
                }
            mRequest.addValueFields = fieldVal
            }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let categorySortingResponse = resp as! MCategorySortingResponse
        XCTAssertNotNil(categorySortingResponse.stockItems)
        var resultJSON : JSON = [:]
        var i = 1
        for items in categorySortingResponse.stockItems {
            if items is MOptionItem{
                            let item: MOptionItem = items as! MOptionItem
                            
                            var itemJSON: JSON = [
                                "status": "\(item.status.rawValue)" + "\(item.stage.rawValue)",
                                "id": item.id,
                                "name": item.name,
                                "datetime": item.datetime,
                                "market": item.market,
                                "subtype": item.subtype,
                                ]
                            let update1: JSON = [
                                "realLeverage": item.leverage,
                                "theoreticalPrice": item.theoreticalPrice,
                                "buyPrices": item.buyPrices,
                                "buyVolumes":item.buyVolumes,
                                "sellPrices":item.sellPrices,
                                "sellVolumes":item.sellVolumes,
                                "blockChg":item.weightedChange,
                                "averageChg":item.averageChange,
                                "indexChg5":item.changeRate5,
                                "indexChg10":item.changeRate10
                            ]
                            do {
                                try itemJSON.merge(with: update1)
                            } catch {
                                // ignore
                            }
                            let update2: JSON = [
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
                            ]
                            do {
                                try itemJSON.merge(with: update2)
                            } catch {
                                // ignore
                            }
                            let update3: JSON = [
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
                                "endDate": item.endDate,
                            ]
                            do {
                                try itemJSON.merge(with: update4)
                            } catch {
                                // ignore
                            }
                            let update5: JSON = [
                                "sell_cancel_amount": item.withdrawSellAmount,
                                "vote":item.voteFlag,
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
                            ]
                            do {
                                try itemJSON.merge(with: update6)
                            } catch {
                                // ignore
                            }
                            let update7: JSON = [
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
                            ]
                            do {
                                try itemJSON.merge(with: update7)
                            } catch {
                                // ignore
                            }
                            let update8: JSON = [
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
                            ]
                            do {
                                try itemJSON.merge(with: update8)
                            } catch {
                                // ignore
                            }
                            let update9: JSON = [
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
                            ]
                            do {
                                try itemJSON.merge(with: update9)
                            } catch {
                                // ignore
                            }
                            
                            switch item.changeState{
                                
                            case .flat:
                                itemJSON["changeRate"].string = item.changeRate
                            case .rise:
                                itemJSON["changeRate"].string = "+"+item.changeRate
                            case .drop:
                                itemJSON["changeRate"].string = "-"+item.changeRate
                            }
                            
                            if item.addValueItem != nil{
                                let addValueitem: MAddValueItem = item.addValueItem!
                                var itemJSON1: JSON = [
                                    "code" : addValueitem.code,
                                    "date" : addValueitem.date,
                                    "time" : addValueitem.time,
                                    "ultraLargeBuyVolume" : addValueitem.ultraLargeBuyVolume,
                                    "ultraLargeSellVolume" : addValueitem.ultraLargeSellVolume,
                                    "ultraLargeBuyAmount" : addValueitem.ultraLargeBuyAmount,
                                    "ultraLargeSellAmount" : addValueitem.ultraLargeSellAmount,
                                    "largeBuyVolume" : addValueitem.largeBuyVolume,
                                    "largeSellVolume" : addValueitem.largeSellVolume,
                                ]
                                let update10: JSON = [
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
                                do {
                                    try itemJSON1.merge(with: update10)
                                } catch {
                                    // ignore
                                }
                                let update11: JSON = [
                                    "RatioBS" : addValueitem.ratioBS,
                                    "othersFundsInflows" : addValueitem.othersFundsInflows,
                                    "othersFundsOutflows" : addValueitem.othersFundsOutflows,
                                    "fiveMinutesChangeRate" : addValueitem.fiveMinRise,
                                    "largeOrderNumB" : addValueitem.ultraLargeBuyCount,
                                    "largeOrderNumS" : addValueitem.ultraLargeSellCount,
                                    "bigOrderNumB" : addValueitem.largeBuyCount,
                                    "bigOrderNumS" : addValueitem.largeSellCount,
                                    "midOrderNumB" : addValueitem.mediumBuyCount,
                                ]
                                do {
                                    try itemJSON1.merge(with: update11)
                                } catch {
                                    // ignore
                                }
                                let update12: JSON = [
                                    "BBD5" : addValueitem.bbd5,
                                    "BBD10" : addValueitem.bbd10,
                                    "DDX" : addValueitem.ddx,
                                    "DDX5" : addValueitem.ddx5,
                                    "DDX10" : addValueitem.ddx10,
                                    "DDY" : addValueitem.ddy,
                                    "DDY5" : addValueitem.ddy5,
                                    "DDY10" : addValueitem.ddy10,
                                    "DDZ" : addValueitem.ddz,
                                ]
                                do {
                                    try itemJSON1.merge(with: update12)
                                } catch {
                                    // ignore
                                }
                                let update13: JSON = [
                                    "largeDiffer" : addValueitem.largeDiffer,
                                    "mediumDiffer" : addValueitem.mediumDiffer,
                                    "smallDiffer" : addValueitem.smallDiffer,
                                    "largeBuyDealCount" : addValueitem.largeBuyDealCount,
                                    "largeSellDealCount" : addValueitem.largeSellDealCount,
                                    "dealCountMovingAverage" : addValueitem.dealCountMovingAverage,
                                    "buyCount" : addValueitem.buyCount,
                                    "sellCount" : addValueitem.sellCount,
                                    "BBD" : addValueitem.bbd,
                                ]
                                do {
                                    try itemJSON1.merge(with: update13)
                                } catch {
                                    // ignore
                                }
                                let update14: JSON = [
                                    "smallSellAmount" : addValueitem.smallSellAmount,
                                    "ultraLargeNetInflow" : addValueitem.ultraLargeNetInflow,
                                    "largeNetInflow" : addValueitem.largeNetInflow,
                                    "netCapitalInflow" : addValueitem.netCapitalInflow,
                                    "mediumNetInflow" : addValueitem.mediumNetInflow,
                                    "smallNetInflow" : addValueitem.smallNetInflow,
                                    "fundsInflows" : addValueitem.fundsInflows,
                                    "fundsOutflows" : addValueitem.fundsOutflows,
                                    "ultraLargeDiffer" : addValueitem.ultraLargeDiffer,
                                ]
                                do {
                                    try itemJSON1.merge(with: update14)
                                } catch {
                                    // ignore
                                }
                                let update15: JSON = [
                                    "largeBuyAmount" : addValueitem.largeBuyAmount,
                                    "largeSellAmount" : addValueitem.largeSellAmount,
                                    "mediumBuyVolume" : addValueitem.mediumBuyVolume,
                                    "mediumSellVolume" : addValueitem.mediumSellVolume,
                                    "mediumBuyAmount" : addValueitem.mediumBuyAmount,
                                    "mediumSellAmount" : addValueitem.mediumSellAmount,
                                    "smallBuyVolume" : addValueitem.smallBuyVolume,
                                    "smallSellVolume" : addValueitem.smallSellVolume,
                                    "smallBuyAmount" : addValueitem.smallBuyAmount,
                                ]
                                do {
                                    try itemJSON1.merge(with: update15)
                                } catch {
                                    // ignore
                                }
                                
                                itemJSON["addValue"] = itemJSON1
                            }
                            resultJSON["\(i)"] = itemJSON
                            i = i+1
                        }else if items is MFuturesItem{
                            let item:MFuturesItem = items as! MFuturesItem
                            var itemJSON: JSON = [
                                "status": "\(item.status.rawValue)" + "\(item.stage.rawValue)",
                                "id": item.id,
                                "preInterest":item.preOpenInterest,
                                "name": item.name,
                                "datetime": item.datetime,
                                "market": item.market,
                                "subtype": item.subtype,
                            ]
                            let update16: JSON = [
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
                            do {
                                try itemJSON.merge(with: update16)
                            } catch {
                                // ignore
                            }
                            let update17: JSON = [
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
                            ]
                            do {
                                try itemJSON.merge(with: update17)
                            } catch {
                                // ignore
                            }
                            let update18: JSON = [
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
                            ]
                            do {
                                try itemJSON.merge(with: update18)
                            } catch {
                                // ignore
                            }
                            let update19: JSON = [
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
                            ]
                            do {
                                try itemJSON.merge(with: update19)
                            } catch {
                                // ignore
                            }
                            let update20: JSON = [
                                "afterHoursTransactionNumber": item.afterHoursTransactionNumber,
                                "afterHoursWithdrawBuyCount": item.afterHoursWithdrawBuyCount,
                                "afterHoursWithdrawBuyVolume": item.afterHoursWithdrawBuyVolume,
                                "afterHoursWithdrawSellCount": item.afterHoursWithdrawSellCount,
                                "afterHoursWithdrawSellVolume": item.afterHoursWithdrawSellVolume,
                                "afterHoursBuyVolume": item.afterHoursBuyVolume,
                                "afterHoursSellVolume": item.afterHoursSellVolume,
                                "issuedCapital": item.regCapital,
                                "limitPriceUpperLimit": item.plSubscribeLimit,
                            ]
                            do {
                                try itemJSON.merge(with: update20)
                            } catch {
                                // ignore
                            }
                            let update21: JSON = [
                                "DRStockName": item.drStockName,
                                "DRSecuritiesConversionBase": item.drSecuritiesConversionBase,
                                "DRListingDate": item.drListingDate,
                                "DRFlowStartDate": item.drFlowStartDate,
                                "DRFlowEndDate": item.drFlowEndDate,
                                "subscribeUpperLimit": item.subscribeLimit,
                                "subscribeLowerLimit": item.subscribeLowerLimit,
                                "afterHoursVolume": item.afterHoursVolume,
                                "afterHoursAmount": item.afterHoursAmount,
                            ]
                            do {
                                try itemJSON.merge(with: update21)
                            } catch {
                                // ignore
                            }
                            let update22: JSON = [
                                "DRCurrentShare": item.drCurrentShare,
                                "DRPreviousClosingShare": item.drPreviousClosingShare,
                                "DRConversionBase": item.drConversionBase,
                                "DRDepositoryInstitutionCode": item.drDepositoryInstitutionCode,
                                "DRDepositoryInstitutionName": item.drDepositoryInstitutionName,
                                "DRSubjectClosingReferencePrice": item.drSubjectClosingReferencePrice,
                                "DR": item.dr,
                                "GDR": item.gdr,
                                "DRStockCode": item.drStockCode,
                            ]
                            do {
                                try itemJSON.merge(with: update22)
                            } catch {
                                // ignore
                            }
                            let update23: JSON = [
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
                            ]
                            do {
                                try itemJSON.merge(with: update23)
                            } catch {
                                // ignore
                            }
                            let update24: JSON = [
                                "ts": item.tsFlag.rawValue,
                                "buy_cancel_count": item.withdrawBuyCount,
                                "buy_cancel_num": item.withdrawBuyVolume,
                                "buy_cancel_amount": item.withdrawBuyAmount,
                                "sell_cancel_count": item.withdrawSellCount,
                                "sell_cancel_num": item.withdrawSellVolume,
                                "sell_cancel_amount": item.withdrawSellAmount,
                                "IOPV": item.iopv,
                                "preIOPV": item.preIOPV,
                            ]
                            do {
                                try itemJSON.merge(with: update24)
                            } catch {
                                // ignore
                            }
                            let update25: JSON = [
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
                            ]
                            do {
                                try itemJSON.merge(with: update25)
                            } catch {
                                // ignore
                            }
                            let update26: JSON = [
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
                            ]
                            do {
                                try itemJSON.merge(with: update26)
                            } catch {
                                // ignore
                            }
                            let update27: JSON = [
                                "capitalization": item.capitalization,
                                "circulatingShares": item.circulatingShare,
                                "optionType":item.optionType.rawValue,
                                "earningsPerShare" :item.eps,
                                "earningsPerShareReportingPeriod": item.epsType,
                                
                                "amplitudeRate": item.amplitudeRate,
                                "receipts": item.receipts,
                                
                                "exerciseWay": item.exeType,
                                "orderRatio": item.orderRatio,
                            ]
                            do {
                                try itemJSON.merge(with: update27)
                            } catch {
                                // ignore
                            }
                            let update28: JSON = [
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
                            ]
                            do {
                                try itemJSON.merge(with: update28)
                            } catch {
                                // ignore
                            }
                            let update29: JSON = [
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
                            ]
                            do {
                                try itemJSON.merge(with: update29)
                            } catch {
                                // ignore
                            }
                            let update30: JSON = [
                                "lastPrice": item.lastPrice,
                                "highPrice": item.highPrice,
                                "lowPrice": item.lowPrice,
                                "openPrice": item.openPrice,
                                "preClosePrice": item.preClosePrice,
                            ]
                            do {
                                try itemJSON.merge(with: update30)
                            } catch {
                                // ignore
                            }
                            
                            switch item.changeState{
                                
                            case .flat:
                                itemJSON["changeRate"].string = item.changeRate
                            case .rise:
                                itemJSON["changeRate"].string = "+"+item.changeRate
                            case .drop:
                                itemJSON["changeRate"].string = "-"+item.changeRate
                            }
                            
                            if item.addValueItem != nil{
                                let addValueitem: MAddValueItem = item.addValueItem!
                                var itemJSON1: JSON = [
                                    "code" : addValueitem.code,
                                    "date" : addValueitem.date,
                                    "time" : addValueitem.time,
                                    "ultraLargeBuyVolume" : addValueitem.ultraLargeBuyVolume,
                                    "ultraLargeSellVolume" : addValueitem.ultraLargeSellVolume,
                                    "ultraLargeBuyAmount" : addValueitem.ultraLargeBuyAmount,
                                    "ultraLargeSellAmount" : addValueitem.ultraLargeSellAmount,
                                    "largeBuyVolume" : addValueitem.largeBuyVolume,
                                    "largeSellVolume" : addValueitem.largeSellVolume,
                                ]
                                let update31: JSON = [
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
                                do {
                                    try itemJSON1.merge(with: update31)
                                } catch {
                                    // ignore
                                }
                                let update32: JSON = [
                                    "RatioBS" : addValueitem.ratioBS,
                                    "othersFundsInflows" : addValueitem.othersFundsInflows,
                                    "othersFundsOutflows" : addValueitem.othersFundsOutflows,
                                    "fiveMinutesChangeRate" : addValueitem.fiveMinRise,
                                    "largeOrderNumB" : addValueitem.ultraLargeBuyCount,
                                    "largeOrderNumS" : addValueitem.ultraLargeSellCount,
                                    "bigOrderNumB" : addValueitem.largeBuyCount,
                                    "bigOrderNumS" : addValueitem.largeSellCount,
                                    "midOrderNumB" : addValueitem.mediumBuyCount,
                                ]
                                do {
                                    try itemJSON1.merge(with: update32)
                                } catch {
                                    // ignore
                                }
                                let update33: JSON = [
                                    "BBD5" : addValueitem.bbd5,
                                    "BBD10" : addValueitem.bbd10,
                                    "DDX" : addValueitem.ddx,
                                    "DDX5" : addValueitem.ddx5,
                                    "DDX10" : addValueitem.ddx10,
                                    "DDY" : addValueitem.ddy,
                                    "DDY5" : addValueitem.ddy5,
                                    "DDY10" : addValueitem.ddy10,
                                    "DDZ" : addValueitem.ddz,
                                ]
                                do {
                                    try itemJSON1.merge(with: update33)
                                } catch {
                                    // ignore
                                }
                                let update34: JSON = [
                                    "largeDiffer" : addValueitem.largeDiffer,
                                    "mediumDiffer" : addValueitem.mediumDiffer,
                                    "smallDiffer" : addValueitem.smallDiffer,
                                    "largeBuyDealCount" : addValueitem.largeBuyDealCount,
                                    "largeSellDealCount" : addValueitem.largeSellDealCount,
                                    "dealCountMovingAverage" : addValueitem.dealCountMovingAverage,
                                    "buyCount" : addValueitem.buyCount,
                                    "sellCount" : addValueitem.sellCount,
                                    "BBD" : addValueitem.bbd,
                                ]
                                do {
                                    try itemJSON1.merge(with: update34)
                                } catch {
                                    // ignore
                                }
                                let update35: JSON = [
                                    "smallSellAmount" : addValueitem.smallSellAmount,
                                    "ultraLargeNetInflow" : addValueitem.ultraLargeNetInflow,
                                    "largeNetInflow" : addValueitem.largeNetInflow,
                                    "netCapitalInflow" : addValueitem.netCapitalInflow,
                                    "mediumNetInflow" : addValueitem.mediumNetInflow,
                                    "smallNetInflow" : addValueitem.smallNetInflow,
                                    "fundsInflows" : addValueitem.fundsInflows,
                                    "fundsOutflows" : addValueitem.fundsOutflows,
                                    "ultraLargeDiffer" : addValueitem.ultraLargeDiffer,
                                ]
                                do {
                                    try itemJSON1.merge(with: update35)
                                } catch {
                                    // ignore
                                }
                                let update36: JSON = [
                                    "largeBuyAmount" : addValueitem.largeBuyAmount,
                                    "largeSellAmount" : addValueitem.largeSellAmount,
                                    "mediumBuyVolume" : addValueitem.mediumBuyVolume,
                                    "mediumSellVolume" : addValueitem.mediumSellVolume,
                                    "mediumBuyAmount" : addValueitem.mediumBuyAmount,
                                    "mediumSellAmount" : addValueitem.mediumSellAmount,
                                    "smallBuyVolume" : addValueitem.smallBuyVolume,
                                    "smallSellVolume" : addValueitem.smallSellVolume,
                                    "smallBuyAmount" : addValueitem.smallBuyAmount,
                                ]
                                do {
                                    try itemJSON1.merge(with: update36)
                                } catch {
                                    // ignore
                                }
                                itemJSON["addValue"] = itemJSON1
                                }
                            resultJSON["\(i)"] = itemJSON
                            i = i+1
                        }else if items is MStockItem{
                            let item:MStockItem = items
                            var itemJSON: JSON = [
                                "status": "\(item.status.rawValue)" + "\(item.stage.rawValue)",
                                "id": item.id,
                                "name": item.name,
                                "datetime": item.datetime,
                                "market": item.market,
                                "subtype": item.subtype,
                                "lastPrice": item.lastPrice,
                            ]
                            let update37: JSON = [
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
                            do {
                                try itemJSON.merge(with: update37)
                            } catch {
                                // ignore
                            }
                            let update38: JSON = [
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
                            ]
                            do {
                                try itemJSON.merge(with: update38)
                            } catch {
                                // ignore
                            }
                            let update39: JSON = [
                                "DRFlowEndDate": item.drFlowEndDate,
                                "subscribeUpperLimit": item.subscribeLimit,
                                "subscribeLowerLimit": item.subscribeLowerLimit,
                                "afterHoursVolume": item.afterHoursVolume,
                                "afterHoursAmount": item.afterHoursAmount,
                                "afterHoursTransactionNumber": item.afterHoursTransactionNumber,
                                "afterHoursWithdrawBuyCount": item.afterHoursWithdrawBuyCount,
                                "afterHoursWithdrawBuyVolume": item.afterHoursWithdrawBuyVolume,
                                "afterHoursWithdrawSellCount": item.afterHoursWithdrawSellCount,
                                "afterHoursWithdrawSellVolume": item.afterHoursWithdrawSellVolume,
                            ]
                            do {
                                try itemJSON.merge(with: update39)
                            } catch {
                                // ignore
                            }
                            let update40: JSON = [
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
                            ]
                            do {
                                try itemJSON.merge(with: update40)
                            } catch {
                                // ignore
                            }
                            let update41: JSON = [
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
                            ]
                            do {
                                try itemJSON.merge(with: update41)
                            } catch {
                                // ignore
                            }
                            let update42: JSON = [
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
                            ]
                            do {
                                try itemJSON.merge(with: update42)
                            } catch {
                                // ignore
                            }
                            let update43: JSON = [
                                "ah": item.ahFlag.rawValue,
                                "VCMFlag": item.vcmFlag.rawValue,
                                "CASFlag": item.casFlag.rawValue,
                                "rp": item.termRepo,
                                "cd": item.takeUpDays,
                                "hg": item.hgFlag.rawValue,
                                "sg": item.sgFlag.rawValue,
                                "fx": item.fxFlag.rawValue,
                                "ts": item.tsFlag.rawValue,
                                "buy_cancel_count": item.withdrawBuyCount,
                            ]
                            do {
                                try itemJSON.merge(with: update43)
                            } catch {
                                // ignore
                            }
                            let update44: JSON = [
                                "sumSell": item.totalSellVolume,
                                "averageBuy": item.averageBuyPrice,
                                "averageSell": item.averageSellPrice,
                                "zh": item.sFlag.rawValue,
                                "hh": item.hFlag.rawValue,
                                
                                "st": item.subtypes,
                                
                                "bu": item.financeFlag.rawValue,
                                "su": item.securityFlag.rawValue,
                                "qf": item.investorRequirementsFlag.rawValue,
                                "qc": item.investorRequirementsType.rawValue,
                            ]
                            do {
                                try itemJSON.merge(with: update44)
                            } catch {
                                // ignore
                            }
                            let update45: JSON = [
                                "circulatingShares": item.circulatingShare,
                                "earningsPerShare" :item.eps,
                                "earningsPerShareReportingPeriod": item.epsType,
                                
                                "amplitudeRate": item.amplitudeRate,
                                "receipts": item.receipts,
                                
                                "exerciseWay": item.exeType,
                                "orderRatio": item.orderRatio,
                                "hk_paramStatus": item.hkInfoStatus.rawValue,
                                "sumBuy": item.totalBuyVolume,
                            ]
                            do {
                                try itemJSON.merge(with: update45)
                            } catch {
                                // ignore
                            }
                            let update46: JSON = [
                                "buyVolume": item.buyVolume,
                                "sellVolume": item.sellVolume,
                                "totalValue": item.totalValue,
                                "flowValue": item.flowValue,
                                "netAsset": item.netAsset,
                                "pe": item.pe,
                                "pe2": item.spe,
                                "pb": item.roe,
                                "capitalization": item.capitalization,
                            ]
                            do {
                                try itemJSON.merge(with: update46)
                            } catch {
                                // ignore
                            }
                            let update47: JSON = [
                                "upDownLimitType": item.udFlag,
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
                                try itemJSON.merge(with: update47)
                            } catch {
                                // ignore
                            }
                            let update48: JSON = [
                                "highPrice": item.highPrice,
                                "lowPrice": item.lowPrice,
                                "openPrice": item.openPrice,
                                "preClosePrice": item.preClosePrice,
                                "volume": item.volume,
                                "nowVolume": item.nowVolume,
                                "turnoverRate": item.turnoverRate,
                            ]
                            do {
                                try itemJSON.merge(with: update48)
                            } catch {
                                // ignore
                            }
                            
                            
                            switch item.changeState{
                                
                            case .flat:
                                itemJSON["changeRate"].string = item.changeRate
                            case .rise:
                                itemJSON["changeRate"].string = "+"+item.changeRate
                            case .drop:
                                itemJSON["changeRate"].string = "-"+item.changeRate
                            }
                            
                            if item.addValueItem != nil{
                                let addValueitem: MAddValueItem = item.addValueItem!
                                var itemJSON1: JSON = [
                                    "code" : addValueitem.code,
                                    "date" : addValueitem.date,
                                    "time" : addValueitem.time,
                                    "ultraLargeBuyVolume" : addValueitem.ultraLargeBuyVolume,
                                    "ultraLargeSellVolume" : addValueitem.ultraLargeSellVolume,
                                    "ultraLargeBuyAmount" : addValueitem.ultraLargeBuyAmount,
                                    "ultraLargeSellAmount" : addValueitem.ultraLargeSellAmount,
                                    "largeBuyVolume" : addValueitem.largeBuyVolume,
                                    "largeSellVolume" : addValueitem.largeSellVolume,
                                ]
                                let update49: JSON = [
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
                                do {
                                    try itemJSON1.merge(with: update49)
                                } catch {
                                    // ignore
                                }
                                let update50: JSON = [
                                    "RatioBS" : addValueitem.ratioBS,
                                    "othersFundsInflows" : addValueitem.othersFundsInflows,
                                    "othersFundsOutflows" : addValueitem.othersFundsOutflows,
                                    "fiveMinutesChangeRate" : addValueitem.fiveMinRise,
                                    "largeOrderNumB" : addValueitem.ultraLargeBuyCount,
                                    "largeOrderNumS" : addValueitem.ultraLargeSellCount,
                                    "bigOrderNumB" : addValueitem.largeBuyCount,
                                    "bigOrderNumS" : addValueitem.largeSellCount,
                                    "midOrderNumB" : addValueitem.mediumBuyCount,
                                ]
                                do {
                                    try itemJSON1.merge(with: update50)
                                } catch {
                                    // ignore
                                }
                                let update51: JSON = [
                                    "BBD5" : addValueitem.bbd5,
                                    "BBD10" : addValueitem.bbd10,
                                    "DDX" : addValueitem.ddx,
                                    "DDX5" : addValueitem.ddx5,
                                    "DDX10" : addValueitem.ddx10,
                                    "DDY" : addValueitem.ddy,
                                    "DDY5" : addValueitem.ddy5,
                                    "DDY10" : addValueitem.ddy10,
                                    "DDZ" : addValueitem.ddz,
                                ]
                                do {
                                    try itemJSON1.merge(with: update51)
                                } catch {
                                    // ignore
                                }
                                let update52: JSON = [
                                    "largeDiffer" : addValueitem.largeDiffer,
                                    "mediumDiffer" : addValueitem.mediumDiffer,
                                    "smallDiffer" : addValueitem.smallDiffer,
                                    "largeBuyDealCount" : addValueitem.largeBuyDealCount,
                                    "largeSellDealCount" : addValueitem.largeSellDealCount,
                                    "dealCountMovingAverage" : addValueitem.dealCountMovingAverage,
                                    "buyCount" : addValueitem.buyCount,
                                    "sellCount" : addValueitem.sellCount,
                                    "BBD" : addValueitem.bbd,
                                ]
                                do {
                                    try itemJSON1.merge(with: update52)
                                } catch {
                                    // ignore
                                }
                                let update53: JSON = [
                                    "smallSellAmount" : addValueitem.smallSellAmount,
                                    "ultraLargeNetInflow" : addValueitem.ultraLargeNetInflow,
                                    "largeNetInflow" : addValueitem.largeNetInflow,
                                    "netCapitalInflow" : addValueitem.netCapitalInflow,
                                    "mediumNetInflow" : addValueitem.mediumNetInflow,
                                    "smallNetInflow" : addValueitem.smallNetInflow,
                                    "fundsInflows" : addValueitem.fundsInflows,
                                    "fundsOutflows" : addValueitem.fundsOutflows,
                                    "ultraLargeDiffer" : addValueitem.ultraLargeDiffer,
                                ]
                                do {
                                    try itemJSON1.merge(with: update53)
                                } catch {
                                    // ignore
                                }
                                let update54: JSON = [
                                    "largeBuyAmount" : addValueitem.largeBuyAmount,
                                    "largeSellAmount" : addValueitem.largeSellAmount,
                                    "mediumBuyVolume" : addValueitem.mediumBuyVolume,
                                    "mediumSellVolume" : addValueitem.mediumSellVolume,
                                    "mediumBuyAmount" : addValueitem.mediumBuyAmount,
                                    "mediumSellAmount" : addValueitem.mediumSellAmount,
                                    "smallBuyVolume" : addValueitem.smallBuyVolume,
                                    "smallSellVolume" : addValueitem.smallSellVolume,
                                    "smallBuyAmount" : addValueitem.smallBuyAmount,
                                ]
                                do {
                                    try itemJSON1.merge(with: update54)
                                } catch {
                                    // ignore
                                }
                                itemJSON["addValue"] = itemJSON1
                        }
                            resultJSON["\(i)"] = itemJSON
                            i = i+1
                        }
                        
                    }
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
            }
