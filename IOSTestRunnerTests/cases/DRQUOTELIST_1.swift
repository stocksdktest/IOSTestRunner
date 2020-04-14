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

class DRQUOTELIST_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.DRQUOTELIST_1
    }
   
    func testDRQuoteList() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MDRQuoteListRequest()
        mRequest.code = param["DRCODE"].stringValue
        let paramI:NSArray = (param["PARAMS"].string?.split(separator: ",") as! NSArray)
        mRequest.pageSize = Int(paramI[1] as! String)!
        mRequest.pageIndex = Int(paramI[0] as! String)!
        if paramI[3] as! String == "0"{
            mRequest.ascending = ("1" as NSString).boolValue
        }else if paramI[3] as! String == "1"{
            mRequest.ascending = ("0" as NSString).boolValue
        }
        mRequest.field = MDRQuoteListField.init(rawValue: Int(paramI[2] as! String)!)!
        
        let resp = self.makeSyncRequest(request: mRequest)
        let dRQuoteListResponse = resp as! MDRQuoteListResponse
        XCTAssertNotNil(dRQuoteListResponse.items)
        var resultJSON : JSON = [:]
        var i = 1
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
                
            ]
            let update1: JSON = [
                "baseName":items.baseStockName,
                "baseLastPrice":items.baseLastPrice,
                "basePreClosePrice":items.basePreClosePrice,
                "baseSubtype":items.baseSubtype,
                "baseChangeRate":items.baseChangeRate,
                "baseChange":items.baseChange,
                "baseDateTime":items.baseDatetime,
                "premium":items.premiumRate,
            ]
            do {
                try itemJSON.merge(with: update1)
            } catch {
                // ignore
            }
            resultJSON["\(i)"] = itemJSON
            i=i+1
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}
