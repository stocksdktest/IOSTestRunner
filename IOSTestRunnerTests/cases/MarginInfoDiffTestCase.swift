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

class MarginInfoDiffTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.MarginInfoDiffTestCase
    }
    
    func testMarginInfoDiff() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MMarginInfoDiffRequest()
        mRequest.market =  param["MARKET"].stringValue
        mRequest.pageIndex = param["PAGEINDEX"].intValue
        mRequest.pageSize = param["PAGESIZE"].intValue
        
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
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
                    var jsonarr1 = [JSON]()
                    for list in lists{
                        let dic2:NSDictionary = list as! NSDictionary
                        let key0: String = keys[0] as! String
                        var jsonarr2: JSON = [
                            key0: dic2[keys[0]]
                        ]
                        if keys.count > 1{
                            for i in 1 ..< keys.count{
                                var keyVal:String = keys[i] as! String
                                jsonarr2[keyVal].string = dic2[keys[i]] as! String
                                jsonarr1.append(jsonarr2)
                            }
                        }
                        
                    }
                    
                    
                    
                    resultJSON["list"].arrayObject = jsonarr1
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
                    var jsonarr1 = [JSON]()
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
                            jsonarr1.append(jsonarr2)
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
                    resultJSON["list"].arrayObject = jsonarr1
                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
            
            
        }
        
    }
}

