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
    
    func testSearch() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MSearchRequest()
        mRequest.keyword = param["KEYWORD"].stringValue
         mRequest.searchLimit = param["SEARCHLIMIT"].uIntValue
         mRequest.returnRenamed = ("0" as NSString).boolValue
         mRequest.returnDelisted = ("0" as NSString).boolValue
    
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let searchResponse = resp as! MSearchResponse
//        XCTAssertNotNil(searchResponse.resultItems)
        if (searchResponse.resultItems == nil){
            throw BaseTestError.assertFailedError(message: "searchResponse resultItems is nil")
        }
        var resultJSON : JSON = [:]
        var i = 1
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
            print(items.flag)
            resultJSON["\(i)"] = itemJSON2
            i=i+1
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

