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

class SEARTEST_5: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.SEARTEST_5
    }
    
    func testSearch() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MSearchRequest()
         mRequest.keyword = param["KEYWORD"].stringValue
        if param["CATEGORIES"].stringValue != ""{
            let fields:NSArray = (param["CATEGORIES"].string?.split(separator: ",") as! NSArray)

            mRequest.categories = fields as! [Any]
        }
         mRequest.searchLimit = param["SEARCHLIMIT"].uIntValue
         let queryStsI:Array = param["querySts"].arrayValue
         if queryStsI.count == 0{
             mRequest.returnRenamed = ("0" as NSString).boolValue
             mRequest.returnDelisted = ("0" as NSString).boolValue
         }else if queryStsI.count == 2{
             mRequest.returnRenamed = ("1" as NSString).boolValue
             mRequest.returnDelisted = ("1" as NSString).boolValue
         }else if queryStsI.count == 1{
             if queryStsI[0] == "9900"{
                 mRequest.returnRenamed = ("1" as NSString).boolValue
                 mRequest.returnDelisted = ("0" as NSString).boolValue
             }else if queryStsI[0] == "9800"{
                 mRequest.returnRenamed = ("0" as NSString).boolValue
                 mRequest.returnDelisted = ("1" as NSString).boolValue
             }
         }
    
        
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

