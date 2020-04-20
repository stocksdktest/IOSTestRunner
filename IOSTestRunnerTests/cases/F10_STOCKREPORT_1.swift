//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//个股研报明细
import XCTest
import os.log
import SwiftyJSON

class F10_STOCKREPORT_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_STOCKREPORT_1
    }
    
    func testStockReport() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStockReportRequest()
        mRequest.stockReportID = param["STOCKREPORTID"].stringValue
        
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let stockReportListResponse = resp as! MStockReportResponse
//        XCTAssertNotNil(stockReportListResponse.stockReportDetailItem)
        if (stockReportListResponse.stockReportDetailItem == nil){
            throw BaseTestError.assertFailedError(message: "stockReportListResponse stockReportDetailItem is nil")
        }
          if let item = stockReportListResponse.stockReportDetailItem{
                var resultJSON: JSON = [
         
                    "PUBDATE_":item.datetime,
                    "ID_":item.id,
                    "reportTitle":item.title,
                    "dataSource":item.source,
                    "ABSTRACT_":item.content,
//                    "ABSTRACTFORMAT_":item.format,
                    "PURL_":item.url,
                ]
            if item.format != nil{
                resultJSON["ABSTRACTFORMAT_"].stringValue = item.format
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
            }
        
        }
    }
