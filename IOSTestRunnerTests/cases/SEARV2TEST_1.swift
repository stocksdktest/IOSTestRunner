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

class SEARV2TEST_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.SEARV2TEST_1
    }
    
    func testSearch() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MSearchRequestV2()
         mRequest.keyword = param["KEYWORD"].stringValue
        
        if param["MARKET"].stringValue != ""{
            let fields:NSArray = (param["MARKET"].string?.split(separator: ",") as! NSArray)

            mRequest.categories = fields as! [Any]
        }
//         mRequest.searchLimit = param["SEARCHLIMIT"].uIntValue
    
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let searchResponse = resp as! MSearchResponse
//        XCTAssertNotNil(searchResponse.resultItems)
        if (searchResponse.resultItems == nil){
            throw BaseTestError.assertFailedError(message: "searchResponse resultItems is nil")
        }
        var resultJSON : JSON = [:]
        for items in searchResponse.resultItems {
            var itemJSON: JSON = [
                "stockID": items.stockID,
                "name": items.name,
                "market": items.market,
                "pinyin": items.pinyin,
                "subtype": items.subtype,
                "stockType": String(items.flag.rawValue),
                "st": items.subtypes
            ]
            
            var itemJSON2 : JSON = [:]
            var itemDic : Dictionary = [String:String]()
            for itemKey in itemJSON.dictionaryValue.keys{
                
                itemDic[itemKey] = itemJSON[itemKey].stringValue
                if itemDic[itemKey] != ""{
                    itemJSON2[itemKey].stringValue = itemDic[itemKey]!
                }else{
                    itemJSON2[itemKey].stringValue = "-"
                }
                
            }
            var itemID: String = items.stockID.replacingOccurrences(of: ".", with: "_")
            
            resultJSON["\(itemID)"] = itemJSON2
            
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}
