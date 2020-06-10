//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//个股公告列表
import XCTest
import os.log
import SwiftyJSON

class F10_STOCKBULLETINLIST_2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_STOCKBULLETINLIST_2
    }
    
    func testStockBulletinList() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStockBulletinListRequest()
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        mRequest.code = param["CODE"].stringValue
        mRequest.newsID = param["NEWSID"].stringValue
        
        if param["TYPE"] == "-1"{
            mRequest.type = F10NewsRequestType(rawValue: -1)!
        }else if param["TYPE"] == "5"{
            mRequest.type = F10NewsRequestType(rawValue: 1)!
        }else if param["TYPE"] == "6"{
            mRequest.type = F10NewsRequestType(rawValue: 2)!
        }
        
        mRequest.pageSize = param["PAGESIZE"].intValue
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let stockBulletinListResponse = resp as! MStockBulletinListResponse
//        XCTAssertNotNil(stockBulletinListResponse.stockBulletinItems)
        if (stockBulletinListResponse.stockBulletinItems == nil){
            throw BaseTestError.assertFailedError(message: "stockBulletinListResponse stockBulletinItems is nil")
        }
        var resultJSON : JSON = [:]
        for items in stockBulletinListResponse.stockBulletinItems{
            if let item: MStockBulletinItem = items as! MStockBulletinItem{
               var itemJSON: JSON = [
                    "PUBDATE_":item.datetime,
                    "ID_":item.id,
                    "TITLE_":item.title,
                    "dataSource":item.source,
                    "STOCKNAME_":item.stockName,
                    "ISPDF_":item.isPDF,
                    "ENTRYDATE":item.entryDate,
                    "ENTRYTIME":item.entryTime,
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
                var itemID: String = item.id.replacingOccurrences(of: ".", with: "_")
                
                resultJSON["\(itemID)"] = itemJSON2
            }
           
            
        }
        
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}
