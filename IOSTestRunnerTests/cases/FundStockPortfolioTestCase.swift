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

class FundStockPortfolioTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.FundStockPortfolioTestCase
    }
   
    func testFundStockPortfolio() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFundStockPortfolioRequest()
        mRequest.code = param["CODE"].stringValue
       
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
  mRequest.sourceType = typeVal
        }
    
        let resp = self.makeSyncRequest(request: mRequest)
        let fundStockPortfolioResponse = resp as! MFundStockPortfolioResponse
        XCTAssertNotNil(fundStockPortfolioResponse.records)
        var resultJSON : JSON = [:]
        for items in fundStockPortfolioResponse.records{
            if let item: NSDictionary = items as! NSDictionary{
            var itemJSON: JSON = [
                "ENDDATE":item["ENDDATE"]!,
                "FDSNAME":item["FDSNAME"]!,
                "HOLDVOL":item["HOLDVOL"]!,
                "ACCTFORNAV":item["ACCTFORNAV"]!,
                "HOLDVALUE":item["HOLDVALUE"]!,
            ]
                resultJSON["\(item["ENDDATE"]!)"] = itemJSON
            
            }
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

