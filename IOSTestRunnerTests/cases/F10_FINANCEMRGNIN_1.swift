//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//融资融券--分市场提供最近交易日融资融券数据
import XCTest
import os.log
import SwiftyJSON

class F10_FINANCEMRGNIN_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_FINANCEMRGNIN_1
    }
    
    func testMarginInfo() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MMarginInfoRequest()
        let marketI:NSArray = (param["MARKET"].string?.split(separator: "_") as! NSArray)
        mRequest.market = marketI[1] as! String
        if marketI[2] as! String == "0"{
            mRequest.ascending = ("1" as NSString).boolValue
        }else if marketI[2] as! String == "1"{
            mRequest.ascending = ("0" as NSString).boolValue
        }
        mRequest.field = marketI[0] as! String
        let paramI:NSArray = (param["PARAMS"].string?.split(separator: ",") as! NSArray)
        mRequest.pageSize = Int(paramI[1] as! String)!
        mRequest.pageIndex = Int(paramI[0] as! String)!
        
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        if let options = param["OPTIONS"].string{
            mRequest.options = options
        }
        
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let marginInfoResponse = resp as! MMarginInfoResponse
//        XCTAssertNotNil(marginInfoResponse.jsonObject)
        if (marginInfoResponse.jsonObject == nil){
            throw BaseTestError.assertFailedError(message: "marginInfoResponse jsonObject is nil")
        }
        let keys:NSArray = param["OPTIONS"].string?.split(separator: ",")as! NSArray
        
        if keys.count != 0{
            if let dic1:NSDictionary = marginInfoResponse.jsonObject as!NSDictionary{
//                let pageNumber = "\(dic1["PageNumber"])"
                var resultJSON: JSON = [
                    "pageNumber": "\(dic1["PageNumber"])",
                    "page": "\(dic1["Page"])"
                ]
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
            if let dic1:NSDictionary = marginInfoResponse.jsonObject as!NSDictionary{
                var resultJSON: JSON = [
                    "pageNumber": "\(dic1["PageNumber"])",
                    "page": "\(dic1["Page"])"
                ]
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
//        print(marginInfoResponse.jsonObject)
//        if let dic1:NSDictionary = marginInfoResponse.jsonObject as! NSDictionary{
//            var resultJSON: JSON = [
//                "PageNumber": dic1["PageNumber"]!,
//                "TRADEDATE": dic1["TRADEDATE"]!,
//                "TRADING": dic1["TRADING"]!,
//                "FINBALANCE": dic1["FINBALANCE"]!,
//                "FINBUYAMT": dic1["FINBUYAMT"]!,
//                "FINREPAYAMT": dic1["FINREPAYAMT"]!,
//                "FINROEBUY": dic1["FINROEBUY"]!,
//                "MRGGBAL": dic1["MRGGBAL"]!,
//                "MRGNRESQTY": dic1["MRGNRESQTY"]!,
//                "MRGNSELLAMT": dic1["MRGNSELLAMT"]!,
//                "MRGNREPAYAMT": dic1["MRGNREPAYAMT"]!,
//                "MRGNROESELL": dic1["MRGNROESELL"]!,
//                "FINMRGHBAL": dic1["FINMRGHBAL"]!,
//                "FINMRGNBAL": dic1["FINMRGNBAL"]!,
//                "Page": dic1["Page"]!
//            ]
//
//            print(resultJSON)
//            onTestResult(param: param, result: resultJSON)
//        }
//    }
//}

