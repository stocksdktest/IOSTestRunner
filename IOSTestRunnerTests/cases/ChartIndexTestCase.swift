//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//分时走势指标数据
import XCTest
import os.log
import SwiftyJSON

class ChartIndexTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.ChartIndexTestCase
    }
   
    func testChartIndex() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MChartIndexRequest()
        mRequest.code = param["CODE"].stringValue
        let typeVal = MChartIndexType.init(rawValue: param["TYPE"].intValue)
            mRequest.type = typeVal
        
        mRequest.beginIndex = param["BEGININDEX"].intValue
        mRequest.endIndex   = param["ENDINDEX"].intValue
        let resp = self.makeSyncRequest(request: mRequest)
        let chartIndexResponse = resp as! MChartIndexResponse
        XCTAssertNotNil(chartIndexResponse)
        var resultJSON : JSON = [:]
        var j = 1
//        print(chartIndexResponse)
        for items in chartIndexResponse.ohlcItems{
        var itemJSON: JSON = [
             "ddx":items.ddx,
             "ddy":items.ddy,
             "ddz":items.ddz,
             "bbd":items.bbd,
             "ratioBS":items.ratioBS,
             "largeMoneyInflow":items.largeMoneyInflow,
             "bigMoneyInflow ":items.bigMoneyInflow,
             "midMoneyInflow":items.midMoneyInflow,
             "smallMoneyInflow":items.smallMoneyInflow,
             "largeTradeNum":items.largeTradeNum,
             "bigTradeNum ":items.bigTradeNum,
             "midTradeNum":items.midTradeNum,
             "smallTradeNum":items.smallTradeNum,
             "bigNetVolume": items.bigNetVolume,
             
         ]
            resultJSON["\(j)"] = itemJSON
            j = j + 1

      }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}
