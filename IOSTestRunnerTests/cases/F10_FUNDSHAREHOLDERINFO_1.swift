//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//最新基金持股
import XCTest
import os.log
import SwiftyJSON

class F10_FUNDSHAREHOLDERINFO_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_FUNDSHAREHOLDERINFO_1
    }
    
    func testFundShareHolderInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFundShareHolderInfoRequest()
        mRequest.code = param["CODE"].stringValue
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let fundShareHolderInfoResponse = resp as! MFundShareHolderInfoResponse
        XCTAssertNotNil(fundShareHolderInfoResponse.records)
        var resultJSON: JSON = [
            "COUNT_": fundShareHolderInfoResponse.count,
            "ENDDATE_": fundShareHolderInfoResponse.endDate
        ]
        var i = 1
        for records in fundShareHolderInfoResponse.records{
            if let list: NSDictionary = records as! NSDictionary{
                
                var jsonarr2: JSON = [
                    "CHINAMEABBR_": list["CHINAMEABBR"]!,
                    "PCTTOTALESHARE_": list["PCTTOTALESHARE"]!,
                    "HOLDINGVOL_": list["HOLDINGVOL"]!
                ]
                resultJSON["\(i)"] = jsonarr2
                i=i+1
            }
        }
            
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        
    
}

