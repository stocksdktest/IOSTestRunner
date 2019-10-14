//
//  BlockTradeTestCase.swift
//  IOSTestRunnerTests
//
//  Created by 俞建斌 on 2019/9/25.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class BlockTradeTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.BlockTradeTestCase
    }
    func testF10() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MF10Request()
        mRequest.code = param["CODE"].stringValue
        mRequest.requestType = param["REQUESTTYPE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        if param["PARAM"].dictionary != nil{
            mRequest.param = param["PARAM"].dictionary
            
        }
        
        
        let resp = self.makeSyncRequest(request: mRequest)
        let f10Response = resp as! MF10Response
        XCTAssertNotNil(f10Response.jsonObject)
        //        print(f10Response.jsonObject)
        
        if mRequest.requestType == "blocktrade"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                var jsonarr1 = [JSON]()
                for List in Lists{
                    if let dic2 : NSDictionary = List as! NSDictionary{
                        var jsonarr2: JSON = [
                            "TRADEDATE":dic2["TRADEDATE"]!,
                            "TRADEPRICE":dic2["TRADEPRICE"]!,
                            "VOLUME":dic2["VOLUME"]!,
                            "AMOUNT":dic2["AMOUNT"]!,
                            "PRC":dic2["PRC"]!,
                            "BUYERNAME":dic2["BUYERNAME"]!,
                            "SELLERNAME":dic2["SELLERNAME"]!,
                        ]
                        jsonarr1.append(jsonarr2)
                    }
                }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "iinvholdchg"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                var jsonarr1 = [JSON]()
                for List in Lists{
                    if let dic2 : NSDictionary = List as! NSDictionary{
                        var jsonarr2: JSON = [
                            "REPORTDATE":dic2["REPORTDATE"]!,
                            "TRADING":dic2["TRADING"]!,
                            "SESNAME":dic2["SESNAME"]!,
                            "SETYPENAME":dic2["SETYPENAME"]!,
                            "HOLDQTY":dic2["HOLDQTY"]!,
                            "HOLDAMT":dic2["HOLDAMT"]!,
                            "HOLDQTYSUMCHG":dic2["HOLDQTYSUMCHG"]!,
                        ]
                        jsonarr1.append(jsonarr2)
                    }
                }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "importnoticedate"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                var jsonarr1 = [JSON]()
                for List in Lists{
                    if let dic2 : NSDictionary = List as! NSDictionary{
                        var jsonarr2: JSON = [
                            "REPTITLE":dic2["REPTITLE"]!,
                            "TRADEDATE":dic2["TRADEDATE"]!,
                            "TEXT":dic2["TEXT"]!
                            
                        ]
                        jsonarr1.append(jsonarr2)
                    }
                }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "importnoticetitlbe"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                var jsonarr1 = [JSON]()
                for List in Lists{
                    if let dic2 : NSDictionary = List as! NSDictionary{
                        var jsonarr2: JSON = [
                            "REPTITLE":dic2["REPTITLE"]!,
                            "TRADEDATE":dic2["TRADEDATE"]!,
                            "TEXT":dic2["TEXT"]!
                        ]
                        jsonarr1.append(jsonarr2)
                    }
                }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "exptperformance"{
            if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                
                if let Lists: NSArray = dic1["List"] as!NSArray{
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "SESNAME":dic2["SESNAME"]!,
                                "PUBLISHDATE":dic2["PUBLISHDATE"]!,
                                "RETAMAXPROFITSMK":dic2["RETAMAXPROFITSMK"]!,
                                "RETAMAXPROFITSINC":dic2["RETAMAXPROFITSINC"]!
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                    var resultJSON: JSON = [
                        "list": jsonarr1
                    ]
                    
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
                
            }
        }
        if mRequest.requestType == "proindicdata"{
            if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                
                if let Lists: NSArray = dic1["List"] as!NSArray{
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "SESNAME":dic2["SESNAME"]!,
                                "PUBLISHDATE":dic2["PUBLISHDATE"]!,
                                "EPSBASIC":dic2["EPSBASIC"]!,
                                "TAGRT":dic2["TAGRT"]!,
                                "NPGRT":dic2["NPGRT"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                    var resultJSON: JSON = [
                        "list": jsonarr1
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
                
            }
        }
        if mRequest.requestType == "newsinteractive"{
            if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                
                if let Lists: NSArray = dic1["List"] as!NSArray{
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "TRADING":dic2["TRADING"]!,
                                "SESNAME":dic2["SESNAME"]!,
                                "PROBLEM":dic2["PROBLEM"]!,
                                "QUESTIONTIME":dic2["QUESTIONTIME"]!,
                                "REPLY":dic2["REPLY"]!,
                                "ANSWERTIME":dic2["ANSWERTIME"]!,
                                "NEWSSOURCE":dic2["NEWSSOURCE"]!,
                                "INTERACTIVEID":dic2["PageNumber"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                    var resultJSON: JSON = [
                        "list": jsonarr1
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
                
            }
        }
    }
}
