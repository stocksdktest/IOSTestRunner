//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//基本情况
import XCTest
import os.log
import SwiftyJSON

class CompanyInfoTestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.CompanyInfoTestCase
    }
    
    func testCompanyInfo() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MCompanyInfoRequest()
        mRequest.code = param["CODE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        
        
        let resp = self.makeSyncRequest(request: mRequest)
        let companyInfoResponse = resp as! MCompanyInfoResponse
        XCTAssertNotNil(companyInfoResponse.record)
        if let record: NSDictionary = companyInfoResponse.record as NSDictionary{
            switch mRequest.sourceType{
                
            case .GA:
                var resultJSON: JSON = [
                    "LEGALREPR": record["LEGALREPR"]!,
                    "COREBUSINESS": record["COREBUSINESS"]!,
                    "PROVINCENAME": record["PROVINCENAME"]!,
                    "LISTINGDATE": record["LISTINGDATE"]!,
                    "BUSINESSSCOPE": record["BUSINESSSCOPE"]!,
                    "INDUNAMESW": record["INDUNAMESW"]!,
                    "REGCAPITAL": record["REGCAPITAL"]!,
                    "CHINAME": record["CHINAME"]!,
                    "REGADDRESS": record["REGADDRESS"]!
                ]
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            case .CH:
                var resultJSON: JSON = [
                    "CHINAME": record["CHINAME"]!,
                    "SEENGNAME": record["SEENGNAME"]!,
                    "AUTHCAPSK": record["AUTHCAPSK"]!,
                    "LISTINGDATE": record["LISTINGDATE"]!,
                    "ISSUECAPSK": record["ISSUECAPSK"]!,
                    "CURNAME": record["CURNAME"]!,
                    "PARVALUE": record["PARVALUE"]!,
                    "DEBTBOARDLOT": record["DEBTBOARDLOT"]!
                ]
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
            
            
        }
    }
}

