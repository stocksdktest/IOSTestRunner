//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//基金概况
import XCTest
import os.log
import SwiftyJSON

class F10_FUNDBASIC_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_FUNDBASIC_1
    }
    
    func testFundBasicInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFundBasicInfoRequest()
        mRequest.code = param["CODE"].stringValue
        
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let fundBasicInfoResponse = resp as! MFundBasicInfoResponse
        XCTAssertNotNil(fundBasicInfoResponse.record)
        if let item = fundBasicInfoResponse.record{
            var resultJSON: JSON = [
                "FDNAME":item["FDNAME"]!,
                "FDSNAME":item["FDSNAME"]!,
                "FSYMBOL":item["FSYMBOL"]!,
                "FDTYPE":item["FDTYPE"]!,
                "FOUNDDATE":item["FOUNDDATE"]!,
                "TRUSTEENAME":item["TRUSTEENAME"]!,
                "KEEPERNAME":item["KEEPERNAME"]!,
                "MANAGERNAME":item["MANAGERNAME"]!,
                "FDINVCATEGORY":item["FDINVCATEGORY"]!,
                "INVRULE":item["INVRULE"]!,
            ]
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
            
        }
    }
 }
