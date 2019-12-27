//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//分类排行_1
//pageSize、pageIndex 翻页方式查询
import XCTest
import os.log
import SwiftyJSON

class CATESORTING_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.CATESORTING_1
    }
    
    func testCategorySorting() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MCategorySortingRequest()
        mRequest.code = param["CateType"].stringValue
        
        let paramI:NSArray = (param["param"].string?.split(separator: ",") as! NSArray)
        mRequest.pageSize = Int(paramI[1] as! String)!
        mRequest.pageIndex = Int(paramI[0] as! String)!
        if paramI[3] as! String == "0"{
            mRequest.ascending = ("1" as NSString).boolValue
        }else if paramI[3] as! String == "1"{
            mRequest.ascending = ("0" as NSString).boolValue
        }
        mRequest.field = MCategorySortingField.init(rawValue: Int(paramI[2] as! String)!)!
        mRequest.includeSuspension = (paramI[4] as! NSString).boolValue
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
//        mRequest.code = "SH1001"
//        mRequest.pageSize = 100
//        mRequest.pageIndex = 0
//        mRequest.ascending = false
//        mRequest.field = MCategorySortingField.init(rawValue: 1)!
//        mRequest.includeSuspension = true
//        mRequest.stockFields = []
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
                    "vote":item.voteFlag,
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
                    "blockChg":item.weightedChange,
                    "averageChg":item.averageChange,
                    "indexChg5":item.changeRate5,
                    "indexChg10":item.changeRate10
                    ]
                
                
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
