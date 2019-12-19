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

class StockBulletinTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.StockBulletinTestCase
    }
    
    func testStockBulletin() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStockBulletinRequest()
        mRequest.stockBulletinID = param["STOCKBULLETINID"].stringValue
        
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
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
