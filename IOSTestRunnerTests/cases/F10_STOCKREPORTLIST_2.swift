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

class F10_STOCKREPORTLIST_2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_STOCKREPORTLIST_2
    }
    
    func testStockReportList() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStockReportListRequest()
        let typeVal = param["SOURCETYPE"].stringValue
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
        
        let resp = self.makeSyncRequest(request: mRequest)
        let stockReportListResponse = resp as! MStockReportListResponse
        XCTAssertNotNil(stockReportListResponse.stockReportItems)
        var resultJSON : JSON = [:]
        var i=1
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
                resultJSON["\(i)"] = itemJSON
                i=i+1
                }
            }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
        }
}

