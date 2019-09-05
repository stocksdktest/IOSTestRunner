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

class ExampleTestCase2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.SNAPQUOTE_REQUEST
    }
    
    func testExample2() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MSnapQuoteRequest()
        mRequest.code = param["QUOTE_NUMBERS"].stringValue
        mRequest.tickCount = 10
//        mRequest.stockFields = ["-1"]
//        mRequest.addValueFields = []
        let resp = self.makeSyncRequest(request: mRequest)
        let snapQuoteResponse = resp as! MSnapQuoteResponse
        XCTAssertNotNil(snapQuoteResponse.stockItem)
        if let item = snapQuoteResponse.stockItem {
            
            
//            print("\(item)")
//            print("\(item.id),\( item.name),\(item.lastPrice),\(item.openPrice),\(item.highPrice),\(item.lowPrice),\(item.preClosePrice),\(item.averagePrice),\(item.subtype2),\(item.tickItems)")
//            print("最新价：\(item.lastPrice),最高价：\(item.highPrice)")
            var resultJSON: JSON = [
                "lastPrice": item.lastPrice,
                "highPrice": item.highPrice
            ]
            if let tkitem = item.tickItems{
                var jsonarray2 = [JSON]()
                for tkitems in tkitem{
                    if !(tkitems is MTickItem){
                        continue
                    }
                    let tickitem:MTickItem = tkitems as! MTickItem
                    let jsonarray1: JSON = [
                        "amsflag": tickitem.tradeVolume,
                        "aaa": tickitem.amsFlag.rawValue
                    ]
                    jsonarray2.append(jsonarray1)
                }
                resultJSON["tickitem"].arrayObject = jsonarray2
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
    
}
