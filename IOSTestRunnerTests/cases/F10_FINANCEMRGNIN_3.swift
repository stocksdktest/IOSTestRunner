//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//融资融券--沪深个股融资融券接口
import XCTest
import os.log
import SwiftyJSON

class F10_FINANCEMRGNIN_3: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_FINANCEMRGNIN_3
    }
    
    func testMarginInfoShare() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MMarginInfoShareRequest()
        mRequest.code =  param["CODE"].stringValue
        let paramI:NSArray = (param["PARAMS"].string?.split(separator: ",") as! NSArray)
        mRequest.pageSize = Int(paramI[1] as! String)!
        mRequest.pageIndex = Int(paramI[0] as! String)!
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        if let val = param["OPTIONS"].string{
            mRequest.options = val
        }
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let marginInfoShareResponse = resp as! MMarginInfoShareResponse
//        XCTAssertNotNil(marginInfoShareResponse.jsonObject)
        if (marginInfoShareResponse.jsonObject == nil){
            throw BaseTestError.assertFailedError(message: "marginInfoShareResponse jsonObject is nil")
        }
            let keys:NSArray = param["OPTIONS"].string?.split(separator: ",")as! NSArray
        if keys.count != 0{
            if let dic1:NSDictionary = marginInfoShareResponse.jsonObject as!NSDictionary{
                var resultJSON: JSON = [:]
                if let lists:NSArray = dic1["List"] as! NSArray{
                    var j = 1
                    for list in lists{
                        let dic2:NSDictionary = list as! NSDictionary
                        
                        var jsonarr2: JSON = [:]
                        if keys.count > 0{
                            for i in 0 ..< keys.count{
                                var keyVal:String = keys[i] as! String
                                jsonarr2[keyVal].string = dic2[keys[i]] as! String
                                
                            }
                            resultJSON["\(j)"] = jsonarr2
                            j = j + 1
                        }
                        
                    }
                    
                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }else{
            if let dic1:NSDictionary = marginInfoShareResponse.jsonObject as!NSDictionary{
                var resultJSON: JSON = [:]
                if let lists:NSArray = dic1["List"] as! NSArray{
                    var j = 1
                    for list in lists{
                        let dic2:NSDictionary = list as! NSDictionary
                        var jsonarr2: JSON = [
                            "TRADEDATE": dic2["TRADEDATE"]!,
                            "TRADING": dic2["TRADING"]!,
                            "FINBALANCE": dic2["FINBALANCE"]!,
                            "FINBUYAMT": dic2["FINBUYAMT"]!,
                            "FINREPAYAMT": dic2["FINREPAYAMT"]!,
                            "FINROEBUY": dic2["FINROEBUY"]!,
                            "MRGGBAL": dic2["MRGGBAL"]!,
                            "MRGNRESQTY": dic2["MRGNRESQTY"]!,
                            "MRGNSELLAMT": dic2["MRGNSELLAMT"]!,
                            "MRGNREPAYAMT": dic2["MRGNREPAYAMT"]!,
                            "MRGNROESELL": dic2["MRGNROESELL"]!,
                            "FINMRGHBAL": dic2["FINMRGHBAL"]!,
                            "FINMRGNBAL": dic2["FINMRGNBAL"]!
                        ]
                        resultJSON["\(j)"] = jsonarr2
                        j = j + 1
                    }
                    
                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
            
            
        }
        
    }
}


