//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//板块行情请求类
import XCTest
import os.log
import SwiftyJSON

class BANKUAIQUOTE_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.BANKUAIQUOTE_1
    }
    
    func testSectionQuote() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MSectionQuoteRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.type = param["TYPE"].stringValue
        
        let resp = self.makeSyncRequest(request: mRequest)
        let sectionQuoteResponse = resp as! MSectionQuoteResponse
        XCTAssertNotNil(sectionQuoteResponse.sectionQuoteItems)
        var resultJSON : JSON = [:]
        for item in sectionQuoteResponse.sectionQuoteItems {
            var itemJSON: JSON = [
                "ID": item.id,
                "name": item.name,
                "weightedChange": item.weightedChange,
                "averageChange": item.averageChange,
                "amount": item.amount,
                "advanceAndDeclineCount": item.advanceAndDeclineCount,
                "turnoverRate": item.turnoverRate,
                "stockID": item.stockID,
                "stockName": item.stockName,
                "stockChange": item.stockChange,
                "stockChangeRate": item.stockChangeRate,
                "netCapitalInflow": item.netCapitalInflow,
                "netCapitalInflow5": item.netCapitalInflow5,
                "netCapitalInflow10": item.netCapitalInflow10,
                "capitalInflow": item.capitalInflow,
                "capitalOutflow": item.capitalOutflow,
                "type": item.type,
                "hot": item.hot,
                "volume": item.volume,
                "nowVolume": item.nowVolume,
                "lastPrice": item.lastPrice,
                "changeRate": item.changeRate,
                "changeRate5": item.changeRate5,
                "changeRate10": item.changeRate10,
                "flowValue": item.flowValue,
                "totalValue": item.totalValue,
                "riseRate": item.riseRate,
                "openPrice": item.openPrice,
                "highPrice": item.highPrice,
                "lowPrice": item.lowPrice,
                "preClosePrice": item.preClosePrice,
                "change": item.change,
                "entrustBuyVolume": item.entrustBuyVolume,
                "entrustSellVolume": item.entrustSellVolume,
                "orderRatio": item.orderRatio,
                "entrustDiff": item.entrustDiff,
                "PE": item.pe,
                "SPE": item.spe,
                "ROE": item.roe,
                "amplitudeRate": item.amplitudeRate,
                "stockLastPrice": item.stockLastPrice,
                "limitUpCount": item.limitUpCount,
                "limitDownCount": item.limitDownCount,
                "lzgj":item.stockLastPrice
            ]
            resultJSON["\(item.id!)"] = itemJSON
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

