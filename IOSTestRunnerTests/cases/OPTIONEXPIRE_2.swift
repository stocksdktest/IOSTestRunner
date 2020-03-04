//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//期权-交割月列表v2
import XCTest
import os.log
import SwiftyJSON

class OPTIONEXPIRE_2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OPTIONEXPIRE_2
    }
    
    func testExpireMonth() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MExpireMonthRequest()
        mRequest.stockID = param["CODE"].stringValue
                mRequest.isV2 = param["adjusted"].boolValue
             
                let resp = self.makeSyncRequest(request: mRequest)
                let expireMonthResponse = resp as! MExpireMonthResponse
        //        XCTAssertNotNil(expireMonthResponse.expireMonths)
                
                if param["ISV2"].boolValue == false{
                    var resultJSON: JSON = [
                        "list": expireMonthResponse.expireMonths
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }else if param["ISV2"].boolValue == true{
                    var v2ExpireMonthsJSON : JSON = [:]
                    var i = 1
                    
                    for v2ExpireMonths in expireMonthResponse.v2ExpireMonths{
                        var itemJSON: JSON = [
                            "time": v2ExpireMonths.time,
                            "day": v2ExpireMonths.day
                        ]
                        v2ExpireMonthsJSON["\(i)"] = itemJSON
                        i=i+1
                    }
                    var resultJSON : JSON = [
                        "list":v2ExpireMonthsJSON
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
                    
                
                
            }
        }
