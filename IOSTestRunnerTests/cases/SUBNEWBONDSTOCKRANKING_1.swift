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

class SUBNEWBONDSTOCKRANKING_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.SUBNEWBONDSTOCKRANKING_1
    }
    //MAddValueItem
    func testSubnewBondRanking() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MSubnewBondRankingRequest()
        let paramI:NSArray = (param["param"].string?.split(separator: ",") as! NSArray)
        mRequest.pageSize = Int(paramI[1] as! String)!
        mRequest.pageIndex = Int(paramI[0] as! String)!
        if paramI[3] as! String == "0"{
            mRequest.ascending = ("1" as NSString).boolValue
        }else if paramI[3] as! String == "1"{
            mRequest.ascending = ("0" as NSString).boolValue
        }
        mRequest.field = MSubnewBondRankingField.init(rawValue: Int(paramI[2] as! String)!)!
        
        
        let resp = self.makeSyncRequest(request: mRequest)
        let subnewBondRankingResponse = resp as! MSubnewBondRankingResponse
        XCTAssertNotNil(subnewBondRankingResponse.items)
        var resultJSON : JSON = [:]
        var i = 1
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
            resultJSON["\(i)"] = itemJSON
            i=i+1
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}
