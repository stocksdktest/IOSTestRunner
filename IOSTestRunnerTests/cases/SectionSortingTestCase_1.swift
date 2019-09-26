//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//板块排行_1
import XCTest
import os.log
import SwiftyJSON

class SectionSortingTestCase_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.SectionSortingTestCase_1
    }
    
    func testSectionSorting() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MSectionSortingRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.pageIndex = param["PAGEINDEX"].intValue
        mRequest.pageSize = param["PAGESIZE"].intValue
        mRequest.ascending = param["ASCENDING"].boolValue
        if let typeVal = MSectionSortingField.init(rawValue:param["FIEID"].intValue) {
            mRequest.field = typeVal
        }
       
        let resp = self.makeSyncRequest(request: mRequest)
        let sectionSortingResponse = resp as! MSectionSortingResponse
        XCTAssertNotNil(sectionSortingResponse.sectionSortingItems)
        for item in sectionSortingResponse.sectionSortingItems {
            var resultJSON: JSON = [
                "id": item.id,
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
                "pe": item.pe,
                "spe": item.spe,
                "roe": item.roe,
                "amplitudeRate": item.amplitudeRate,
                "stockLastPrice": item.stockLastPrice,
                "limitUpCount": item.limitUpCount,
                "limitDownCount": item.limitDownCount
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
        
    }
}

