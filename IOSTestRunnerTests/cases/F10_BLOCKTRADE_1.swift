//
//  BlockTradeTestCase.swift
//  IOSTestRunnerTests
//
//  Created by 俞建斌 on 2019/9/25.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class F10_BLOCKTRADE_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_BLOCKTRADE_1
    }
    func testF10() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MF10Request()
        mRequest.code = param["CODE"].stringValue
        mRequest.requestType = "blocktrade"
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
//        if param["PARAM"].dictionary != nil{
//            mRequest.param = param["PARAM"].dictionary
//
//        }
        let resp = self.makeSyncRequest(request: mRequest)
        let f10Response = resp as! MF10Response
        XCTAssertNotNil(f10Response.jsonObject)
        
        if mRequest.requestType == "blocktrade"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                var resultJSON : JSON = [:]
                var i=1
                for List in Lists{
                    if let dic2 : NSDictionary = List as! NSDictionary{
                        var jsonarr2: JSON = [
                            "TRADEDATE":dic2["TRADEDATE"]!,
                            "TRADEPRICE":dic2["TRADEPRICE"]!,
                            "VOLUME":dic2["VOLUME"]!,
                            "AMOUNT":dic2["AMOUNT"]!,
                            "PRC":dic2["PRC"]!,
                            "BUYERNAME":dic2["BUYERNAME"]!,
                            "SELLERNAME":dic2["SELLERNAME"]!,
                        ]
                        resultJSON["\(i)"] = jsonarr2
                        i=i+1
                    }
                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
    }
}
