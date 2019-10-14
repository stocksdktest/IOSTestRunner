//
//  ExampleTestCase2.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/27.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//
//F10通用接口
import XCTest
import os.log
import SwiftyJSON

class F10TestCase: BaseTestCase {
    
    override var stockTestCaseName: StockTestCaseName {
        return StockTestCaseName.F10TestCase
    }
    func testF10() {
        let param = self.testCaseRoundConfig.getParam()
        let mRequest = MF10Request()
        mRequest.code = param["CODE"].stringValue
        mRequest.requestType = param["REQUESTTYPE"].stringValue
        if let typeVal = MF10DataSourceType.init(rawValue:param["SOURCETYPE"].uIntValue) {
            mRequest.sourceType = typeVal
        }
        if param["PARAM"].dictionary != nil{
            mRequest.param = param["PARAM"].dictionary
            
        }
       
        
        let resp = self.makeSyncRequest(request: mRequest)
        let f10Response = resp as! MF10Response
        XCTAssertNotNil(f10Response.jsonObject)
//        print(f10Response.jsonObject)
        if mRequest.requestType == "importantindex"{
            if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                var resultJSON: JSON = [
                    "REPORTTITLE":dic1["REPORTTITLE"]!,
                    "EPSBASIC":dic1["EPSBASIC"]!,
                    "NAPS":dic1["NAPS"]!,
                    "NPCUT":dic1["NPCUT"]!,
                    "TOTALSHARE":dic1["TOTALSHARE"]!,
                    "CIRCSKAMT":dic1["CIRCSKAMT"]!,
                    "BIZINCO":dic1["BIZINCO"]!,
                    "OPERINYOYB":dic1["OPERINYOYB"]!,
                    "NETPROFITYOYB":dic1["NETPROFITYOYB"]!,
                    "DISTRIBUTION":dic1["DISTRIBUTION"]!,
                    "EXRIGHT":dic1["EXRIGHT"]!
                    ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
              }
           }
        if mRequest.requestType == "businessinfo"{
            if let Lists: NSArray = f10Response.jsonObject as! NSArray{
                
                
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "CLASSNAME":dic2["CLASSNAME"]!,
                                "TCOREBIZINCOME":dic2["TCOREBIZINCOME"]!,
                                "TYPESTYLE":dic2["TYPESTYLE"]!,
                                "PUBLISHDATE":dic2["PUBLISHDATE"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                    var resultJSON: JSON = [
                        "list": jsonarr1
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                
                
            }
        }
        if mRequest.requestType == "charts5buys"{
            if let Lists: NSArray = f10Response.jsonObject as! NSArray{
                
                
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "BIZSUNITNAME":dic2["BIZSUNITNAME"]!,
                                "BUYAMT":dic2["BUYAMT"]!,
                                "SALEAMT":dic2["SALEAMT"]!,
                                "TRADEDATE":dic2["TRADEDATE"]!,
                                "CHGDESC":dic2["CHGDESC"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                    var resultJSON: JSON = [
                        "list": jsonarr1
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                
                
            }
        }
        if mRequest.requestType == "charts5sells"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "BIZSUNITNAME":dic2["BIZSUNITNAME"]!,
                                "BUYAMT":dic2["BUYAMT"]!,
                                "SALEAMT":dic2["SALEAMT"]!,
                                "TRADEDATE":dic2["TRADEDATE"]!,
                                "CHGDESC":dic2["CHGDESC"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "exptskinvrating"{
            if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                var resultJSON: JSON = [
                    "STDRATING":dic1["STDRATING"]!
                ]
                if let Lists: NSArray = dic1["list"] as!NSArray{
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "RATING": dic2["RATING"]!,
                                "COMPNAME":dic2["COMPNAME"]!,
                                "RADJUSTDIR":dic2["RADJUSTDIR"]!,
                                "DATE":dic2["DATE"]!,
                                "PRICECAP":dic2["PRICECAP"]!
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                    resultJSON["list"].arrayObject = jsonarr1
                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "exptskstatn"{
            if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                var resultJSON: JSON = [
                    "TMBIZINCOME":dic1["TMBIZINCOME"]!,
                    "NMBIZINCOME":dic1["NMBIZINCOME"]!,
                    "YANMBIZINCOME":dic1["YANMBIZINCOME"]!,
                    "MAINBIZINCOMEYOY1":dic1["MAINBIZINCOMEYOY1"]!,
                    "MAINBIZINCOMEYOY2":dic1["MAINBIZINCOMEYOY2"]!,
                    "MAINBIZINCOMEYOY3":dic1["MAINBIZINCOMEYOY3"]!,
                    "TNETPROFIT":dic1["TNETPROFIT"]!,
                    "NNETPROFIT":dic1["NNETPROFIT"]!
                ]
                let update1: JSON = [
                    "YANNETPROFIT":dic1["YANNETPROFIT"]!,
                    "NETPROFITYOY1":dic1["NETPROFITYOY1"]!,
                    "NETPROFITYOY2":dic1["NETPROFITYOY2"]!,
                    "NETPROFITYOY3":dic1["NETPROFITYOY3"]!,
                    "TEPS":dic1["TEPS"]!,
                    "NEPS":dic1["NEPS"]!,
                    "YANEPS":dic1["YANEPS"]!,
                    "TENDDATE":dic1["TENDDATE"]!,
                    "NENDDATE":dic1["NENDDATE"]!,
                    "YANENDDATE":dic1["YANENDDATE"]!
                ]
                do {
                    try resultJSON.merge(with: update1)
                } catch {
                    // ignore
                }
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "companyinfo"{
            if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                var resultJSON: JSON = [
                    "LISTDATE":dic1["LISTDATE"]!,
                    "LISTOPRICE":dic1["LISTOPRICE"]!,
                    "FCLEVEL2NAME":dic1["FCLEVEL2NAME"]!,
                    "COMPNAME":dic1["COMPNAME"]!,
                    "CHAIRMAN":dic1["CHAIRMAN"]!,
                    "BSECRETARY":dic1["BSECRETARY"]!,
                    "BSECRETARYMAIL":dic1["BSECRETARYMAIL"]!,
                    "REGADDR":dic1["REGADDR"]!,
                    "ISSPRICE":dic1["ISSPRICE"]!,
                    "SWLEVEL2NAME":dic1["SWLEVEL2NAME"]!
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "sharebonus"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "DATETYPENAME":dic2["DATETYPENAME"]!,
                                "PRETAXCASHMAXDVCNY":dic2["PRETAXCASHMAXDVCNY"]!,
                                "EQURECORDDATE":dic2["EQURECORDDATE"]!,
                                "XDRDATE":dic2["XDRDATE"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "companymanager"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "CNAME":dic2["CNAME"]!,
                                "DUTY":dic2["DUTY"]!,
                                "HOLDAFAMT":dic2["HOLDAFAMT"]!,
                                "REMBEFTAX":dic2["REMBEFTAX"]!,
                                "BEGINEND":dic2["BEGINEND"]!,
                                "MEMO":dic2["MEMO"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "otsholder10"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "ENDDATE":dic2["ENDDATE"]!,
                                "SHHOLDERNAME":dic2["SHHOLDERNAME"]!,
                                "HOLDERAMT":dic2["SHHOLDERCODE"]!,
                                "PCTOFFLOTSHARES":dic2["HOLDERAMT"]!,
                                "HOLDERSUMCHG":dic2["PCTOFFLOTSHARES"]!,
                                "SHHOLDERCODE":dic2["HOLDERSUMCHG"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "shareholder10"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "ENDDATE":dic2["ENDDATE"]!,
                                "SHHOLDERNAME":dic2["SHHOLDERNAME"]!,
                                "HOLDERAMT":dic2["SHHOLDERCODE"]!,
                                "PCTOFFLOTSHARES":dic2["HOLDERAMT"]!,
                                "CURCHG":dic2["HOLDERRTO"]!,
                                "SHHOLDERCODE":dic2["CURCHG"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "shareinfo"{
            if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                var resultJSON: JSON = [
                    "TOTALSHARE":dic1["TOTALSHARE"]!,
                    "CIRCSKAMT":dic1["CIRCSKAMT"]!,
                    "RELANAME":dic1["RELANAME"]!,
                    "SHHOLDERNAME":dic1["SHHOLDERNAME"]!,
                    "HOLDERRTO":dic1["HOLDERRTO"]!,
                    "TOTALSHRTO":dic1["TOTALSHRTO"]!,
                    "TOTALSHAMT":dic1["TOTALSHAMT"]!
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "shareholdernum"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "ENDDATE":dic2["ENDDATE"]!,
                                "TOTALSHAMT":dic2["TOTALSHAMT"]!,
                                "KAVGSH":dic2["KAVGSH"]!,
                                "MOM":dic2["MOM"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "profinmainindex"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "REPORTTITLE":dic2["REPORTTITLE"]!,
                                "EPSBASIC":dic2["EPSBASIC"]!,
                                "EPSDILUTED":dic2["EPSDILUTED"]!,
                                "NAPS":dic2["NAPS"]!,
                                "UPPS":dic2["UPPS"]!,
                                "CRPS":dic2["CRPS"]!,
                                "SGPMARGIN":dic2["SGPMARGIN"]!,
                                "OPPRORT":dic2["OPPRORT"]!,
                                "SNPMARGIN":dic2["SNPMARGIN"]!,
                                "ROEWEIGHTED":dic2["ROEWEIGHTED"]!,
                                "ROEDILUTED":dic2["ROEDILUTED"]!,
                                "CURRENTRT":dic2["CURRENTRT"]!,
                                "QUICKRT":dic2["QUICKRT"]!,
                                "OPNCFPS":dic2["OPNCFPS"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "proincstatementnew"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "REPORTTITLE":dic2["REPORTTITLE"]!,
                                "BIZINCO":dic2["BIZINCO"]!,
                                "BIZCOST":dic2["BIZCOST"]!,
                                "MANAEXPE":dic2["MANAEXPE"]!,
                                "SALESEXPE":dic2["SALESEXPE"]!,
                                "FINEXPE":dic2["FINEXPE"]!,
                                "PERPROFIT":dic2["PERPROFIT"]!,
                                "INVEINCO":dic2["INVEINCO"]!,
                                "NONOPERINCOMEN":dic2["NONOPERINCOMEN"]!,
                                "TOTPROFIT":dic2["TOTPROFIT"]!,
                                "PARENETP":dic2["PARENETP"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "probalsheetnew"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "REPORTTITLE":dic2["REPORTTITLE"]!,
                                "TOTLIABSHAREQUI":dic2["TOTLIABSHAREQUI"]!,
                                "TOTCURRASSET":dic2["TOTCURRASSET"]!,
                                "CURFDS":dic2["CURFDS"]!,
                                "TRADFINASSET":dic2["TRADFINASSET"]!,
                                "INVE":dic2["INVE"]!,
                                "ACCORECE":dic2["ACCORECE"]!,
                                "OTHERRECE":dic2["OTHERRECE"]!,
                                "FIXEDASSENET":dic2["FIXEDASSENET"]!
                            ]
                            let update1: JSON = [
                                "AVAISELLASSE":dic2["AVAISELLASSE"]!,
                                "INTAASSET":dic2["INTAASSET"]!,
                                "SHORTTERMBORR":dic2["SHORTTERMBORR"]!,
                                "ADVAPAYM":dic2["ADVAPAYM"]!,
                                "ACCOPAYA":dic2["ACCOPAYA"]!,
                                "TOTALCURRLIAB":dic2["TOTALCURRLIAB"]!,
                                "SUNEVENNONCLIAB":dic2["SUNEVENNONCLIAB"]!,
                                "TOTLIAB":dic2["TOTLIAB"]!,
                                "PARESHARRIGH":dic2["PARESHARRIGH"]!,
                                "CAPISURP":dic2["CAPISURP"]!,
                                "GOODWILL":dic2["GOODWILL"]!
                            ]
                            do {
                                try jsonarr2.merge(with: update1)
                            } catch {
                                // ignore
                            }
                            jsonarr1.append(jsonarr2)
                        }
                    }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "procfstatementnew"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "REPORTTITLE":dic2["REPORTTITLE"]!,
                                "BIZCASHINFL":dic2["BIZCASHINFL"]!,
                                "BIZCASHOUTF":dic2["BIZCASHOUTF"]!,
                                "MANANETR":dic2["MANANETR"]!,
                                "INVCASHINFL":dic2["INVCASHINFL"]!,
                                "INVCASHOUTF":dic2["INVCASHOUTF"]!,
                                "INVNETCASHFLOW":dic2["INVNETCASHFLOW"]!,
                                "FINCASHINFL":dic2["OTHERRECE"]!,
                                "FINCASHOUTF":dic2["FINCASHOUTF"]!,
                                "FINNETCFLOW":dic2["FINNETCFLOW"]!,
                                "CASHNETR":dic2["CASHNETR"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "blocktrade"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "TRADEDATE":dic2["TRADEDATE"]!,
                                "TRADEPRICE":dic2["TRADEPRICE"]!,
                                "VOLUME":dic2["VOLUME"]!,
                                "AMOUNT":dic2["AMOUNT"]!,
                                "PRC":dic2["PRC"]!,
                                "BUYERNAME":dic2["BUYERNAME"]!,
                                "SELLERNAME":dic2["SELLERNAME"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "iinvholdchg"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "REPORTDATE":dic2["REPORTDATE"]!,
                                "TRADING":dic2["TRADING"]!,
                                "SESNAME":dic2["SESNAME"]!,
                                "SETYPENAME":dic2["SETYPENAME"]!,
                                "HOLDQTY":dic2["HOLDQTY"]!,
                                "HOLDAMT":dic2["HOLDAMT"]!,
                                "HOLDQTYSUMCHG":dic2["HOLDQTYSUMCHG"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "importnoticedate"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "REPTITLE":dic2["REPTITLE"]!,
                                "TRADEDATE":dic2["TRADEDATE"]!,
                                "TEXT":dic2["TEXT"]!
                                
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "importnoticetitlbe"{
            if let Lists:NSArray = f10Response.jsonObject as! NSArray{
                
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "REPTITLE":dic2["REPTITLE"]!,
                                "TRADEDATE":dic2["TRADEDATE"]!,
                                "TEXT":dic2["TEXT"]!
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                var resultJSON: JSON = [
                    "list": jsonarr1
                ]
                
                print(resultJSON)
                onTestResult(param: param, result: resultJSON)
            }
        }
        if mRequest.requestType == "exptperformance"{
            if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                
                if let Lists: NSArray = dic1["List"] as!NSArray{
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "SESNAME":dic2["SESNAME"]!,
                                "PUBLISHDATE":dic2["PUBLISHDATE"]!,
                                "RETAMAXPROFITSMK":dic2["RETAMAXPROFITSMK"]!,
                                "RETAMAXPROFITSINC":dic2["RETAMAXPROFITSINC"]!
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                    var resultJSON: JSON = [
                        "list": jsonarr1
                    ]
                    
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
                
            }
        }
        if mRequest.requestType == "proindicdata"{
            if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                
                if let Lists: NSArray = dic1["List"] as!NSArray{
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "SESNAME":dic2["SESNAME"]!,
                                "PUBLISHDATE":dic2["PUBLISHDATE"]!,
                                "EPSBASIC":dic2["EPSBASIC"]!,
                                "TAGRT":dic2["TAGRT"]!,
                                "NPGRT":dic2["NPGRT"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                    var resultJSON: JSON = [
                        "list": jsonarr1
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
                
            }
        }
        if mRequest.requestType == "newsinteractive"{
            if let dic1: NSDictionary = f10Response.jsonObject as! NSDictionary{
                
                if let Lists: NSArray = dic1["List"] as!NSArray{
                    var jsonarr1 = [JSON]()
                    for List in Lists{
                        if let dic2 : NSDictionary = List as! NSDictionary{
                            var jsonarr2: JSON = [
                                "TRADING":dic2["TRADING"]!,
                                "SESNAME":dic2["SESNAME"]!,
                                "PROBLEM":dic2["PROBLEM"]!,
                                "QUESTIONTIME":dic2["QUESTIONTIME"]!,
                                "REPLY":dic2["REPLY"]!,
                                "ANSWERTIME":dic2["ANSWERTIME"]!,
                                "NEWSSOURCE":dic2["NEWSSOURCE"]!,
                                "INTERACTIVEID":dic2["PageNumber"]!,
                            ]
                            jsonarr1.append(jsonarr2)
                        }
                    }
                    var resultJSON: JSON = [
                        "list": jsonarr1
                    ]
                    print(resultJSON)
                    onTestResult(param: param, result: resultJSON)
                }
                
            }
        }
}
}



