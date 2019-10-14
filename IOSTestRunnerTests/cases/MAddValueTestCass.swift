//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//增值指标
import XCTest
import os.log
import SwiftyJSON

class MAddValueTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.MAddValuetTestCase
    }
    //MAddValueItem
    func testSnapQuote() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MAddValueRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
//        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
//                                    mRequest.sourceType = typeVal
//                            }
        
        if let fields = param["FIELDS"].array{
            var fieldVal = [String]()
            for field in fields{
                fieldVal.append(field.stringValue)
            }
             mRequest.fields = fieldVal
        }
       
        let resp = self.makeSyncRequest(request: mRequest)
        let addValueResponse = resp as! MAddValueResponse
        XCTAssertNotNil(addValueResponse.addValueItems)
        for item in addValueResponse.addValueItems {

                       print(item)

        }

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

