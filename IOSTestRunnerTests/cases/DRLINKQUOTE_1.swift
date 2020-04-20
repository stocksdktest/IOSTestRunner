//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//沪伦通联动接口
import XCTest
import os.log
import SwiftyJSON

class DRLINKQUOTE_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.DRLINKQUOTE_1
    }
    
    func testDRlink() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MDRLinkRequest()
        mRequest.code = param["CODE"].stringValue
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let dRLinkResponse = resp as! MDRLinkResponse
//        XCTAssertNotNil(dRLinkResponse)
        var resultJSON: JSON = [
                "code":dRLinkResponse.code,
                "name":dRLinkResponse.name,
                "subType":dRLinkResponse.subtype,
                "lastPrice":dRLinkResponse.lastPrice,
                "preClosePrice":dRLinkResponse.preClosePrice,
                "changeRate":dRLinkResponse.changeRate,
                "change":dRLinkResponse.change,
                "dateTime":dRLinkResponse.datetime,
                "premium":dRLinkResponse.premiumRate,
            ]
            
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
    
}
