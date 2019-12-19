//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//次新债
import XCTest
import os.log
import SwiftyJSON

class SubnewBondRankingTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.SubnewBondRankingTestCase
    }
    //MAddValueItem
    func testSubnewBondRanking() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MSubnewBondRankingRequest()
        mRequest.pageIndex = param["PAGEINDEX"].intValue
        mRequest.pageSize  = param["PAGESIZE"].intValue
        mRequest.ascending = param["ASCENDING"].boolValue
        if let typeVal = MSubnewBondRankingField.init(rawValue:param["FIEID"].intValue) {
                        mRequest.field = typeVal
                   }
        
        
        let resp = self.makeSyncRequest(request: mRequest)
        let subnewBondRankingResponse = resp as! MSubnewBondRankingResponse
        XCTAssertNotNil(subnewBondRankingResponse.items)
        var resultJSON : JSON = [:]
        for items in subnewBondRankingResponse.items{
        var itemJSON: JSON = [
                "code":items.code,
                "name":items.name,
                "lastestPrice":items.lastPrice,
                "originalPrice":items.ipoPrice,
                "originalData":items.ipoDate,
                "subType":items.subtype,
                "preClosePrice":items.preClosePrice,
                "rate":items.rate,
                "allRate":items.totalRate,
            ]
            resultJSON["\(items.code!)"] = itemJSON
            
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

