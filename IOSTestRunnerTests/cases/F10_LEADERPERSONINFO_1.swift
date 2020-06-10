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
    
    func testLeaderPersonInfo() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MLeaderPersonInfoRequest()
        mRequest.code = param["CODE"].stringValue
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let leaderPersonInfoResponse = resp as! MLeaderPersonInfoResponse
//        XCTAssertNotNil(leaderPersonInfoResponse.records)
        if (leaderPersonInfoResponse.records == nil){
            throw BaseTestError.assertFailedError(message: "leaderPersonInfoResponse records is nil")
        }
        switch mRequest.sourceType{
        case .GA:
            var resultJSON : JSON = [:]
            var i=1
            for records in leaderPersonInfoResponse.records{
                if let record: NSDictionary = records as! NSDictionary{
                    var itemJSON: JSON = [
                        "POSITIONNAME": record["POSITIONNAME"]!,
                        "LEADERNAME": record["LEADERNAME"]!,
                        "AGE": record["AGE"]!,
                        "GENDER": record["GENDER"]!,
                        "EDUCATION": record["EDUCATION"]
                    ]
                    resultJSON["\(i)"] = itemJSON
                    i=i+1
                }
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        case .CH:
            var resultJSON : JSON = [:]
            var i=1
            for records in leaderPersonInfoResponse.records{
                if let record: NSDictionary = records as! NSDictionary{
                    var itemJSON: JSON = [
                        "DUTY": record["DUTY"]!,
                        "LEADERNAME": record["LEADERNAME"]!,
                        "DUTYTYPE": record["DUTYTYPE"]!,
                        "BEGINDATE": record["BEGINDATE"]!
                    ]
                    resultJSON["\(i)"] = itemJSON
                    i=i+1
                }
            }
        case .CLS:
            var resultJSON: JSON = []
            
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
        }
        
        
    }
}

