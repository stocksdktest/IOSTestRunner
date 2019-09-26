////
////  ExampleTestCase2.swift
////  IOSTestRunnerTests
////
////  Created by liao xiangsen on 2019/8/27.
////  Copyright © 2019年 liao xiangsen. All rights reserved.
////
////要约申购列表
import XCTest
import os.log
import SwiftyJSON

class OfferQuoteListTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OfferQuoteListTestCase
    }
    //MAddValueItem
    func testOfferQuoteList() {
        let param = self.testCaseRoundConfig.getParam()
         let mRequest = MOfferQuoteListRequest()
        
        
        mRequest.pageSize = param["PAGESIZE"].intValue
        mRequest.pageIndex = param["PAGEINDEX"].intValue
        mRequest.ascending = param["ASCENDING"].boolValue
        if let fieldVal = MOfferQuoteListField.init(rawValue: param["FIELD"].intValue){
            mRequest.field = fieldVal
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let offerQuoteListResponse = resp as! MOfferQuoteResponse
        XCTAssertNotNil(offerQuoteListResponse.items)
        for item in offerQuoteListResponse.items{
            var resultJSON: JSON = [
                "code": item.code,
                "name": item.name,
                "offerId": item.offerID,
                "offerName": item.offerName,
                "price": item.price,
                "startDate": item.startDate,
                "endDate": item.endDate
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    }
}

