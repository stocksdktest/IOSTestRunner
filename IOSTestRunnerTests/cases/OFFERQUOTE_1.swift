////
////  ExampleTestCase2.swift
////  IOSTestRunnerTests
////
////  Created by liao xiangsen on 2019/8/27.
////  Copyright © 2019年 liao xiangsen. All rights reserved.
////
////要约申购
import XCTest
import os.log
import SwiftyJSON

class OFFERQUOTE_1: BaseTestCase {

    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OFFERQUOTE_1
    }

    func testOfferQuote() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MOfferQuoteRequest()
        mRequest.code = param["CODE"].stringValue

        let resp = self.makeSyncRequest(request: mRequest)
        let offerQuoteResponse = resp as! MOfferQuoteResponse
        var resultJSON : JSON = [:]
        
        if offerQuoteResponse.items != nil{
            for item in offerQuoteResponse.items{
                var itemJSON: JSON = [
                    "code": item.code,
                    "name": item.name,
                    "offerId": item.offerID,
                    "offerName": item.offerName,
                    "price": item.price,
                    "startDate": item.startDate,
                    "endDate": item.endDate
                ]
                resultJSON["\(item.offerID!)"] = itemJSON
                
            }
        }
        
        
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

