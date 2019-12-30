//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//港股价差数据接口
import XCTest
import os.log
import SwiftyJSON

class HKPRICEINFO_1: BaseTestCase {
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.HKPRICEINFO_1
    }
    
    func testHKPriceDiff() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MHKPriceDiffRequest()
        
        let resp = self.makeSyncRequest(request: mRequest)
        let hKPriceDiffResponse = resp as! MHKPriceDiffResponse
        XCTAssertNotNil(hKPriceDiffResponse)
        if let hkPriceDiffs = hKPriceDiffResponse.hkPriceDiffs{
            var resultJSON : JSON = [:]
            var i = 1
            for hkPriceDiff in hkPriceDiffs{
                if let arr1:NSArray = hkPriceDiff.value as! NSArray{
                    for arr2 in arr1{
                        if let arr3:NSArray = arr2 as! NSArray{
                            var jsonarr1: JSON = [
                                "upLimt": arr3[0],
                                "lowLimit": arr3[1],
                                "priceDifference": arr3[2]
                            ]
                            resultJSON["\(i)"] = jsonarr1
                            i = i + 1
                        }
                        
                    }
                    
                }
            }
            
        
        
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
        }
    }
   
}
    

        



