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

class MarginInfoTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.MarginInfoTestCase
    }
    
    func testMarginInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MMarginInfoRequest()
        mRequest.market = param["MARKET"].stringValue
        mRequest.ascending = param["ASCENDING"].boolValue
        mRequest.field = param["FIELD"].string
        mRequest.pageIndex = param["PAGEINDEX"].intValue
        mRequest.pageSize = param["PAGESIZE"].intValue
        
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        
        
            if let options = param["OPTIONS"].string{
                mRequest.options = options
            }
        
        
        let resp = self.makeSyncRequest(request: mRequest)
        let marginInfoResponse = resp as! MMarginInfoResponse
        XCTAssertNotNil(marginInfoResponse.jsonObject)
        let keys:NSArray = param["OPTIONS"].string?.split(separator: ",")as! NSArray
        
        if keys.count != 0{
            if let dic1:NSDictionary = marginInfoResponse.jsonObject as!NSDictionary{
                var resultJSON: JSON = [
                    "pageNumber": dic1["PageNumber"]!,
                    "page": dic1["Page"]!
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
                    "pageNumber": dic1["PageNumber"]!,
                    "page": dic1["Page"]!
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

