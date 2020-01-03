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

class CHARTSUB_2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.CHARTSUB_2
    }
   
    func testChartIndex() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MChartIndexRequest()
        mRequest.code = param["CODE"].stringValue
        let TYPE:NSArray = (param["TYPE"].string?.split(separator: ",") as! NSArray)
        var typeInt = 0
        print(TYPE)
        for typeVals in TYPE{
            let typeVal:String = typeVals as! String
            switch typeVal{
            case "bbd":
                typeInt = typeInt | 1<<3
            case "ddx":
                typeInt = typeInt | 1<<0
            case "ddy":
                typeInt = typeInt | 1<<1
            case "ddz":
                typeInt = typeInt | 1<<2
            case "ratioBS":
                typeInt = typeInt | 1<<4
            case "largeMoneyInflow":
                typeInt = typeInt | 1<<5
            case "bigMoneyInflow":
                typeInt = typeInt | 1<<6
            case "midMoneyInflow":
                typeInt = typeInt | 1<<7
            case "smallMoneyInflow":
                typeInt = typeInt | 1<<8
            case "largeTradeNum":
                typeInt = typeInt | 1<<9
            case "bigTradeNum":
                typeInt = typeInt | 1<<10
            case "midTradeNum":
                typeInt = typeInt | 1<<11
            case "smallTradeNum":
                typeInt = typeInt | 1<<12
            case "bigNetVolume":
                typeInt = typeInt | 1<<13
            default:
                var typeInt1 = 1<<0 | 1<<1 | 1<<2 | 1<<3
                var typeInt2 = 1<<4 | 1<<5 | 1<<6 | 1<<7
                var typeInt3 = 1<<8 | 1<<9
                typeInt = typeInt1 | typeInt2 | typeInt3
            }
        }
        mRequest.type = MChartIndexType.init(rawValue: typeInt)
        mRequest.beginIndex = param["BEGIN"].intValue
        mRequest.endIndex   = param["END"].intValue
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
             
             
         ]
        let update1: JSON = [
            "smallMoneyInflow":items.smallMoneyInflow,
            "largeTradeNum":items.largeTradeNum,
            "bigTradeNum ":items.bigTradeNum,
            "midTradeNum":items.midTradeNum,
            "smallTradeNum":items.smallTradeNum,
            "bigNetVolume": items.bigNetVolume,
        ]
        do {
            try itemJSON.merge(with: update1)
        } catch {
            // ignore
        }
            resultJSON["\(j)"] = itemJSON
            j = j + 1

      }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}
