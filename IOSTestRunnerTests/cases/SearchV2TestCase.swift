//
//  SearchV2TestCase.swift
//  IOSTestRunnerTests
//
//  Created by HW1-MM01 on 2019/11/22.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class SearchV2TestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.SearchV2TestCase
    }
    
    func testSearch() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MSearchRequestV2()
         mRequest.keyword = param["KEYWORD"].stringValue
        if let fields = param["CATEGORIES"].array{
            var fieldVal = [String]()
            for field in fields{
                fieldVal.append(field.stringValue)
            }
                mRequest.categories = fieldVal
        }
         mRequest.searchLimit = param["SEARCHLIMIT"].uIntValue
    
        
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
