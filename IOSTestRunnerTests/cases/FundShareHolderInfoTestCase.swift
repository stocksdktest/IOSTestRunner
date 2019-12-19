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

class FundShareHolderInfoTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.FundShareHolderInfoTestCase
    }
    
    func testFundShareHolderInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFundShareHolderInfoRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let fundShareHolderInfoResponse = resp as! MFundShareHolderInfoResponse
        XCTAssertNotNil(fundShareHolderInfoResponse.records)
        var resultJSON: JSON = [
            "COUNT_": fundShareHolderInfoResponse.count,
            "ENDDATE_": fundShareHolderInfoResponse.endDate
        ]
        var jsonarr1 : JSON = [:]
        for records in fundShareHolderInfoResponse.records{
            if let list: NSDictionary = records as! NSDictionary{
                
                            var jsonarr2: JSON = [
                                "CHINAMEABBR_": list["CHINAMEABBR"]!,
                                "PCTTOTALESHARE_": list["PCTTOTALESHARE"]!,
                                "HOLDINGVOL_": list["HOLDINGVOL"]!
                            ]
                            jsonarr1["\(list["CHINAMEABBR"]!)"] = jsonarr2
                
            }
        }
                    resultJSON["list"] = jsonarr1
            
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        
    
}

