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

class StockBulletinListTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.StockBulletinListTestCase
    }
    
    func testStockBulletinList() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStockBulletinListRequest()
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
        let stockBulletinListResponse = resp as! MStockBulletinListResponse
        XCTAssertNotNil(stockBulletinListResponse.stockBulletinItems)
        for items in stockBulletinListResponse.stockBulletinItems{
            if let item: MStockBulletinItem = items as! MStockBulletinItem{
               var resultJSON: JSON = [
                    "PUBDATE_":item.datetime,
                    "ID_":item.id,
                    "TITLE_":item.title,
                    "dataSource":item.source,
                    "STOCKNAME_":item.stockName,
                    "ISPDF_":item.isPDF,
                    "ENTRYDATE":item.entryDate,
                    "ENTRYTIME":item.entryTime,
                ]
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
    }
}
