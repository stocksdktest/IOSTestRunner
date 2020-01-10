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

class AHLIST_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.AHLIST_1
    }
    
    func testAHQuoteList() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MAHQuoteListRequest()
        
        let paramI:NSArray = (param["param"].string?.split(separator: ",") as! NSArray)
        mRequest.endIndex = Int(paramI[1] as! String)!
        mRequest.beginIndex = Int(paramI[0] as! String)!
        if paramI[3] as! String == "0"{
            mRequest.ascending = ("1" as NSString).boolValue
        }else if paramI[3] as! String == "1"{
            mRequest.ascending = ("0" as NSString).boolValue
        }
        
        mRequest.field = MAHQuoteListField.init(rawValue: Int(paramI[2] as! String)!)!
        
        let resp = self.makeSyncRequest(request: mRequest)
        let AHQuoteListResponse = resp as! MAHQuoteListResponse
        XCTAssertNotNil(AHQuoteListResponse.ahItems)
        var resultJSON : JSON = [:]
        var i = 1
        for item in AHQuoteListResponse.ahItems{
            let itemJSON:JSON = [
                "name" : item.name,
                "codeA": item.codeA,
                "lastPriceA": item.lastPriceA,
                "preClosePriceA": item.preClosePriceA,
                "datetimeA": item.datetimeA,
                "codeH": item.codeH,
                "lastPriceH": item.lastPriceH,
                "preClosePriceH": item.preClosePriceH,
                "datetimeH": item.datetimeH,
                "premiumAH": item.premiumRate,
                "changeRateA": item.changeRateA,
                "changeRateH": item.changeRateH
            ]
            resultJSON["\(i)"] = itemJSON
            i=i+1
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
    
}
