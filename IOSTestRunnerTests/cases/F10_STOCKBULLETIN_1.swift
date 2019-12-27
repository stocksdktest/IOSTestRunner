//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//个股公告明细
import XCTest
import os.log
import SwiftyJSON

class F10_STOCKBULLETIN_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_STOCKBULLETIN_1
    }
    
    func testStockBulletin() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStockBulletinRequest()
        mRequest.stockBulletinID = param["STOCKBULLETINID"].stringValue
        
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let stockBulletinResponse = resp as! MStockBulletinResponse
        XCTAssertNotNil(stockBulletinResponse.stockBulletinDetailItem)
        var resultJSON : JSON = [:]
        if let item = stockBulletinResponse.stockBulletinDetailItem{
            var itemJSON: JSON = [
                "PUBDATE_":item.datetime,
                "ID_":item.id,
                "title":item.title,
                "dataSource":item.source,
                "Content":item.content,
                "CONTENTFORMAT_":item.format,
                "PURL":item.url,
            ]
            resultJSON["\(item.datetime!)"] = itemJSON
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}
