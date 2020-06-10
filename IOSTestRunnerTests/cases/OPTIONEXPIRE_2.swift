//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//期权-交割月列表
import XCTest
import os.log
import SwiftyJSON

class OPTIONEXPIRE_2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OPTIONEXPIRE_2
    }
    
    func testExpireMonth() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MExpireMonthRequest()
        mRequest.stockID = param["CODE"].stringValue
//                mRequest.isV2 = false
//        mRequest.isV2 = param["adjusted"].boolValue
        print("/da*d/*|\(param["adjusted"].boolValue)")
        if param["adjusted"] == "true"{
            mRequest.isV2 = true
        }
        if param["adjusted"] == "false"{
            mRequest.isV2 = false
        }
             
                let resp = try self.makeSyncRequest(request: mRequest)
                let expireMonthResponse = resp as! MExpireMonthResponse
        //        XCTAssertNotNil(expireMonthResponse.expireMonths)
                if (expireMonthResponse.expireMonths == nil){
                    throw BaseTestError.assertFailedError(message: "expireMonthResponse expireMonths is nil")
                }
                if (mRequest.isV2 == true)&&(expireMonthResponse.v2ExpireMonths == nil){
                    throw BaseTestError.assertFailedError(message: "expireMonthResponse v2ExpireMonths is nil")
                }
                if param["ISV2"].boolValue == false{
                    let resultJSON: JSON = [
                        "list": expireMonthResponse.expireMonths
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }else if param["ISV2"].boolValue == true{
                    var v2ExpireMonthsJSON : JSON = [:]
                    var i = 1
                    
                    for v2ExpireMonths in expireMonthResponse.v2ExpireMonths{
                        let itemJSON: JSON = [
                            "time": v2ExpireMonths.time,
                            "day": v2ExpireMonths.day
                        ]
                        v2ExpireMonthsJSON["\(i)"] = itemJSON
                        i=i+1
                    }
                    let resultJSON : JSON = [
                        "list":v2ExpireMonthsJSON
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
                    
                
                
            }
        }
