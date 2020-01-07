//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//股票组合
import XCTest
import os.log
import SwiftyJSON

class F10_STOCKPORTFOLIO_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_STOCKPORTFOLIO_1
    }
   
    func testFundStockPortfolio() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFundStockPortfolioRequest()
        mRequest.code = param["CODE"].stringValue
       
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
    
        let resp = self.makeSyncRequest(request: mRequest)
        let fundStockPortfolioResponse = resp as! MFundStockPortfolioResponse
        XCTAssertNotNil(fundStockPortfolioResponse.records)
        var resultJSON : JSON = [:]
        var i = 1
        for items in fundStockPortfolioResponse.records{
            if let item: NSDictionary = items as! NSDictionary{
            var itemJSON: JSON = [
                "ENDDATE":item["ENDDATE"]!,
                "FDSNAME":item["FDSNAME"]!,
                "HOLDVOL":item["HOLDVOL"]!,
                "ACCTFORNAV":item["ACCTFORNAV"]!,
                "HOLDVALUE":item["HOLDVALUE"]!,
            ]
                resultJSON["\(i)"] = itemJSON
            i=i+1
            }
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

