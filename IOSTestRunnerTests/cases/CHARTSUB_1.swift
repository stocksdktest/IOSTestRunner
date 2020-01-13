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

class CHARTSUB_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.CHARTSUB_1
    }
   
    func testChartIndex() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MChartIndexRequest()
        mRequest.code = param["CODE"].stringValue
        
        let TYPE:NSArray = (param["TYPE"].string?.split(separator: ",") as! NSArray)
        var typeInt = 0
        for typeVals in TYPE{
            let typeVal:String = typeVals as! String
            switch typeVal{
            case "4":
                typeInt = typeInt | 1<<3
            case "1":
                typeInt = typeInt | 1<<0
            case "2":
                typeInt = typeInt | 1<<1
            case "3":
                typeInt = typeInt | 1<<2
            case "5":
                typeInt = typeInt | 1<<4
            case "6":
                typeInt = typeInt | 1<<5 | 1<<6 | 1<<7 | 1<<8
            case "7":
                typeInt = typeInt | 1<<13
            default:
                let typeInt1 = 1<<0 | 1<<1 | 1<<2 | 1<<3
                let typeInt2 = 1<<4 | 1<<5 | 1<<6 | 1<<7
                let typeInt3 = 1<<8
                typeInt = typeInt1 | typeInt2 | typeInt3
            }
        }
        mRequest.type = MChartIndexType.init(rawValue: typeInt)
        let resp = self.makeSyncRequest(request: mRequest)
        let chartIndexResponse = resp as! MChartIndexResponse
        XCTAssertNotNil(chartIndexResponse)
        var resultJSON : JSON = [:]
        var j = 1
//        print(chartIndexResponse)
        for items in chartIndexResponse.ohlcItems{
            var itemJSON2 : JSON = [:]
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
            var itemDic : Dictionary = [String:String]()
                            for itemKey in itemJSON.dictionaryValue.keys{
                                
                                itemDic[itemKey] = itemJSON[itemKey].stringValue
                                if itemDic[itemKey] != ""{
                                    itemJSON2[itemKey].stringValue = itemDic[itemKey]!
                                }
            //                    print(itemDic[itemKey]!)
                                
                            }

                            resultJSON["\(j)"] = itemJSON2
                            j=j+1
                            }
                            
                        
                        print(resultJSON)
                        onTestResult(param: param, result: resultJSON)
    }
}
