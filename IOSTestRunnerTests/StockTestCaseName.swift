//
//  StockTestcaseName.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/25.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

#if !swift(>=4.2)
    public protocol CaseIterable {
        associatedtype AllCases: Collection where AllCases.Element == Self
        static var allCases: AllCases { get }
    }
    extension CaseIterable where Self: Hashable {
        static var allCases: [Self] {
            return [Self](AnySequence { () -> AnyIterator<Self> in
                var raw = 0
                var first: Self?
                return AnyIterator {
                    let current = withUnsafeBytes(of: &raw) { $0.load(as: Self.self) }
                    if raw == 0 {
                        first = current
                    } else if current == first {
                        return nil
                    }
                    raw += 1
                    return current
                }
            })
        }
    }
#endif

enum StockTestCaseName: String, CaseIterable {
    case QUOTE_REQUEST_EXAMPLE = "TESTCASE_0"
    case QUOTEDETAIL_1 = "QUOTEDETAIL_1"
    case QUOTEDETAIL_2 = "QUOTEDETAIL_2"
    case PlateIndexQuoteTestCase = "PlateIndexQuoteTestCase"
    case AHLIST_1 = "AHLIST_1"
    case AHLIST_2 = "AHLIST_2"
    case AHQUOTE_1 = "AHQUOTE_1"
    case QUOTE_1 = "QUOTE_1"
    case QUOTE_2 = "QUOTE_2"
    case CHARTV2TEST_1 = "CHARTV2TEST_1"
    case CHARTV2TEST_2 = "CHARTV2TEST_2"
    case CHARTV2TEST_3 = "CHARTV2TEST_3"
    case CHARTV2TEST_4 = "CHARTV2TEST_4"
    case CHARTV2TEST_5 = "CHARTV2TEST_5"
    case CHARTV2TEST_6 = "CHARTV2TEST_6"
    case ADDVALUE_1 = "ADDVALUE_1"
    case ADDVALUE_2 = "ADDVALUE_2"
    case ADDVALUE_3 = "ADDVALUE_3"
    case OFFERQUOTE_2 = "OFFERQUOTE_2"
    case OFFERQUOTE_1 = "OFFERQUOTE_1"
    case TRADEQUOTE_1 = "TRADEQUOTE_1"
    case HKPRICEINFO_1 = "HKPRICEINFO_1"
    case HSAMOUNT_1 = "HSAMOUNT_1"
    case TRADEDATE_1 = "TRADEDATE_1"
    case TRADEDATE_2 = "TRADEDATE_2"
    case SUBNEWBONDSTOCKRANKING_1 = "SUBNEWBONDSTOCKRANKING_1"
    case SUBNEWSTOCKRANKING_1 = "SUBNEWSTOCKRANKING_1"
    case DRQUOTELIST_1 = "DRQUOTELIST_1"
    case DRLINKQUOTE_1 = "DRLINKQUOTE_1"
    case CHARTSUB_2 = "CHARTSUB_2"
    case CHARTSUB_1 = "CHARTSUB_1"
    case HKMARINFO_1 = "HKMARINFO_1"
    case StaticDataTestCase = "StaticDataTestCase"
    case HOLIDAY_1 = "HOLIDAY_1"
    case HKSTOCKINFO_1 = "HKSTOCKINFO_1"
    case ORDERQUANTITY_1 = "ORDERQUANTITY_1"
    case ORDERQUANTITY_2 = "ORDERQUANTITY_2" 
    case MOREPRICE_1 = "MOREPRICE_1"
    case MOREPRICE_2 = "MOREPRICE_2"
    case EventTestCase = "EventTestCase"
    case OPTIONTQUOTE_1 = "OPTIONTQUOTE_1"
    case OPTIONQUOTE_1 = "OPTIONQUOTE_1"
    case OPTIONEXPIRE_1 = "OPTIONEXPIRE_1"
    case OPTIONLIST_1 = "OPTIONLIST_1"
    case SEARTEST_1 = "SEARTEST_1"
    case SEARTEST_2 = "SEARTEST_2"
    case SEARTEST_3 = "SEARTEST_3"
    case SEARTEST_4 = "SEARTEST_4"
    case SEARTEST_5 = "SEARTEST_5"
    case OHLCV3_1 = "OHLCV3_1"
    case OHLCV3_2 = "OHLCV3_2"
    case OHLCV3_3 = "OHLCV3_3"
    case OHLCV3_4 = "OHLCV3_4"
    case OHLCV3_5 = "OHLCV3_5"
    case OHLCV3_6 = "OHLCV3_6"
    case OHLCTestCase = "OHLCTestCase"
    case BIDCHART_1 = "BIDCHART_1"
    case BIDCHART_2 = "BIDCHART_2"
    case HISTORYCHART_1 = "HISTORYCHART_1"
    case HISTORYCHART_2 = "HISTORYCHART_2"
    case AFTERHOURSCHART_1 = "AFTERHOURSCHART_1"
    case AFTERHOURSCHART_2 = "AFTERHOURSCHART_2"
    case CATESORTING_1 = "CATESORTING_1"
    case CATESORTING_2 = "CATESORTING_2"
    case CATESORTING_3 = "CATESORTING_3"
    case CATEQUOTE_1 = "CATEQUOTE_1"
    case BANKUAIQUOTE_1 = "BANKUAIQUOTE_1"
    case BANKUAISORTING_1 = "BANKUAISORTING_1"
    case BANKUAISORTING_2 = "BANKUAISORTING_2"
    case MARKETUPDOWN_1 = "MARKETUPDOWN_1"
    case COMPOUNDUPDOWN_1 = "COMPOUNDUPDOWN_1"
    case UPDOWNS_1 = "UPDOWNS_1"
    case CONVERTIBLE_1 = "CONVERTIBLE_1"
    case UKQUOTE_1 = "UKQUOTE_1"
    case TICK_1 = "TICK_1"
    case TICK_2 = "TICK_2"
    case OVERLAYCHART_1 = "OVERLAYCHART_1"
    case OVERLAYCHART_2 = "OVERLAYCHART_2"
    case OHLCSUB_1 = "OHLCSUB_1"
    case L2TICKV2_1 = "L2TICKV2_1"
    case L2TICKV2_2 = "L2TICKV2_2"
    case L2TICKDETAILV2_1 = "L2TICKDETAILV2_1"
    case L2TICKDETAILV2_2 = "L2TICKDETAILV2_2"
    case SEARV2TEST_1 = "SEARV2TEST_1"
    case SEARV2TEST_2 = "SEARV2TEST_2"
    case MOREVOLUMETEST_1 = "MOREVOLUMETEST_1"
    case BROKERINFO_1 = "BROKERINFO_1"
//    ///////////////////F10//////////////
    case  F10TestCase = "F10TestCase"
    case  F10_NEWINDEX_1 = "F10_NEWINDEX_1"
    case  F10_IMPORTANTNOTICE_1 = "F10_IMPORTANTNOTICE_1"
    case  F10_BONUSFINANCE_1 = "F10_BONUSFINANCE_1"
    case  F10_TRADEDETAIL_1 = "F10_TRADEDETAIL_1"
    case  F10_FORECASTYEAR_1 = "F10_FORECASTYEAR_1"
    case  F10_FORECASTRATING_1 = "F10_FORECASTRATING_1"
    case  F10_COMPANYINFO_1 = "F10_COMPANYINFO_1"
    case  F10_COREBUSINESS_1 = "F10_COREBUSINESS_1"
    case  F10_LEADERPERSONINFO_1 = "F10_LEADERPERSONINFO_1"
    case  F10_MAINFINAINDEXNAS_1 = "F10_MAINFINAINDEXNAS_1"
    case  F10_MAINFINAINDEXNAS_2 = "F10_MAINFINAINDEXNAS_2"
    case  F10_MAINFINADATANASS_1 = "F10_MAINFINADATANASS_1"
    case  F10_MAINFINADATANASS_2 = "F10_MAINFINADATANASS_2"
    case  F10_STOCKSHAREINFO_1 = "F10_STOCKSHAREINFO_1"
    case  F10_STOCKSHARECHANGEINFO_1 = "F10_STOCKSHARECHANGEINFO_1"
    case  F10_SHAREHOLDERHISTORYINFO_1 = "F10_SHAREHOLDERHISTORYINFO_1"
    case  F10_TOPLIQUIDSHAREHOLDER_1 = "F10_TOPLIQUIDSHAREHOLDER_1"
    case  F10_TOPSHAREHOLDER_1 = "F10_TOPSHAREHOLDER_1"
    case  F10_FUNDSHAREHOLDERINFO_1 = "F10_FUNDSHAREHOLDERINFO_1"
    case  F10_NEWSLIST_1 = "F10_NEWSLIST_1"
    case  F10_NEWS_1 = "F10_NEWS_1"
    case  F10_STOCKBULLETINLIST_1 = "F10_STOCKBULLETINLIST_1"
    case F10_STOCKBULLETINLIST_2 = "F10_STOCKBULLETINLIST_2"
    case  F10_STOCKBULLETIN_1 = "F10_STOCKBULLETIN_1"
    case  F10_STOCKNEWSLIST_1 = "F10_STOCKNEWSLIST_1"
    case F10_STOCKNEWSLIST_2 = "F10_STOCKNEWSLIST_2"
    case  F10_STOCKNEWS_1 = "F10_STOCKNEWS_1"
    case  F10_STOCKREPORTLIST_1 = "F10_STOCKREPORTLIST_1"
    case F10_STOCKREPORTLIST_2 = "F10_STOCKREPORTLIST_2"
    case  F10_STOCKREPORT_1 = "F10_STOCKREPORT_1"
    case  F10_NEWSHARELIST_1 = "F10_NEWSHARELIST_1"
    case  F10_BNDNEWSHARESCAL_1 = "F10_BNDNEWSHARESCAL_1"
    case F10_CALENDAR_1 = "F10_CALENDAR_1"
    case  F10_BONDTRADINGDAY_1 = "F10_BONDTRADINGDAY_1"
    case  F10_NEWSHAREDETAIL_1 = "F10_NEWSHAREDETAIL_1"
    case F10_BNDSHAREIPODETAI_1 =  "F10_BNDSHAREIPODETAI_1"
    case  F10_FNDNAVINDEX_1 = "F10_FNDNAVINDEX_1"
    case  F10_FUNDBASIC_1 = "F10_FUNDBASIC_1"
    case  F10_FUNDVALUE_1 = "F10_FUNDVALUE_1"
    case  F10_ASSETALLOCATION_1 = "F10_ASSETALLOCATION_1"
    case  F10_INDUSTRYPORTFOLIO_1 = "F10_INDUSTRYPORTFOLIO_1"
    case  F10_STOCKPORTFOLIO_1 = "F10_STOCKPORTFOLIO_1"
    case  F10_SHARESTRUCTURE_1 = "F10_SHARESTRUCTURE_1"
    case  F10_FNDFINANCE_1 = "F10_FNDFINANCE_1"
    case  F10_FNDDIVIDEEND_1 = "F10_FNDDIVIDEEND_1"
    case  F10_BONDBASIC_1 = "F10_BONDBASIC_1"
    case  F10_BNDINTERESTPAY_1 = "F10_BNDINTERESTPAY_1"
    case  F10_BNDBUYBACKS_1 = "F10_BNDBUYBACKS_1"
    case  F10_STRUCTUREDFUND_1 = "F10_STRUCTUREDFUND_1"
    case  MarginInfoTestCase = "MarginInfoTestCase"
    case F10_FINANCEMRGNIN_3 = "F10_FINANCEMRGNIN_3"
    case  F10_FINANCEMRGNIN_2 = "F10_FINANCEMRGNIN_2"
    case F10_FINANCEMRGNIN_1 = "F10_FINANCEMRGNIN_1"
    case  MarginInfoShareTestCase = "MarginInfoShareTestCase"
    case F10_BLOCKTRADE_1 = "F10_BLOCKTRADE_1"
    case F10V2TEST_1 = "F10V2TEST_1"
    case F10V2TEST_2 = "F10V2TEST_2"
    case F10V2TEST_3 = "F10V2TEST_3"
    case F10V2TEST_4 = "F10V2TEST_4"
    static func fromString(_ str: String) -> StockTestCaseName? {
        return self.allCases.first{ $0.rawValue == str }
    }
}
