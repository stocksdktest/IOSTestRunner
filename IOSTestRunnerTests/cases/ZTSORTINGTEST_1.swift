////
////  ExampleTestCase2.swift
////  IOSTestRunnerTests
////
////  Created by liao xiangsen on 2019/8/27.
////  Copyright © 2019年 liao xiangsen. All rights reserved.
////
////涨停商品行情请求类
//import XCTest
//import os.log
//import SwiftyJSON
//
//class ZTSORTINGTEST_1: BaseTestCase {
//    
//    override var stockTestCaseName: StockTestCaseName {
//        return StockTestCaseName.ZTSORTINGTEST_1
//    }
//    
//    func testIndexUpdowns() throws{
//        let param = self.testCaseRoundConfig.getParam()
//        let mRequest = MZTSortingRequest()
//        let paramI = (param["PARAMS"].stringValue.split(separator: ",") as NSArray)
//        mRequest.pageIndex = Int(paramI[0] as! String) ?? 0
//        mRequest.pageSize = Int(paramI[1] as! String) ?? 20
////        mRequest.field = MZTSortingField.init(rawValue: UInt(paramI[2] as! String)!)!
//        mRequest.field = MZTSortingField(rawValue: UInt(paramI[2] as! String)!)!
//        if paramI[3] as! String == "1"{
//            mRequest.ascending = false
//        }
//        if paramI[3] as! String == "0"{
//            mRequest.ascending = true
//        }
//        if param["TYPE"] == "allzt"{
//            mRequest.type = MZTSortingType(rawValue: 0)!
//        }
//        if param["TYPE"] == "yzzt"{
//            mRequest.type = MZTSortingType(rawValue: 1)!
//        }
//        if param["TYPE"] == "zrzt"{
//            mRequest.type = MZTSortingType(rawValue: 2)!
//        }
//        let resp = try self.makeSyncRequest(request: mRequest)
//        let ZTSortingResponse = resp as! MZTSortingResponse
//        if (ZTSortingResponse.items == nil){
//            throw BaseTestError.assertFailedError(message: "ZTSortingResponse items is nil")
//        }
//        var resultJSON: JSON = [:]
//        var i = 1
//        for item in ZTSortingResponse.items{
//            print(item.financeFlag.rawValue)
//            var resultJSON1: JSON = [
//                "ztdateTime":item.ztdateTime,
//                "code":item.code,
//                "name":item.name,
//                "market":item.market,
//                "subtype":item.subtype,
//                "lastPrice":item.lastPrice,
//                "preClosePrice":item.preClosePrice,
//                ]
//            let resultJSON2: JSON = [
//                "changeRate":item.changeRate,
//                "buyVolumes":item.buyVolumes,
//                "financeFlag":item.financeFlag.rawValue,
//                "securityFlag":item.securityFlag.rawValue
//            ]
//            do {
//                try resultJSON1.merge(with: resultJSON2)
//            } catch {
//                // ignore
//            }
//            resultJSON["\(String(i))"] = resultJSON1;
//            i+=1
//        }
//        print(resultJSON)
//        onTestResult(param: param, result: resultJSON)
//    }
//}
