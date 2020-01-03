//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//UK行情快照
import XCTest
import os.log
import SwiftyJSON

class UKQUOTE_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.UKQUOTE_1
    }
    
    func testUKQuote() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MUKQuoteRequest()
        mRequest.code = param["CODE"].stringValue
        
        let resp = self.makeSyncRequest(request: mRequest)
        let uKQuoteResponse = resp as! MUKQuoteResponse
        XCTAssertNotNil(uKQuoteResponse.stockItems)
        var resultJSON : JSON = [:]
        for items in uKQuoteResponse.stockItems {
        var itemJSON: JSON = [
                "code":items.id,
                "name":items.name,
                "subtype":items.subtype,
                "lastPrice":items.lastPrice,
                "openPrice":items.openPrice,
                "datetime":items.datetime,
                "volume":items.volume,
                "amount":items.amount,
            ]
            let update1: JSON = [
                "conversionBase":items.conversionBase,
                "securitiesConversionBase":items.securitiesConversionBase,
                "GDR":items.gdr,
                "CDR":items.dr,
                "stockCode":items.drStockCode,
                "stockName":items.drStockName,
                "subtypes":items.drSubtypes,
                "subjectClosingReferencePrice":items.subjectClosingReferencePrice,
                "premium":items.premiumRate,
            ]
            do {
                try itemJSON.merge(with: update1)
            } catch {
                // ignore
            }
            let update2: JSON = [
                "lowPriceYearAuto":items.lowPriceYearAuto,
                "lowPriceYearNonAuto":items.lowPriceNonYearAuto,
                "highPriceTimeYearAuto":items.highPriceTimeYearAuto,
                "highPriceTimeYearNonAuto":items.highPriceTimeYearNonAuto,
                "lowPriceTimeYearAuto":items.lowPriceTimeYearAuto,
                "lowPriceTimeYearNonAuto":items.lowPriceTimeYearNonAuto,
                "averageValue":items.averagePrice,
                "currency":items.currency,
                "listingDate":items.listingDate,
            ]
            do {
                try itemJSON.merge(with: update2)
            } catch {
                // ignore
            }
            let update3: JSON = [
                "transactionNumber":items.transactionNumber,
                "closeBuyPrice":items.buyPrice,
                "closeSellPrice":items.sellPrice,
                "highPriceDayAuto":items.highPriceDayAuto,
                "highPriceDayNonAuto":items.highPriceNonDayAuto,
                "lowPriceDayAuto":items.lowPriceDayAuto,
                "lowPriceDayNonAuto":items.lowPriceNonDayAuto,
                "highPriceYearAuto":items.highPriceYearAuto,
                "highPriceYearNonAuto":items.highPriceNonYearAuto,
            ]
            do {
                try itemJSON.merge(with: update3)
            } catch {
                // ignore
            }
            resultJSON["\(items.datetime!)"] = itemJSON
            
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

