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

class FinancialSummaryTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.FinancialSummaryTestCase
    }
    
    func testFinancialSummary() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MFinancialSummaryRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        if let param = param["PARAM"].dictionary{
            mRequest.param = param
        }
        let resp = self.makeSyncRequest(request: mRequest)
        let financialSummaryResponse = resp as! MFinancialSummaryResponse
        XCTAssertNotNil(financialSummaryResponse.jsonObject)
        switch mRequest.sourceType{
        case .GA:
            var resultJSON : JSON = [:]
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
                    "WEIGHTEDROE_":dic1["WEIGHTEDROE"]!,
                    "ROA_EBIT_":dic1["ROA_EBIT"]!,
                    "GROSSPROFITMARGIN_":dic1["GROSSPROFITMARGIN"]!,
                    "PROFITMARGIN_":dic1["PROFITMARGIN"]!,
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
                    "NETPROFITPARENTCOMYOY_":dic1["NETPROFITPARENTCOMYOY"]!,
                    "NetCashFlowOperYOY":dic1["NETCASHFLOWOPERYOY"]!,
                    "ROEYOY":dic1["ROEYOY"]!,
                    "NetAssetYOY":dic1["NETASSETYOY"]!,
                    "TotalAssetYOY":dic1["TOTALASSETYOY"]!
                ]
                resultJSON["\(dic1["REPORTTITLE"]!)"] = itemJSON
            }
            print(resultJSON)
            onTestResult(param: param, result: resultJSON)
        case .CH:
            var resultJSON : JSON = [:]
            if let arr1: NSArray = financialSummaryResponse.jsonObject as? NSArray{
                for item in arr1{
                    if let dic1 : NSDictionary = item as? NSDictionary{
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
                            "ROA_EBIT_":dic1["ROA_EBIT"]!,
                            "GROSSPROFITMARGIN_":dic1["GROSSPROFITMARGIN"]!,
                            "PROFITMARGIN_":dic1["PROFITMARGIN"]!,
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
                            "NETPROFITPARENTCOMYOY_":dic1["NETPROFITPARENTCOMYOY"]!,
                            "NetCashFlowOperYOY":dic1["NETCASHFLOWOPERYOY"]!,
                            "ROEYOY":dic1["ROEYOY"]!,
                            "NetAssetYOY":dic1["NETASSETYOY"]!,
                            "TotalAssetYOY":dic1["TOTALASSETYOY"]!
                        ]
                        resultJSON["\(dic1["REPORTTITLE"]!)"] = itemJSON
                    }
                    
                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
    }
}

