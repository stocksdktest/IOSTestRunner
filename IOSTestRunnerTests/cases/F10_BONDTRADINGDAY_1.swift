//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//新股（债）上市日期信息
import XCTest
import os.log
import SwiftyJSON

class F10_BONDTRADINGDAY_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_BONDTRADINGDAY_1
    }
    
    func testIPODate() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MIPODateRequest()
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        mRequest.type = MIPOType(rawValue: 1)!
        
        let resp = self.makeSyncRequest(request: mRequest)
        let iPODateResponse = resp as! MIPODateResponse
        XCTAssertNotNil(iPODateResponse.infos)
        switch mRequest.type{
            
        case .stock:
            var resultJSON : JSON = [:]
            for items in iPODateResponse.infos{
                if let item: NSDictionary = items as! NSDictionary{
                    var itemJSON: JSON = [
                        "sg":item["sg"]!,
                        "zq":item["zq"]!,
                        "ss":item["ss"]!,
                        "jjfx":item["jjfx"]!,
                        "wss":item["wss"]!,
                        "normalDay":item["NORMALDAY"]!,
                        ]
                    resultJSON["\(item["NORMALDAY"]!)"] = itemJSON
                    
                }
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        case .bond:
            var resultJSON : JSON = [:]
            for items in iPODateResponse.infos{
                if let item: NSDictionary = items as! NSDictionary{
                    var itemJSON: JSON = [
                        "sg":item["sg"]!,
                        "jjsg":item["jjsg"]!,
                        "dss":item["dss"]!,
                        "NORMALDAY":item["NORMALDAY"]!,
                        ]
                    resultJSON["\(item["NORMALDAY"]!)"] = itemJSON
                    
                }
            }
           print(resultJSON)
           onTestResult(param: param, result: resultJSON)
        }
    
   }
}
