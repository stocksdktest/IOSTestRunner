////
////  ExampleTestCase2.swift
////  IOSTestRunnerTests
////
////  Created by liao xiangsen on 2019/8/27.
////  Copyright © 2019年 liao xiangsen. All rights reserved.
////
////港股通额度和沪深股通额度走势接口
//import XCTest
//import os.log
//import SwiftyJSON
//
//class TONGLINETEST_1: BaseTestCase {
//    
//    override var stockTestCaseName: StockTestCaseName {
//        return StockTestCaseName.TONGLINETEST_1
//    }
//    
//    func testIndexUpdowns() throws{
//        let param = self.testCaseRoundConfig.getParam()
//        let mRequest = MTongLineRequest()
//        mRequest.type = param["TYPE"].stringValue
//        
//        let resp = try self.makeSyncRequest(request: mRequest)
//        let tongLineResponse = resp as! MTongLineResponse
////        print("-----98--\(tongLineResponse.items)")
//        if (tongLineResponse.items == nil){
//            throw BaseTestError.assertFailedError(message: "tongLineResponse items is nil")
//        }
//        var resultJSON: JSON = [:]
//        var i = 0
//        for item in tongLineResponse.items{
//            print(item.szInflowAmount)
//            let resultJSON1: JSON = [
//                "datetime":item.datetime,
//                "SHInflowAmount":item.shInflowAmount,
//                "SHInitialAmount":item.shInitialAmount,
//                "SHRemainingAmount":item.shRemainingAmount,
//                "SHSZInflowAmount":item.shszInflowAmount,
//                "SZInflowAmount":item.szInflowAmount,
//                "SZInitialAmount":item.szInitialAmount,
//                "SZRemainingAmount":item.szRemainingAmount,
//                ]
//            resultJSON["\(item.datetime ?? "isEmpty_"+String(i))"] = resultJSON1;
//            i+=1
//        }
//        print(resultJSON)
//        onTestResult(param: param, result: resultJSON)
//    }
//}
