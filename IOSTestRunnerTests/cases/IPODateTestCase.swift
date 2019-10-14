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

class IPODateTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.IPODateTestCase
    }
    
    func testIPODate() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MIPODateRequest()
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
            }
        
        if let typeVal = MIPOType.init(rawValue:param["TYPE"].uIntValue) {
            mRequest.type = typeVal
            }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let iPODateResponse = resp as! MIPODateResponse
        XCTAssertNotNil(iPODateResponse.infos)
        switch mRequest.type{
            
        case .stock:
            for items in iPODateResponse.infos{
                if let item: NSDictionary = items as! NSDictionary{
                    var resultJSON: JSON = [
                        "sg":item["sg"]!,
                        "zq":item["zq"]!,
                        "ss":item["ss"]!,
                        "jjfx":item["jjfx"]!,
                        "wss":item["wss"]!,
                        "normalDay":item["NORMALDAY"]!,
                        ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
            }
        case .bond:
            for items in iPODateResponse.infos{
                if let item: NSDictionary = items as! NSDictionary{
                    var resultJSON: JSON = [
                        "sg":item["sg"]!,
                        "jjsg":item["jjsg"]!,
                        "dss":item["dss"]!,
                        "NORMALDAY":item["NORMALDAY"]!,
                        ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
            }
           
        }
    
   }
}
