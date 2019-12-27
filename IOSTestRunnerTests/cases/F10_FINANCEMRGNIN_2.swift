//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//融资融券--融资融券差额接口(最近90天)
import XCTest
import os.log
import SwiftyJSON

class F10_FINANCEMRGNIN_2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_FINANCEMRGNIN_2
    }
    
    func testMarginInfoDiff() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MMarginInfoDiffRequest()
        mRequest.market =  param["MARKET"].stringValue
        let paramI:NSArray = (param["param"].string?.split(separator: ",") as! NSArray)
        mRequest.pageSize = Int(paramI[1] as! String)!
        mRequest.pageIndex = Int(paramI[0] as! String)!
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        
        if let val = param["OPTIONS"].string{
            mRequest.options = val
        }
        
        let resp = self.makeSyncRequest(request: mRequest)
        let marginInfoDiffResponse = resp as! MMarginInfoDiffResponse
        XCTAssertNotNil(marginInfoDiffResponse.jsonObject)
        
        let keys:NSArray = param["OPTIONS"].string?.split(separator: ",")as! NSArray
        if keys.count != 0{
            if let dic1:NSDictionary = marginInfoDiffResponse.jsonObject as!NSDictionary{
                var resultJSON: JSON = [
                    "pageNumber": dic1["PageNumber"]!,
                    "page": dic1["Page"]!
                ]
                if let lists:NSArray = dic1["List"] as! NSArray{
                    
                    var j = 1
                    for list in lists{
                        let dic2:NSDictionary = list as! NSDictionary
                        
                        var jsonarr2: JSON = [:]
                        if keys.count != 0{
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
            if let dic1:NSDictionary = marginInfoDiffResponse.jsonObject as!NSDictionary{
                var resultJSON: JSON = [
                    "pageNumber": dic1["PageNumber"]!,
                    "page": dic1["Page"]!
                ]
                if let lists:NSArray = dic1["List"] as! NSArray{
                    var j = 1
                    for list in lists{
                        let dic2:NSDictionary = list as! NSDictionary
                        var jsonarr2: JSON = [
                            "TRADEDATE": dic2["TRADEDATE"]!,
                            "FINBALANCESUM": dic2["FINBALANCESUM"]!,
                            "FINBUYAMTSUM": dic2["FINBUYAMTSUM"]!,
                            "FINREPAYAMTSUM": dic2["FINREPAYAMTSUM"]!,
                            "MRGGBALSUM": dic2["MRGGBALSUM"]!,
                            "FINMRGHBALSUM": dic2["FINMRGHBALSUM"]!,
                            "FINMRGNBALSUM": dic2["FINMRGNBALSUM"]!
                        ]
                            resultJSON["\(j)"] = jsonarr2
                        j = j + 1
                        }
                     
                    
                    
                    //                        var jsonarr2: JSON = [
                    //                            "TRADEDATE": dic2["TRADEDATE"]!,
                    //                            "FINBALANCESUM": dic2["FINBALANCESUM"]!,
                    //                            "FINBUYAMTSUM": dic2["FINREPAYAMTSUM"]!,
                    //                            "MRGGBALSUM": dic2["MRGGBALSUM"]!,
                    //                            "FINMRGHBALSUM": dic2["FINMRGHBALSUM"]!,
                    //                            "FINMRGNBALSUM": dic2["FINMRGNBALSUM"]!
                    //                        ]
                    //                        jsonarr1.append(jsonarr2)
                    //                    }
                    //                }
                   
                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
            
            
        }
        
    }
}

