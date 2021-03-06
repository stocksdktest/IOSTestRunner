//
//  qwe.swift
//  IOSTestRunnerTests
//
//  Created by 俞建斌 on 2019/9/6.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class AddValueTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.AddValueTestCase
    }
    
    func testAddValue() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MAddValueRequest()


        mRequest.code = param["CODE"].stringValue
        mRequest.subtype = param["SUBTYPE"].stringValue
        if param["FIELDS"].array != nil{
            var fieldVal = [String]()
            if let fields = param["FIELDS"].array{
                for field in fields{
                    fieldVal.append(field.stringValue)
                }
            }
            mRequest.fields = fieldVal
        }
        let resp = self.makeSyncRequest(request: mRequest)
        let addvalueResponse = resp as! MAddValueResponse
//        XCTAssertNotNil(addvalueResponse.addValueItems)
        var resultJSON : JSON = [:]
        var i = 1
        if addvalueResponse.addValueItems != nil{
            for addValueitems in addvalueResponse.addValueItems{
                let addValueitem:MAddValueItem = addValueitems as! MAddValueItem
                var itemJSON:JSON = [
                    "code" : addValueitem.code,
                    "date" : addValueitem.date,
                    "time" : addValueitem.time,
                    "ultraLargeBuyVolume" : addValueitem.ultraLargeBuyVolume,
                    "ultraLargeSellVolume" : addValueitem.ultraLargeSellVolume,
                    "ultraLargeBuyAmount" : addValueitem.ultraLargeBuyAmount,
                    "ultraLargeSellAmount" : addValueitem.ultraLargeSellAmount,
                    "largeBuyVolume" : addValueitem.largeBuyVolume,
                    "largeSellVolume" : addValueitem.largeSellVolume,
                    "largeBuyAmount" : addValueitem.largeBuyAmount,
                    "largeSellAmount" : addValueitem.largeSellAmount,
                    "mediumBuyVolume" : addValueitem.mediumBuyVolume,
                    "mediumSellVolume" : addValueitem.mediumSellVolume,
                    "mediumBuyAmount" : addValueitem.mediumBuyAmount,
                    "mediumSellAmount" : addValueitem.mediumSellAmount,
                    "smallBuyVolume" : addValueitem.smallBuyVolume,
                    "smallSellVolume" : addValueitem.smallSellVolume,
                    "smallBuyAmount" : addValueitem.smallBuyAmount,
                    "smallSellAmount" : addValueitem.smallSellAmount,
                    "ultraLargeNetInflow" : addValueitem.ultraLargeNetInflow,
                    "largeNetInflow" : addValueitem.largeNetInflow,
                    "netCapitalInflow" : addValueitem.netCapitalInflow,
                    "mediumNetInflow" : addValueitem.mediumNetInflow,
                    "smallNetInflow" : addValueitem.smallNetInflow,
                    "fundsInflows" : addValueitem.fundsInflows,
                    "fundsOutflows" : addValueitem.fundsOutflows,
                    "ultraLargeDiffer" : addValueitem.ultraLargeDiffer,
                    "largeDiffer" : addValueitem.largeDiffer,
                    "mediumDiffer" : addValueitem.mediumDiffer,
                    "smallDiffer" : addValueitem.smallDiffer,
                    "largeBuyDealCount" : addValueitem.largeBuyDealCount,
                    "largeSellDealCount" : addValueitem.largeSellDealCount,
                    "dealCountMovingAverage" : addValueitem.dealCountMovingAverage,
                    "buyCount" : addValueitem.buyCount,
                    "sellCount" : addValueitem.sellCount,
                    "BBD" : addValueitem.bbd,
                    "BBD5" : addValueitem.bbd5,
                    "BBD10" : addValueitem.bbd10,
                    "DDX" : addValueitem.ddx,
                    "DDX5" : addValueitem.ddx5,
                    "DDX10" : addValueitem.ddx10,
                    "DDY" : addValueitem.ddy,
                    "DDY5" : addValueitem.ddy5,
                    "DDY10" : addValueitem.ddy10,
                    "DDZ" : addValueitem.ddz,
                    "RatioBS" : addValueitem.ratioBS,
                    "othersFundsInflows" : addValueitem.othersFundsInflows,
                    "othersFundsOutflows" : addValueitem.othersFundsOutflows,
                    "fiveMinutesChangeRate" : addValueitem.fiveMinRise,
                    "largeOrderNumB" : addValueitem.ultraLargeBuyCount,
                    "largeOrderNumS" : addValueitem.ultraLargeSellCount,
                    "bigOrderNumB" : addValueitem.largeBuyCount,
                    "bigOrderNumS" : addValueitem.largeSellCount,
                    "midOrderNumB" : addValueitem.mediumBuyCount,
                    "midOrderNumS" : addValueitem.mediumSellCount,
                    "smallOrderNumB" : addValueitem.smallBuyCount,
                    "smallOrderNumS" : addValueitem.smallSellCount,
                    "mainforceMoneyNetInflow5" : addValueitem.netInflow5,
                    "mainforceMoneyNetInflow10" : addValueitem.netInflow10,
                    "mainforceMoneyNetInflow20" : addValueitem.netInflow20,
                    "ratioMainforceMoneyNetInflow5" : addValueitem.netInflowRate5,
                    "ratioMainforceMoneyNetInflow10" : addValueitem.netInflowRate10,
                    "ratioMainforceMoneyNetInflow5" : addValueitem.netInflowRate20
                ]
                resultJSON["\(i)"] = itemJSON
                i = i + 1
            }
        }
        
        print(resultJSON)
        onTestResult(param: param, result: resultJSON)
    }
    
}

