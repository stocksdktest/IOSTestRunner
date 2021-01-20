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

class ABQUOTELISTTEST_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.ABQUOTELISTTEST_1
    }
    
    func testABQuoteList() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MABQuoteListRequest()
        
        let paramI:NSArray = (param["PARAMS"].string?.split(separator: ",") as! NSArray)
        mRequest.pageSize = Int(paramI[1] as! String)!
        mRequest.pageIndex = Int(paramI[0] as! String)!
        
        if paramI[3] as! String == "0"{
            mRequest.ascending = ("1" as NSString).boolValue
        }else if paramI[3] as! String == "1"{
            mRequest.ascending = ("0" as NSString).boolValue
        }
        
        mRequest.field = MABQuoteListField.init(rawValue: Int(paramI[2] as! String)!)!
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let ABQuoteListResponse = resp as! MABQuoteListResponse
//        XCTAssertNotNil(AHQuoteListResponse.ahItems)
        if (ABQuoteListResponse.items == nil){
            throw BaseTestError.assertFailedError(message: "ABQuoteListResponse ahItems is nil")
        }
        var resultJSON : JSON = [:]
        var i = 1
        for item in ABQuoteListResponse.items{
            var itemJSON:JSON = [
                "codeA" : item.codeA,
                "nameA": item.nameA,
                "subtypeA": item.subtypeA,
                "lastPriceA": item.lastPriceA,
                "changeRateA": item.changeRateA,
                "codeB": item.codeB,
                "nameB": item.nameB,
                
            ]
            let update1: JSON = [
                "subtypeB": item.subtypeB,
                "lastPriceB": item.lastPriceB,
                "changeRateB": item.changeRateB,
                "premiumRateAB": item.premiumRateAB,
                "premiumRateBA": item.premiumRateBA,
                "changeA": item.changeA,
                "changeB": item.changeB,
            ]
            do {
                try itemJSON.merge(with: update1)
            } catch {
                // ignore
            }
            resultJSON["\(item.codeA ?? "empty_\(i)")"] = itemJSON
            i=i+1
        }
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
    
}
