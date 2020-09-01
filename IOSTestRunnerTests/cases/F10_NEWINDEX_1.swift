//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//最新指标
import XCTest
import os.log
import SwiftyJSON

class F10_NEWINDEX_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10_NEWINDEX_1
    }
   
    func testLatestIndex() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MLatestIndexRequest()
        mRequest.code = param["CODE"].stringValue
        let typeVal = param["SRC"].stringValue
        if typeVal == "g"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 1)!
        }else if typeVal == "d"{
            mRequest.sourceType = MF10DataSourceType(rawValue: 2)!
        }
    
        
        let resp = try self.makeSyncRequest(request: mRequest)
        let latestIndexResponse = resp as! MLatestIndexResponse
//        XCTAssertNotNil(latestIndexResponse.record)
        if (latestIndexResponse.record == nil){
            throw BaseTestError.assertFailedError(message: "latestIndexResponse record is nil")
        }
        switch mRequest.sourceType{
            
        case .GA:
            if let record = latestIndexResponse.record{
                var resultJSON: JSON = [
                    "netProfitCutParentComYOY": record["NETPROFITCUTPARENTCOMYOY"]!,
                    "netProfitCutParentCom": record["NETPROFITCUTPARENTCOM"]!,
                    "cutBasicEPS": record["CUTBASICEPS"]!,
                    "annuROE": record["ANNUROE"]!,
                    "netProfitParentCom": record["NETPROFITPARENTCOM"]!,
                    "basicEPS": record["BASICEPS"]!,
                    "totalShare": record["TOTALSHARE"]!,
                    
                ]
                let update1: JSON = [
                    "BVPS_": record["BVPS"]!,
                    "reservePS": record["RESERVEPS"]!,
                    "REPTITLE_": record["REPTITLE"]!,
                    "netCashFlowOperPS": record["NETCASHFLOWOPERPS"]!,
                    "grossProfitMargin": record["GROSSPROFITMARGIN"]!,
                    "netProfitParentComYOY": record["NETPROFITPARENTCOMYOY"]!,
                    "retainedEarningPS": record["RETAINEDEARNINGPS"]!,
                    "operRevenueYOY": record["OPERREVENUEYOY"]!,
                    "operRevenue": record["OPERREVENUE"]!
                ]
                do {
                    try resultJSON.merge(with: update1)
                } catch {
                    // ignore
                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        case .CH:
            if let record = latestIndexResponse.record{
                var resultJSON: JSON = [
                    "netProfitCutParentComYOY": record["NETPROFITCUTPARENTCOMYOY"]!,
                    "netProfitCutParentCom": record["NETPROFITCUTPARENTCOM"]!,
                    "cutBasicEPS": record["CUTBASICEPS"]!,
                    "annuROE": record["ANNUROE"]!,
                    "netProfitParentCom": record["NETPROFITPARENTCOM"]!,
                    "basicEPS": record["BASICEPS"]!,
                    "totalShare": record["TOTALSHARE"]!,
                    
                ]
                let update1: JSON = [
                    "BVPS_": record["BVPS"]!,
                    "REPTITLE_": record["REPTITLE"]!,
                    "netCashFlowOperPS": record["NETCASHFLOWOPERPS"]!,
                    "grossProfitMargin": record["GROSSPROFITMARGIN"]!,
                    "netProfitParentComYOY": record["NETPROFITPARENTCOMYOY"]!,
                    "operRevenueYOY": record["OPERREVENUEYOY"]!,
                    "operRevenue": record["OPERREVENUE"]!
                ]
                do {
                    try resultJSON.merge(with: update1)
                } catch {
                    // ignore
                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
            case .CLS:
                var resultJSON: JSON = ["default":"I'm just kidding you"]
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
        }
        
    }
}

