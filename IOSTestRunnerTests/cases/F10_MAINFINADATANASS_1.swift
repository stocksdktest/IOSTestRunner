//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//财务报表
import XCTest
import os.log
import SwiftyJSON

class F10_MAINFINADATANASS_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_MAINFINADATANASS_1
    }
    
    func testFinancialInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFinancialInfoRequest()
        mRequest.code = param["CODE"].stringValue
        let typeVal = param["SOURCETYPE"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        let resp = self.makeSyncRequest(request: mRequest)
        let financialInfoResponse = resp as! MFinancialInfoResponse
        XCTAssertNotNil(financialInfoResponse.jsonObject)
        switch mRequest.sourceType{
        case .GA:
            var resultJSON : JSON = [:]
            var i=1
            if let dic1: NSDictionary = financialInfoResponse.jsonObject as? NSDictionary{
                var itemJSON : JSON = [
                    "REPORTTITLE_": dic1["REPORTTITLE"]!,
                    "BasicEPS": dic1["BASICEPS"]!,
                    
                    "BVPS_": dic1["BVPS"]!,
                    "NETCASHFLOWOPERPS_":dic1["NETCASHFLOWOPERPS"]!,
                    "WEIGHTEDROE_":dic1["WEIGHTEDROE"]!,
                    "ROA_":dic1["ROA"]!,
                    "TotalOperRevenue":dic1["TOTALOPERREVENUE"]!,
                    "OperProfit":dic1["OPERPROFIT"]!,
                    "NetProfit":dic1["NETPROFIT"]!,
                    
                    
                ]
                let update1: JSON = [
                    "TotalAsset":dic1["TOTALASSET"]!,
                    "TotalLiab":dic1["TOTALLIAB"]!,
                    "TotalSHEquity":dic1["TOTALSHEQUITY"]!,
                    "NetCashFlowOper":dic1["NETCASHFLOWOPER"]!,
                    "NetCashFlowInv":dic1["NETCASHFLOWINV"]!,
                    "NetCashFlowFina":dic1["NETCASHFLOWFINA"]!,
                    "CashEquiNetIncr":dic1["CASHEQUINETINCR"]!,
                    "EPSBASIC":dic1["BASICEPS"]!,
                ]
                do {
                    try itemJSON.merge(with: update1)
                } catch {
                    // ignore
                }
                resultJSON["\(i)"] = itemJSON
                i=i+1
                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
        case .CH:
            var resultJSON : JSON = [:]
            var i=1
//            if let arr1: NSArray = financialInfoResponse.jsonObject as? NSArray{
//                for item in arr1{
                    if let dic1 : NSDictionary = financialInfoResponse.jsonObject as? NSDictionary{
                        var itemJSON : JSON = [
                            "REPORTTITLE_": dic1["REPORTTITLE"]!,
                            "BasicEPS": dic1["BASICEPS"]!,
                            
                            "BVPS_": dic1["BVPS"]!,
                            "NETCASHFLOWOPERPS_":dic1["NETCASHFLOWOPERPS"]!,
                            "WEIGHTEDROE_":dic1["WEIGHTEDROE"]!,
                            "ROA_":dic1["ROA"]!,
                            "TotalOperRevenue":dic1["TOTALOPERREVENUE"]!,
                            "OperProfit":dic1["OPERPROFIT"]!,
                            "NetProfit":dic1["NETPROFIT"]!,
                            
                        ]
                        let update1: JSON = [
                            "TotalAsset":dic1["TOTALASSET"]!,
                            "TotalLiab":dic1["TOTALLIAB"]!,
                            "TotalSHEquity":dic1["TOTALSHEQUITY"]!,
                            "NetCashFlowOper":dic1["NETCASHFLOWOPER"]!,
                            "NetCashFlowInv":dic1["NETCASHFLOWINV"]!,
                            "NetCashFlowFina":dic1["NETCASHFLOWFINA"]!,
                            "CashEquiNetIncr":dic1["CASHEQUINETINCR"]!,
                            "EPSBASIC":dic1["BASICEPS"]!,
                        ]
                        do {
                            try itemJSON.merge(with: update1)
                        } catch {
                            // ignore
                        }
                        resultJSON["\(i)"] = itemJSON
                        i=i+1
//                    }
//                    
//                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
    }
}

