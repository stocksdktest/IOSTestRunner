//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//管理层
import XCTest
import os.log
import SwiftyJSON

class F10_LEADERPERSONINFO_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_LEADERPERSONINFO_1
    }
    
    func testLeaderPersonInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MLeaderPersonInfoRequest()
        mRequest.code = param["CODE"].stringValue
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        
        let resp = self.makeSyncRequest(request: mRequest)
        let leaderPersonInfoResponse = resp as! MLeaderPersonInfoResponse
        XCTAssertNotNil(leaderPersonInfoResponse.records)
        switch mRequest.sourceType{
            
        case .GA:
            var resultJSON : JSON = [:]
            for records in leaderPersonInfoResponse.records{
                if let record: NSDictionary = records as! NSDictionary{
                    var itemJSON: JSON = [
                        "POSITIONNAME": record["POSITIONNAME"]!,
                        "LEADERNAME": record["LEADERNAME"]!,
                        "AGE": record["AGE"]!,
                        "GENDER": record["GENDER"]!,
                        "EDUCATION": record["EDUCATION"]
                    ]
                    resultJSON["\(record["LEADERNAME"]!)"] = itemJSON
                }
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        case .CH:
            var resultJSON : JSON = [:]
            for records in leaderPersonInfoResponse.records{
                if let record: NSDictionary = records as! NSDictionary{
                    var itemJSON: JSON = [
                        "DUTY": record["DUTY"]!,
                        "LEADERNAME": record["LEADERNAME"]!,
                        "DUTYTYPE": record["DUTYTYPE"]!,
                        "BEGINDATE": record["BEGINDATE"]!
                    ]
                    resultJSON["\(record["LEADERNAME"]!)"] = itemJSON
                    
                }
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        }
        
        
    }
}

