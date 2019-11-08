//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//个股静态数据
import XCTest
import os.log
import SwiftyJSON

class StaticDataTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.StaticDataTestCase
    }
    
    func testStaticData() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStaticDataRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.param = param["PARAM"].stringValue
        
        let resp = self.makeSyncRequest(request: mRequest)
        let staticDataResponse = resp as! MStaticDataResponse
        XCTAssertNotNil(staticDataResponse.dataItems)
        //        for item in addValueResponse.addValueItems {
        //
        //                       print(item)
        //                       print(item)
        //
        
        
        //            var resultJSON: JSON = [
        //                "lastPrice": item.lastPrice,
        //                "highPrice": item.highPrice
        //            ]
        //            if let anyItems = item.tickItems{
        //                var jsonarray2 = [JSON]()
        //                for anyItem in anyItems{
        //                    if !(anyItem is MTickItem){
        //                        continue
        //                    }
        //
        //                    let tickitem:MTickItem = anyItem as! MTickItem
        //                    let jsonarray1: JSON = [
        //                        "amsflag": tickitem.tradeVolume,
        //                        "aaa": tickitem.amsFlag.rawValue
        //                    ]
        //                    jsonarray2.append(jsonarray1)
        //                }
        //                resultJSON["tickitem"].arrayObject = jsonarray2
        //            }
        //            print(resultJSON)
        //            onTestResult(param: param, result: resultJSON)
        //        }
        //    }
        //
    }
}

