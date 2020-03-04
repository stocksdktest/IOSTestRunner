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

class OPTIONEXPIRE_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.OPTIONEXPIRE_1
    }
    
    func testExpireMonth() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MExpireMonthRequest()
        mRequest.stockID = param["CODE"].stringValue
                mRequest.isV2 = param["ISV2"].boolValue
             
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
                    let v2ExpireMonths = expireMonthResponse.v2ExpireMonths as! MExpireMonthItem
                    var resultJSON: JSON = [
                        "time": v2ExpireMonths.time,
                        "day": v2ExpireMonths.day
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
                    
                
                
            }
        }
