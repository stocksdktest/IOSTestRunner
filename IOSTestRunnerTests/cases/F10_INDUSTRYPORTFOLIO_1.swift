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

class F10_INDUSTRYPORTFOLIO_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_INDUSTRYPORTFOLIO_1
    }
    
    func testFundIndustryPortfolio() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFundIndustryPortfolioRequest()
        mRequest.code = param["CODE"].stringValue
        
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let fundIndustryPortfolioResponse = resp as! MFundIndustryPortfolioResponse
        XCTAssertNotNil(fundIndustryPortfolioResponse.records)
        var resultJSON : JSON = [:]
        for items in fundIndustryPortfolioResponse.records{
            if let item: NSDictionary = items as! NSDictionary{
                var itemJSON: JSON = [
                    "ENDDATE":item["ENDDATE"]!,
                    "INDUSTRYNAME":item["INDUSTRYNAME"]!,
                    "FAIRVALUE":item["FAIRVALUE"]!,
                    "NAVRATIO":item["NAVRATIO"]!,
                ]
                resultJSON["\(item["ENDDATE"]!)"] = itemJSON
                
            }
            
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}


