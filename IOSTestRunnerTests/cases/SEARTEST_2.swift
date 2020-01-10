//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//股票查询
import XCTest
import os.log
import SwiftyJSON

class SEARTEST_2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.SEARTEST_2
    }
    
    func testSearch() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MSearchRequest()
         mRequest.keyword = param["KEYWORD"].stringValue
         mRequest.searchLimit = param["SEARCHLIMIT"].uIntValue
         mRequest.returnRenamed = ("1" as NSString).boolValue
         mRequest.returnDelisted = ("1" as NSString).boolValue
    
        
        let resp = self.makeSyncRequest(request: mRequest)
        let searchResponse = resp as! MSearchResponse
        XCTAssertNotNil(searchResponse.resultItems)
        var resultJSON : JSON = [:]
        for items in searchResponse.resultItems {
            let itemJSON: JSON = [
                "stockID": items.stockID,
                "name": items.name,
                "market": items.market,
                "pinyin": items.pinyin,
                "subtype": items.subtype,
                "stockType": items.flag.rawValue,
                "st": items.subtypes
            ]
            resultJSON["\(items.stockID!)"] = itemJSON
            
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

