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

class OFFERQUOTE_2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OFFERQUOTE_2
    }
    //MAddValueItem
    func testOfferQuoteList() {
        let param = self.testCaseRoundConfig.getParam()
         let mRequest = MOfferQuoteListRequest()
        
        
        mRequest.pageSize = param["PAGESIZE"].intValue
        mRequest.pageIndex = param["PAGEINDEX"].intValue
        if param["ASCENDING"].stringValue == "0"{
            mRequest.ascending = ("1" as NSString).boolValue
        }else if param["ASCENDING"].stringValue == "1"{
            mRequest.ascending = ("0" as NSString).boolValue
        }
        if let fieldVal = MOfferQuoteListField.init(rawValue: param["FIELD"].intValue){
            mRequest.field = fieldVal
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let offerQuoteListResponse = resp as! MOfferQuoteResponse
        var resultJSON : JSON = [:]
        var i = 1
        if offerQuoteListResponse.items != nil{
            for item in offerQuoteListResponse.items{
                var itemJSON: JSON = [
                    "code": item.code,
                    "name": item.name,
                    "offerId": item.offerID,
                    "offerName": item.offerName,
                    "price": item.price,
                    "startDate": item.startDate,
                    "endDate": item.endDate
                ]
                resultJSON["\(i)"] = itemJSON
                i=i+1
            }
        }
        
        
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

