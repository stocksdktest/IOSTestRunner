//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//次新股
import XCTest
import os.log
import SwiftyJSON

class SubnewStockRankingTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.SubnewStockRankingTestCase
    }

    func testSubnewStockRanking() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MSubnewStockRankingRequest()
        mRequest.pageIndex = param["PAGEINDEX"].intValue
        mRequest.pageSize  = param["PAGESIZE"].intValue
        mRequest.ascending = param["ASCENDING"].boolValue
        if let typeVal = MSubnewStockRankingField.init(rawValue:param["FIEID"].intValue) {
            mRequest.field = typeVal
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let subnewStockRankingResponse = resp as! MSubnewStockRankingResponse
        XCTAssertNotNil(subnewStockRankingResponse.items)
        for items in subnewStockRankingResponse.items{
        var resultJSON: JSON = [
                "code":items.code,
                "name":items.name,
                "lastestPrice":items.lastPrice,
                "originalPrice":items.ipoPrice,
                "originalData":items.ipoDate,
                "continuousLimitedDays":items.continuousLimitUpDays,
                "preClosePrice":items.preClosePrice,
                "rate":items.rate,
                "allRate":items.totalRate,
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
}
