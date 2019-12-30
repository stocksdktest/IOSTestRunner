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

class SUBNEWSTOCKRANKING_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.SUBNEWSTOCKRANKING_1
    }

    func testSubnewStockRanking() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MSubnewStockRankingRequest()
        let paramI:NSArray = (param["param"].string?.split(separator: ",") as! NSArray)
        mRequest.pageSize = Int(paramI[1] as! String)!
        mRequest.pageIndex = Int(paramI[0] as! String)!
        if paramI[3] as! String == "0"{
            mRequest.ascending = ("1" as NSString).boolValue
        }else if paramI[3] as! String == "1"{
            mRequest.ascending = ("0" as NSString).boolValue
        }
        mRequest.field = MSubnewStockRankingField.init(rawValue: Int(paramI[2] as! String)!)!
        
        let resp = self.makeSyncRequest(request: mRequest)
        let subnewStockRankingResponse = resp as! MSubnewStockRankingResponse
        XCTAssertNotNil(subnewStockRankingResponse.items)
        var resultJSON : JSON = [:]
        var i = 1
        for items in subnewStockRankingResponse.items{
        var itemJSON: JSON = [
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
            resultJSON["\(i)"] = itemJSON
            i=i+1
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}
