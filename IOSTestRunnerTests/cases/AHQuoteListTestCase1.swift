//
//  File.swift
//  IOSTestRunnerTests
//
//  Created by 俞建斌 on 2019/9/5.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class AHQuoteListTestCase1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.AHQuoteListTestCase1
    }
    
    func testAHQuoteList() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MAHQuoteListRequest()
        mRequest.pageSize = param["PAGE_SIZE"].intValue
        mRequest.pageIndex = param["PAGE_INDEX"].intValue
        mRequest.ascending = param["ASC?"].boolValue
        if let fieldVal = MAHQuoteListField.init(rawValue: param["FIELD"].intValue) {
            mRequest.field = fieldVal
        }
     
        //        mRequest.stockFields = ["-1"]
        let resp = self.makeSyncRequest(request: mRequest)
        let AHQuoteListResponse = resp as! MAHQuoteListResponse
        XCTAssertNotNil(AHQuoteListResponse.ahItems)
        var resultJSON : JSON = [:]
        for item in AHQuoteListResponse.ahItems{
            var itemJSON:JSON = [
                "name" : item.name,
                "codeA": item.codeA,
                "lastPriceA": item.lastPriceA,
                "preClosePrice": item.preClosePriceA,
                "dateTimeA": item.datetimeA,
                "codeH": item.codeH,
                "lastPriceH": item.lastPriceH,
                "preClosePriceH": item.preClosePriceH,
                "dateTimeH": item.datetimeH,
                "premiumAH": item.premiumRate,
                "changeRateA": item.changeRateA,
                "changeRateH": item.changeRateH
            ]
            resultJSON["\(item.datetimeA!)"] = itemJSON
            
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
    
}
