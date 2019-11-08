//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//沪伦通列表接口
import XCTest
import os.log
import SwiftyJSON

class DRQuoteListTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.DRQuoteListTestCase
    }
   
    func testDRQuoteList() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MDRQuoteListRequest()
        mRequest.code = param["CODE"].stringValue
        mRequest.pageIndex = param["PAGEINDEX"].intValue
        mRequest.pageSize  = param["PAGESIZE"].intValue
        if let typeVal = MDRQuoteListField.init(rawValue:param["FIEID"].intValue) {
            mRequest.field = typeVal
        }
         mRequest.ascending = param["ASCENDING"].boolValue
        
        let resp = self.makeSyncRequest(request: mRequest)
        let dRQuoteListResponse = resp as! MDRQuoteListResponse
        XCTAssertNotNil(dRQuoteListResponse.items)
        var resultJSON : JSON = [:]
        for items in dRQuoteListResponse.items {
        var itemJSON: JSON = [
                "code":items.code,
                "name":items.name,
                "subType":items.subtype,
                "lastPrice":items.lastPrice,
                "preClosePrice":items.preClosePrice,
                "changeRate":items.changeRate,
                "change":items.change,
                "dateTime":items.datetime,
                "baseCode":items.baseStockCode,
                "baseName":items.baseStockName,
                "baseLastPrice":items.baseLastPrice,
                "basePreClosePrice":items.basePreClosePrice,
                "baseSubtype":items.baseSubtype,
                "baseChangeRate":items.baseChangeRate,
                "baseChange":items.baseChange,
                "baseDateTime":items.baseDatetime,
                "premium":items.premiumRate,
            ]
            resultJSON["\(items.datetime!)"] = itemJSON
            
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}
