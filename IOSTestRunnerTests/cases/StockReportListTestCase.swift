//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//个股研报列表
import XCTest
import os.log
import SwiftyJSON

class StockReportListTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.StockReportListTestCase
    }
    
    func testStockReportList() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStockReportListRequest()
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
        let stockReportListResponse = resp as! MStockReportListResponse
        XCTAssertNotNil(stockReportListResponse.stockReportItems)
        var resultJSON : JSON = [:]
        for items in stockReportListResponse.stockReportItems{
            if let item: MStockReportItem = items as! MStockReportItem{
                var itemJSON: JSON = [
                "PUBDATE_":item.datetime,
                "ID_":item.id,
                "ReportTitle":item.title,
                "dataSource":item.source,
                "REPORTLEVEL_":item.level,
                "ComName":item.source,
                "STOCKNAME_":item.stockName,
                "ISPDF_":item.isPDF,
                "ENTRYDATE":item.entryDate,
                "ENTRYTIME":item.entryTime,
                ]
                resultJSON["\(item.datetime!)"] = itemJSON
                
                }
            }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
        }
}

