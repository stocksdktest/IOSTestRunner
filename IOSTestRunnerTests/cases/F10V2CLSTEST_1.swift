//
//  BlockTradeTestCase.swift
//  IOSTestRunnerTests
//
//  Created by 俞建斌 on 2019/9/25.
//  Copyright © 2019 liao xiangsen. All rights reserved.
//

import XCTest
import os.log
import SwiftyJSON

class F10V2CLSTEST_1: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10V2CLSTEST_1
    }
    func testF10() throws{
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MF10Request()
        mRequest.code = param["SYMBOL"].stringValue
        let TYPE = param["REQUESTTYPE"].stringValue.replacingOccurrences(of: "/", with: "")
        mRequest.requestType = TYPE
        mRequest.sourceType = MF10DataSourceType(rawValue: 3)!
        if mRequest.requestType == "clsinparamslist"{
            mRequest.param = ["param":param["PARAMS"].stringValue,"type":"all"]
        }
        else{
            mRequest.param = ["param":param["PARAMS"].stringValue]
        }
        let resp = try self.makeSyncRequest(request: mRequest)
        let f10Response = resp as! MF10Response
//        XCTAssertNotNil(f10Response.jsonObject)
        if (f10Response.jsonObject == nil){
            throw BaseTestError.assertFailedError(message: "f10Response jsonObject is nil")
        }
        print("ip:\(mRequest.ip)\n/*/*--//*/*++:\(f10Response)")
        var resultJSON : JSON = [:]
        var resultJSON1 : JSON = [:]
            //财联社—电报、加红
            if mRequest.requestType == "clstelegramlist"{
                if let dic1: NSDictionary = f10Response.jsonObject as? NSDictionary{
                    resultJSON1 = [
                        "Page":dic1["Page"] ?? "-",
                        "PageNumber":dic1["PageNumber"] ?? "-",
                    ]
                    for temp in resultJSON1.dictionaryValue.keys {
                        if resultJSON1[temp] == ""{
                            resultJSON1[temp] = "-"
                        }
                    }
                    let list: NSArray = dic1["List"] as! NSArray
                    for i in 0..<list.count{
                        let TD: NSDictionary = list[i] as! NSDictionary
                        resultJSON = [
                            "ID":TD["ID"] ?? "-",
                            "PUBDATE":TD["PUBDATE"] ?? "-",
                            "TITLE":TD["TITLE"] ?? "-",
                            "CONTENT":TD["CONTENT"] ?? "-",
                            "RECOMMEND":TD["RECOMMEND"] ?? "-",
                            "STOCKS":TD["STOCKS"] ?? "-",
                            "TOPICS":TD["TOPICS"] ?? "-",
                            "BRIEF":TD["BRIEF"] ?? "-",
                        ]
                        for temp in resultJSON.dictionaryValue.keys {
                            if resultJSON[temp] == ""{
                                resultJSON[temp] = "-"
                            }
                        }
                        resultJSON1["\(TD["ID"]!)"] = resultJSON
                    }
//                        print(resultJSON1)
                    onTestResult(param: param, result: resultJSON1)
                }
            }
            //财联社-要闻列表
            if mRequest.requestType == "clsimportantnewslist"{
                if mRequest.code == "10" || mRequest.code == "13"{
                    if let TA: NSArray = f10Response.jsonObject as? NSArray{
                        for i in 0..<TA.count{
                            let TD: NSDictionary = TA[i] as! NSDictionary
                            resultJSON = [
                                "ID":TD["ID"] ?? "-",
                                "PUBDATE":TD["PUBDATE"] ?? "-",
                                "TITLE":TD["TITLE"] ?? "-",
                                "BRIEF":TD["BRIEF"] ?? "-",
                                "IMG":TD["IMG"] ?? "-",
                                "SUBJECTID":TD["SUBJECTID"] ?? "-",
                                "SUBJECTNAME":TD["SUBJECTNAME"] ?? "-",
                                "PID":TD["PID"] ?? "-",
                                "PID_ID":TD["PID_ID"] ?? "-",
                                "STOCKS":TD["STOCKS"] ?? "-",
                                "TOPICS":TD["TOPICS"] ?? "-",
                            ]
                            for temp in resultJSON.dictionaryValue.keys {
                                if resultJSON[temp] == ""{
                                    resultJSON[temp] = "-"
                                }
                            }
                            resultJSON1["\(TD["ID"]!)"] = resultJSON
                        }
                    }
                }else{
                    if let dic1: NSDictionary = f10Response.jsonObject as? NSDictionary{
                        resultJSON1 = [
                            "Page":dic1["Page"] ?? "-",
                            "PageNumber":dic1["PageNumber"] ?? "-",
                        ]
                        for temp in resultJSON1.dictionaryValue.keys {
                            if resultJSON1[temp] == ""{
                                resultJSON1[temp] = "-"
                            }
                        }
                        let list: NSArray = dic1["List"] as! NSArray
                        for i in 0..<list.count{
                            let TD: NSDictionary = list[i] as! NSDictionary
                            resultJSON = [
                                "ID":TD["ID"] ?? "-",
                                "PUBDATE":TD["PUBDATE"] ?? "-",
                                "TITLE":TD["TITLE"] ?? "-",
                                "BRIEF":TD["BRIEF"] ?? "-",
                                "IMG":TD["IMG"] ?? "-",
                                "SUBJECTID":TD["SUBJECTID"] ?? "-",
                                "SUBJECTNAME":TD["SUBJECTNAME"] ?? "-",
                                "PID":TD["PID"] ?? "-",
                                "PID_ID":TD["PID_ID"] ?? "-",
                                "STOCKS":TD["STOCKS"] ?? "-",
                                "TOPICS":TD["TOPICS"] ?? "-",
                            ]
                            for temp in resultJSON.dictionaryValue.keys {
                                if resultJSON[temp] == ""{
                                    resultJSON[temp] = "-"
                                }
                            }
                            resultJSON1["\(TD["ID"]!)"] = resultJSON
                        }
                    }
                }
//              print(resultJSON1)
                onTestResult(param: param, result: resultJSON1)
            }
            //财联社-VIP列表
            if mRequest.requestType == "clsviplist"{
                if let dic1: NSDictionary = f10Response.jsonObject as? NSDictionary{
                    resultJSON1 = [
                        "Page":dic1["Page"] ?? "-",
                        "PageNumber":dic1["PageNumber"] ?? "-",
                    ]
                    for temp in resultJSON1.dictionaryValue.keys {
                        if resultJSON1[temp] == ""{
                            resultJSON1[temp] = "-"
                        }
                    }
                    let list: NSArray = dic1["List"] as! NSArray
                    for i in 0..<list.count{
                        let TD: NSDictionary = list[i] as! NSDictionary
                        resultJSON = [
                            "ID":TD["ID"] ?? "-",
                            "PUBDATE":TD["PUBDATE"] ?? "-",
                            "TITLE":TD["TITLE"] ?? "-",
                            "BRIEF":TD["BRIEF"] ?? "-",
                            "STOCKS":TD["STOCKS"] ?? "-",
                            "TOPICS":TD["TOPICS"] ?? "-",
                        ]
                        for temp in resultJSON.dictionaryValue.keys {
                            if resultJSON[temp] == ""{
                                resultJSON[temp] = "-"
                            }
                        }
                        resultJSON1["\(TD["ID"]!)"] = resultJSON
                    }
//                        print(resultJSON1)
                    onTestResult(param: param, result: resultJSON1)
                }
            }
            //财联社-要闻详情
            if mRequest.requestType == "clsimportantnews"{
                if let TD: NSDictionary = f10Response.jsonObject as? NSDictionary{
                        resultJSON = [
                            "ID":TD["ID"] ?? "-",
                            "PUBDATE":TD["PUBDATE"] ?? "-",
                            "TITLE":TD["TITLE"] ?? "-",
                            "CONTENT":TD["CONTENT"] ?? "-",
                            "IMG":TD["IMG"] ?? "-",
                            "AUTHOR":TD["AUTHOR"] ?? "-",
                            "STOCKS":TD["STOCKS"] ?? "-",
                            "SUBJECTID":TD["SUBJECTID"] ?? "-",
                            "SUBJECTNAME":TD["SUBJECTNAME"] ?? "-",
                            "PID":TD["PID"] ?? "-",
                            "PID_ID":TD["PID_ID"] ?? "-",
                            "BRIEF":TD["BRIEF"] ?? "-",
                            "TOPICS":TD["TOPICS"] ?? "-",
                        ]
                        for temp in resultJSON.dictionaryValue.keys {
                            if resultJSON[temp] == ""{
                                resultJSON[temp] = "-"
                            }
                        }
//                        print(resultJSON1)
                    onTestResult(param: param, result: resultJSON)
                }
            }
            //财联社-vip详情
            if mRequest.requestType == "clsvip"{
                if let TD: NSDictionary = f10Response.jsonObject as? NSDictionary{
                        resultJSON = [
                            "ID":TD["ID"] ?? "-",
                            "PUBDATE":TD["PUBDATE"] ?? "-",
                            "TITLE":TD["TITLE"] ?? "-",
                            "CONTENT":TD["CONTENT"] ?? "-",
                            "BRIEF":TD["BRIEF"] ?? "-",
                            "STOCKS":TD["STOCKS"] ?? "-",
                            "TOPICS":TD["TOPICS"] ?? "-",
                        ]
                        for temp in resultJSON.dictionaryValue.keys {
                            if resultJSON[temp] == ""{
                                resultJSON[temp] = "-"
                            }
                        }
//                        print(resultJSON1)
                    onTestResult(param: param, result: resultJSON)
                }
            }
            //财联社-风口-内参列表
            if mRequest.requestType == "clsinparamslist"{
                if let dic1: NSDictionary = f10Response.jsonObject as? NSDictionary{
                    resultJSON1 = [
                        "Page":dic1["Page"] ?? "-",
                        "PageNumber":dic1["PageNumber"] ?? "-",
                    ]
                    for temp in resultJSON1.dictionaryValue.keys {
                        if resultJSON1[temp] == ""{
                            resultJSON1[temp] = "-"
                        }
                    }
                    let list: NSArray = dic1["List"] as! NSArray
                    for i in 0..<list.count{
                        let TD: NSDictionary = list[i] as! NSDictionary
                        resultJSON = [
                            "ID":TD["ID"] ?? "-",
                            "PUBDATE":TD["PUBDATE"] ?? "-",
                            "NAME":TD["NAME"] ?? "-",
                            "BRIEF":TD["BRIEF"] ?? "-",
                            "STOCKS":TD["STOCKS"] ?? "-",
                            "TOPICS":TD["TOPICS"] ?? "-",
                        ]
                        for temp in resultJSON.dictionaryValue.keys {
                            if resultJSON[temp] == ""{
                                resultJSON[temp] = "-"
                            }
                        }
                        resultJSON1["\(TD["ID"]!)"] = resultJSON
                    }
//                        print(resultJSON1)
                    onTestResult(param: param, result: resultJSON1)
                }
            }
            //财联社-风口-内参详情
            if mRequest.requestType == "clsinparams"{
                if let TD: NSDictionary = f10Response.jsonObject as? NSDictionary{
                        resultJSON = [
                            "ID":TD["ID"] ?? "-",
                            "PUBDATE":TD["PUBDATE"] ?? "-",
                            "TITLE":TD["TITLE"] ?? "-",
                            "CONTENT":TD["CONTENT"] ?? "-",
                            "BRIEF":TD["BRIEF"] ?? "-",
                            "NAME":TD["NAME"] ?? "-",
                            "STOCKS":TD["STOCKS"] ?? "-",
                            "TOPICS":TD["TOPICS"] ?? "-",
                        ]
                        for temp in resultJSON.dictionaryValue.keys {
                            if resultJSON[temp] == ""{
                                resultJSON[temp] = "-"
                            }
                        }
//                        print(resultJSON1)
                    onTestResult(param: param, result: resultJSON)
                }
            }
            //财联社-个股资讯列表
            if mRequest.requestType == "clsnewslist"{
                if let dic1: NSDictionary = f10Response.jsonObject as? NSDictionary{
                    resultJSON1 = [
                        "Page":dic1["Page"] ?? "-",
                        "PageNumber":dic1["PageNumber"] ?? "-",
                        "Cnt":dic1["Cnt"] ?? "-",
                        "OverPage":dic1["OverPage"] ?? "-",
                    ]
                    for temp in resultJSON1.dictionaryValue.keys {
                        if resultJSON1[temp] == ""{
                            resultJSON1[temp] = "-"
                        }
                    }
                    let list: NSArray = dic1["List"] as! NSArray
                    for i in 0..<list.count{
                        let TD: NSDictionary = list[i] as! NSDictionary
                        resultJSON = [
                            "ID":TD["ID"] ?? "-",
                            "PUBDATE":TD["PUBDATE"] ?? "-",
                            "TITLE":TD["TITLE"] ?? "-",
                            "BRIEF":TD["BRIEF"] ?? "-",
                            "RECOMMEND":TD["RECOMMEND"] ?? "-",
                            "TRADING":TD["TRADING"] ?? "-",
                            "ISPDF":TD["ISPDF"] ?? "-",
                        ]
                        for temp in resultJSON.dictionaryValue.keys {
                            if resultJSON[temp] == ""{
                                resultJSON[temp] = "-"
                            }
                        }
                        resultJSON1["\(TD["ID"]!)"] = resultJSON
                    }
//                        print(resultJSON1)
                    onTestResult(param: param, result: resultJSON1)
                }
            }
            //财联社-个股资讯详情
            if mRequest.requestType == "clsnews"{
                if let TD: NSDictionary = f10Response.jsonObject as? NSDictionary{
                        resultJSON = [
                            "ID":TD["ID"] ?? "-",
                            "PUBDATE":TD["PUBDATE"] ?? "-",
                            "TITLE":TD["TITLE"] ?? "-",
                            "CONTENT":TD["CONTENT"] ?? "-",
                            "BRIEF":TD["BRIEF"] ?? "-",
                            "STOCKS":TD["STOCKS"] ?? "-",
                            "TOPICS":TD["TOPICS"] ?? "-",
                            "PURL":TD["PURL"] ?? "-",
                        ]
                        for temp in resultJSON.dictionaryValue.keys {
                            if resultJSON[temp] == ""{
                                resultJSON[temp] = "-"
                            }
                        }
//                        print(resultJSON1)
                    onTestResult(param: param, result: resultJSON)
                }
            }
            //财联社-个股研报列表
            if mRequest.requestType == "clsreportlist"{
                if let dic1: NSDictionary = f10Response.jsonObject as? NSDictionary{
                    resultJSON1 = [
                        "Cnt":dic1["Cnt"] ?? "-",
                        "OverPage":dic1["OverPage"] ?? "-",
                    ]
                    for temp in resultJSON1.dictionaryValue.keys {
                        if resultJSON1[temp] == ""{
                            resultJSON1[temp] = "-"
                        }
                    }
                    let list: NSArray = dic1["List"] as! NSArray
                    for i in 0..<list.count{
                        let TD: NSDictionary = list[i] as! NSDictionary
                        resultJSON = [
                            "ID":TD["ID"] ?? "-",
                            "PUBDATE":TD["PUBDATE"] ?? "-",
                            "TITLE":TD["TITLE"] ?? "-",
                            "BRIEF":TD["BRIEF"] ?? "-",
                            "TRADING":TD["TRADING"] ?? "-",
                        ]
                        for temp in resultJSON.dictionaryValue.keys {
                            if resultJSON[temp] == ""{
                                resultJSON[temp] = "-"
                            }
                        }
                        resultJSON1["\(TD["ID"]!)"] = resultJSON
                    }
//                        print(resultJSON1)
                    onTestResult(param: param, result: resultJSON1)
                }
            }
            //财联社-个股研报详情
            if mRequest.requestType == "clsreport"{
                if let TD: NSDictionary = f10Response.jsonObject as? NSDictionary{
                        resultJSON = [
                            "ID":TD["ID"] ?? "-",
                            "PUBDATE":TD["PUBDATE"] ?? "-",
                            "TITLE":TD["TITLE"] ?? "-",
                            "BRIEF":TD["BRIEF"] ?? "-",
                            "CONTENT":TD["CONTENT"] ?? "-",
                            "STOCKS":TD["STOCKS"] ?? "-",
                            "TOPICS":TD["TOPICS"] ?? "-",
                        ]
                        for temp in resultJSON.dictionaryValue.keys {
                            if resultJSON[temp] == ""{
                                resultJSON[temp] = "-"
                            }
                        }
//                        print(resultJSON1)
                    onTestResult(param: param, result: resultJSON)
                }
            }
            //财联社-个股公告列表
            if mRequest.requestType == "clsbulletinlist"{
                if let dic1: NSDictionary = f10Response.jsonObject as? NSDictionary{
                    resultJSON1 = [
                        "Cnt":dic1["Cnt"] ?? "-",
                        "OverPage":dic1["OverPage"] ?? "-",
                    ]
                    for temp in resultJSON1.dictionaryValue.keys {
                        if resultJSON1[temp] == ""{
                            resultJSON1[temp] = "-"
                        }
                    }
                    let list: NSArray = dic1["List"] as! NSArray
                    for i in 0..<list.count{
                        let TD: NSDictionary = list[i] as! NSDictionary
                        resultJSON = [
                            "ID":TD["ID"] ?? "-",
                            "PUBDATE":TD["PUBDATE"] ?? "-",
                            "TITLE":TD["TITLE"] ?? "-",
                            "BRIEF":TD["BRIEF"] ?? "-",
                            "TRADING":TD["TRADING"] ?? "-",
                            "ISPDF":TD["ISPDF"] ?? "-",
                        ]
                        for temp in resultJSON.dictionaryValue.keys {
                            if resultJSON[temp] == ""{
                                resultJSON[temp] = "-"
                            }
                        }
                        resultJSON1["\(TD["ID"]!)"] = resultJSON
                    }
//                        print(resultJSON1)
                    onTestResult(param: param, result: resultJSON1)
                }
            }
            //财联社-个股公告详情
            if mRequest.requestType == "clsbulletin"{
                if let TD: NSDictionary = f10Response.jsonObject as? NSDictionary{
                        resultJSON = [
                            "ID":TD["ID"] ?? "-",
                            "PUBDATE":TD["PUBDATE"] ?? "-",
                            "TITLE":TD["TITLE"] ?? "-",
                            "BRIEF":TD["BRIEF"] ?? "-",
                            "CONTENT":TD["CONTENT"] ?? "-",
                            "STOCKS":TD["STOCKS"] ?? "-",
                            "TOPICS":TD["TOPICS"] ?? "-",
                            "URL":TD["URL"] ?? "-",
                        ]
                        for temp in resultJSON.dictionaryValue.keys {
                            if resultJSON[temp] == ""{
                                resultJSON[temp] = "-"
                            }
                        }
//                        print(resultJSON1)
                    onTestResult(param: param, result: resultJSON)
                }
            }
            //财联社-风口列表
            if mRequest.requestType == "clsrecommendlist"{
                if let dic1: NSDictionary = f10Response.jsonObject as? NSDictionary{
                    resultJSON1 = [
                        "Page":dic1["Page"] ?? "-",
                        "PageNumber":dic1["PageNumber"] ?? "-",
                    ]
                    for temp in resultJSON1.dictionaryValue.keys {
                        if resultJSON1[temp] == ""{
                            resultJSON1[temp] = "-"
                        }
                    }
                    let list: NSArray = dic1["List"] as! NSArray
                    for i in 0..<list.count{
                        let TD: NSDictionary = list[i] as! NSDictionary
                        resultJSON = [
                            "ID":TD["ID"] ?? "-",
                            "PUBDATE":TD["PUBDATE"] ?? "-",
                            "TITLE":TD["TITLE"] ?? "-",
                            "BRIEF":TD["BRIEF"] ?? "-",
                            "STOCKS":TD["STOCKS"] ?? "-",
                            "TOPICS":TD["TOPICS"] ?? "-",
                        ]
                        for temp in resultJSON.dictionaryValue.keys {
                            if resultJSON[temp] == ""{
                                resultJSON[temp] = "-"
                            }
                        }
                        resultJSON1["\(TD["ID"]!)"] = resultJSON
                    }
//                        print(resultJSON1)
                    onTestResult(param: param, result: resultJSON1)
                }
            }
            //财联社-风口详情
            if mRequest.requestType == "clsrecommend"{
                if let TD: NSDictionary = f10Response.jsonObject as? NSDictionary{
                        resultJSON = [
                            "ID":TD["ID"] ?? "-",
                            "PUBDATE":TD["PUBDATE"] ?? "-",
                            "TITLE":TD["TITLE"] ?? "-",
                            "BRIEF":TD["BRIEF"] ?? "-",
                            "CONTENT":TD["CONTENT"] ?? "-",
                            "STOCKS":TD["STOCKS"] ?? "-",
                            "TOPICS":TD["TOPICS"] ?? "-",
                        ]
                        for temp in resultJSON.dictionaryValue.keys {
                            if resultJSON[temp] == ""{
                                resultJSON[temp] = "-"
                            }
                        }
//                        print(resultJSON1)
                    onTestResult(param: param, result: resultJSON)
                }
            }
    }
}
