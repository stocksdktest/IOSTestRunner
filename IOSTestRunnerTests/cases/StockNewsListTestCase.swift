//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//个股新闻列表
import XCTest
import os.log
import SwiftyJSON

class StockNewsListTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.StockNewsListTestCase
    }
    
    func testStockNewsList() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStockNewsListRequest()
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
            }
        
        mRequest.code = param["CODE"].stringValue
        mRequest.newsID = param["NEWSID"].stringValue
        
        if let typeVal =  F10NewsRequestType.init(rawValue:param["TYPE"].intValue) {
            mRequest.type = typeVal
            }
        
        mRequest.pageSize = param["PAGESIZE"].intValue
        
        let resp = self.makeSyncRequest(request: mRequest)
        let stockNewsListResponse = resp as! MStockNewsListResponse
        XCTAssertNotNil(stockNewsListResponse.stockNewsItems)
        for items in stockNewsListResponse.stockNewsItems{
            if let item: MStockNewsItem = items as! MStockNewsItem{
                var resultJSON: JSON = [
                    "INIPUBDATE_":item.datetime,
                    "ID_":item.id,
                    "REPORTTITLE_":item.title,
                    "MEDIANAME_":item.source,
                    "REPORTLEVEL_":item.level,
                    "STOCKNAME_":item.stockName,
                    "ISPDF":item.isPDF,
                    "ENTRYDATE":item.entryDate,
                    "ENTRYTIME":item.entryTime,
                ]
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
    }
}

