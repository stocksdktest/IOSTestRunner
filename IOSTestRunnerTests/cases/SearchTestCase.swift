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

class SearchTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.SearchTestCase
    }
    
    func testSearch() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MSearchRequest()
         mRequest.keyword = param["KEYWORD"].stringValue
        if let fields = param["CATEGORIES"].array{
            var fieldVal = [String]()
            for field in fields{
                fieldVal.append(field.stringValue)
            }
                mRequest.categories = fieldVal
        }
         mRequest.searchLocal = param["SEARCHLOCAL"].boolValue
         mRequest.searchLimit = param["SEARCHLIMIT"].uIntValue
         mRequest.returnRenamed = param["RETURNRENAMED"].boolValue
         mRequest.returnDelisted = param["RETURNDELISTED"].boolValue
    
        
        let resp = self.makeSyncRequest(request: mRequest)
        let searchResponse = resp as! MSearchResponse
        XCTAssertNotNil(searchResponse.resultItems)
        var resultJSON : JSON = [:]
        for items in searchResponse.resultItems {
            var itemJSON: JSON = [
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

