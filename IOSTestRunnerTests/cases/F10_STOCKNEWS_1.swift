//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//个股新闻明细
import XCTest
import os.log
import SwiftyJSON

class F10_STOCKNEWS_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_STOCKNEWS_1
    }
    
    func testStockNews() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStockNewsRequest()
        mRequest.stockNewsID = param["STOCKNEWSID"].stringValue
        
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let stockNewsResponse = resp as! MStockNewsResponse
        XCTAssertNotNil(stockNewsResponse.stockNewsDetailItem)
        if let item = stockNewsResponse.stockNewsDetailItem{
            var resultJSON: JSON = [
                "INIPUBDATE_":item.datetime,
                "ID_":item.id,
                "reportTitle":item.title,
                "MEDIANAME_":item.source,
                "ABSTRACT_":item.content,
//                "ABSTRACTFORMAT_":item.format,
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
