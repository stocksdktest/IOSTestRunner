//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//行业组合
import XCTest
import os.log
import SwiftyJSON

class FundIndustryPortfolioTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.FundIndustryPortfolioTestCase
    }
    
    func testFundIndustryPortfolio() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFundIndustryPortfolioRequest()
        mRequest.code = param["CODE"].stringValue
        
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let fundIndustryPortfolioResponse = resp as! MFundIndustryPortfolioResponse
        XCTAssertNotNil(fundIndustryPortfolioResponse.records)
        for items in fundIndustryPortfolioResponse.records{
            if let item: NSDictionary = items as! NSDictionary{
                var resultJSON: JSON = [
                    "ENDDATE":item["ENDDATE"]!,
                    "INDUSTRYNAME":item["INDUSTRYNAME"]!,
                    "FAIRVALUE":item["FAIRVALUE"]!,
                    "NAVRATIO":item["NAVRATIO"]!,
                ]
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
    }
}


