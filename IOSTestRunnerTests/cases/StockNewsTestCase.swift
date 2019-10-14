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

class StockNewsTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.StockNewsTestCase
    }
    
    func testStockNews() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MStockNewsRequest()
        mRequest.stockNewsID = param["STOCKNEWSID"].stringValue
        
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
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
                "ABSTRACTFORMAT_":item.format,
                "PURL":item.url,
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
}
