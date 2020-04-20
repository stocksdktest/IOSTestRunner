//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//买卖队列
import XCTest
import os.log
import SwiftyJSON

class ORDERQUANTITY_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.ORDERQUANTITY_1
    }
    
    func testOrderQuantity() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MOrderQuantityRequest()
        mRequest.code = param["CODE"].stringValue
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let orderQuantityResponse = resp as! MOrderQuantityResponse
        if (orderQuantityResponse.buyItems == nil){
            throw BaseTestError.assertFailedError(message: "orderQuantityResponse buyItems is nil")
        }
        if (orderQuantityResponse.sellItems == nil){
            throw BaseTestError.assertFailedError(message: "orderQuantityResponse sellItems is nil")
        }
        var jsonarr1 = [String]()
        if orderQuantityResponse.buyItems != nil{
            for buyitem in orderQuantityResponse.buyItems{
                let OQitems:NSArray = buyitem as! NSArray
                for OQitem in OQitems{
                    let orderQuantityBuyItem:MOrderQuantityItem = OQitem as! MOrderQuantityItem
                    jsonarr1.append(orderQuantityBuyItem.volume)
                }
            }
        }
        
        var jsonarr2 = [String]()
        if orderQuantityResponse.sellItems != nil{
            for sellitem in orderQuantityResponse.sellItems{
                
                let OQitems:NSArray = sellitem as! NSArray
                for OQitem in OQitems{
                    let orderQuantitySellItem:MOrderQuantityItem = OQitem as! MOrderQuantityItem
                    jsonarr2.append(orderQuantitySellItem.volume)
                }
            }
        }
        
        var jsonarr3: JSON = [
            "QUANTITY": jsonarr1
        ]
        var jsonarr4: JSON = [
            "QUANTITY": jsonarr2
        ]
        var resultJSON: JSON = [
            "buyList": jsonarr3,
            "sellList": jsonarr4
            ]
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
}

