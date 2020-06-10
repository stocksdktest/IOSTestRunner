//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//财务指标
import XCTest
import os.log
import SwiftyJSON

class F10_MAINFINAINDEXNAS_2: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_MAINFINAINDEXNAS_2
    }
    
    func testFinancialSummary() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFinancialSummaryRequest()
        mRequest.code = param["CODE"].stringValue
       let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
        if param["PARAMS"].stringValue == "null"{
            mRequest.param = nil
        }else{
            mRequest.param = ["type":param["param"].stringValue]
        }
        let resp = try self.makeSyncRequest(request: mRequest)
        let financialSummaryResponse = resp as! MFinancialSummaryResponse
//        XCTAssertNotNil(financialSummaryResponse.jsonObject)
        if (financialSummaryResponse.jsonObject == nil){
            throw BaseTestError.assertFailedError(message: "financialSummaryResponse jsonObject is nil")
        }
        switch mRequest.sourceType{
        case .GA:
            var resultJSON : JSON = [:]
            var i=1
            if let dic1: NSDictionary = financialSummaryResponse.jsonObject as? NSDictionary{
                var itemJSON : JSON = [
                    "REPORTTITLE_": dic1["REPORTTITLE"]!,
                    "BasicEPS": dic1["BASICEPS"]!,
                    "RESERVEPS_": dic1["RESERVEPS"]!,
                    "BVPS_": dic1["BVPS"]!,
                    "TotalOperIncomePS":dic1["TOTALOPERINCOMEPS"]!,
                    "EBITPS_":dic1["EBITPS"]!,
                    "RetainedEarningPS":dic1["RETAINEDEARNINGPS"]!,
                    "NetCashFlowOperPS":dic1["NETCASHFLOWOPERPS"]!,
                    "NETCASHFLOWPS_":dic1["NETCASHFLOWPS"]!,
                    
                    
                ]
                let update1: JSON = [
                    "TLToTA_":dic1["TLTOTA"]!,
                    "TAToSHE_":dic1["TATOSHE"]!,
                    "CurrentRatio":dic1["CURRENTRATIO"]!,
                    "QuickRatio":dic1["QUICKRATIO"]!,
                    "EBITToIE_":dic1["EBITTOIE"]!,
                    "InventoryTurnover":dic1["INVENTORYTURNOVER"]!,
                    "ACCOUNTRECTURNOVER_":dic1["ACCOUNTRECTURNOVER"]!,
                    "FixedAssetTurnover":dic1["FIXEDASSETTURNOVER"]!,
                    "TotalAssetTurnover":dic1["TOTALASSETTURNOVER"]!,
                    "OperRevenueYOY":dic1["OPERREVENUEYOY"]!,
                    "OperProfitYOY":dic1["OPERPROFITYOY"]!,
                    
                ]
                let update2: JSON = [
                    "NETPROFITPARENTCOMYOY_":dic1["NETPROFITPARENTCOMYOY"]!,
                    "NetCashFlowOperYOY":dic1["NETCASHFLOWOPERYOY"]!,
                    "ROEYOY_":dic1["ROEYOY"]!,
                    "NetAssetYOY":dic1["NETASSETYOY"]!,
                    "TotalAssetYOY":dic1["TOTALASSETYOY"]!,
                    "WEIGHTEDROE_":dic1["WEIGHTEDROE"]!,
                    "ROA_EBIT_":dic1["ROA_EBIT"]!,
                    "GROSSPROFITMARGIN_":dic1["GROSSPROFITMARGIN"]!,
                    "PROFITMARGIN_":dic1["PROFITMARGIN"]!,
                ]
                do {
                    try itemJSON.merge(with: update1)
                    try itemJSON.merge(with: update2)
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
//            if let arr1: NSArray = financialSummaryResponse.jsonObject as? NSArray{
//                for item in arr1{
                    if let dic1 : NSDictionary = financialSummaryResponse.jsonObject as? NSDictionary{
                        var itemJSON : JSON = [
                            "REPORTTITLE_": dic1["REPORTTITLE"]!,
                            "BasicEPS": dic1["BASICEPS"]!,
                            "BVPS_": dic1["BVPS"]!,
                            "TotalOperIncomePS":dic1["TOTALOPERINCOMEPS"]!,
                            "EBITPS_":dic1["EBITPS"]!,
                            "RetainedEarningPS":dic1["RETAINEDEARNINGPS"]!,
                            "NetCashFlowOperPS":dic1["NETCASHFLOWOPERPS"]!,
                            "NETCASHFLOWPS_":dic1["NETCASHFLOWPS"]!,
                            "WEIGHTEDROE_":dic1["WEIGHTEDROE"]!,
                        ]
                        let update1: JSON = [
                            "TAToSHE_":dic1["TATOSHE"]!,
                            "CurrentRatio":dic1["CURRENTRATIO"]!,
                            "QuickRatio":dic1["QUICKRATIO"]!,
                            "EBITToIE_":dic1["EBITTOIE"]!,
                            "InventoryTurnover":dic1["INVENTORYTURNOVER"]!,
                            "ACCOUNTRECTURNOVER_":dic1["ACCOUNTRECTURNOVER"]!,
                            "FixedAssetTurnover":dic1["FIXEDASSETTURNOVER"]!,
                            "TotalAssetTurnover":dic1["TOTALASSETTURNOVER"]!,
                            "OperRevenueYOY":dic1["OPERREVENUEYOY"]!,
                            "OperProfitYOY":dic1["OPERPROFITYOY"]!,
                            
                        ]
                        let update2: JSON = [
                            "NETPROFITPARENTCOMYOY_":dic1["NETPROFITPARENTCOMYOY"]!,
                            "NetCashFlowOperYOY":dic1["NETCASHFLOWOPERYOY"]!,
                            "ROEYOY_":dic1["ROEYOY"]!,
                            "NetAssetYOY":dic1["NETASSETYOY"]!,
                            "TotalAssetYOY":dic1["TOTALASSETYOY"]!,
                            "GROSSPROFITMARGIN_":dic1["GROSSPROFITMARGIN"]!,
                            "PROFITMARGIN_":dic1["PROFITMARGIN"]!,
                            "TLToTA_":dic1["TLTOTA"]!,
                            "ROA_EBIT_":dic1["ROA_EBIT"]!,
                        ]
                        do {
                            try itemJSON.merge(with: update1)
                            try itemJSON.merge(with: update2)
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

